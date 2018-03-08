/*
 * Copyright 2014-2018 NTT Corporation.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */
package jp.co.ntt.atrs.batch.jbbb01003;

import jp.co.ntt.atrs.batch.common.exception.AtrsBatchException;
import jp.co.ntt.atrs.batch.common.logging.LogMessages;
import jp.co.ntt.atrs.batch.jbbb00.AggregationPeriodDto;
import jp.co.ntt.atrs.batch.jbbb00.AggregationPeriodUtil;

import org.dozer.Mapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.batch.core.ExitStatus;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.validation.BindException;
import org.springframework.validation.FieldError;
import org.springframework.batch.item.ItemStreamException;
import org.springframework.batch.item.ItemStreamWriter;
import org.springframework.batch.item.validator.ValidationException;
import org.springframework.batch.item.validator.Validator;

import java.io.File;
import java.util.Arrays;
import java.util.List;

import javax.inject.Inject;

/**
 * 集計期間内の運賃種別搭乗者情報をCSVファイルに出力する。
 * 
 * @author 電電次郎
 */
@Component("JBBB01003Tasklet")
@Scope("step")
public class JBBB01003Tasklet implements Tasklet {
    /**
     * メッセージ出力に利用するログ機能を提供するインタフェース。
     */
    private static final Logger LOGGER = LoggerFactory.getLogger(JBBB01003Tasklet.class);

    /**
     * 入力チェック用のバリデータ。
     */
    @Inject
    Validator<FareTypeAggregationResultDto> validator;

    /**
     * メッセージ管理機能。
     */
    @Inject
    MessageSource messageSource;

    /**
     * バックアップファイル操作機能で提供する処理のインターフェース。
     */
    @Inject
    ItemStreamWriter<FareTypeAggregationDto> fareTypeAggregationWriter;

    /**
     * 運賃種別搭乗者情報集計DAOインタフェース。
     */
    @Inject
    JBBB01003Dao dao;

    /**
     * Beanマッパー。
     */
    @Inject
    Mapper beanMapper;

    /**
     * ジョブパラメータ 集計開始日
     */
    @Value("#{jobParameters['firstDateStr']}")
    private String firstDateStr;

    /**
     * ジョブパラメータ 集計終了日
     */
    @Value("#{jobParameters['lastDateStr']}")
    private String lastDateStr;

    /**
     * ユーザーの現在の作業ディレクトリ
     */
    @Value("${user.dir}")
    private String userDir;

    /**
     * 運賃種別搭乗者集計結果ファイルパス。
     */
    @Value("${path.FareTypeAggregationData}")
    private String PATH_FARETYPE_AGGREGATION_DATA;

    @Override
    public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {

        // 出力ファイルパスの取得
        String outputFilePath = new File(userDir, PATH_FARETYPE_AGGREGATION_DATA).getPath();

        int outputLineCount = 0;

        // 集計期間の取得・設定
        AggregationPeriodDto aggregationPeriod = AggregationPeriodUtil.create(firstDateStr, lastDateStr);
        if (aggregationPeriod == null) {
            // ジョブ終了コード（100:異常終了）
            contribution.setExitStatus(new ExitStatus("BUSINESS_ERROR"));
            return RepeatStatus.FINISHED;
        }

        try {
            // ファイルオープン
            fareTypeAggregationWriter.open(chunkContext.getStepContext().getStepExecution().getExecutionContext());

            // DBからデータを取得
            List<FareTypeAggregationResultDto> items = dao.findFareTypeAggregationByDepartureDateList(aggregationPeriod);

            if (items.size() == 0) {
                // 取得件数が0件（2:正常終了）
                LOGGER.warn(LogMessages.W_AR_BB01_L2002.getMessage());
                contribution.setExitStatus(new ExitStatus("NORMAL_NONE_TARGET"));
                return RepeatStatus.FINISHED;
            }

            // 次要素にデータが存在するまで処理を繰り返す
            for (FareTypeAggregationResultDto inputData : items) {
                try {
                    // 入力チェック
                    validator.validate(inputData);
                } catch (ValidationException e) {
                    // FieldErrorsの個数分、以下の処理を繰り返す
                    for (FieldError fieldError : ((BindException) e.getCause()).getFieldErrors()) {
                        // 入力チェックエラーメッセージを出力
                        LOGGER.warn(messageSource.getMessage(fieldError, null) + "[" + fieldError.getRejectedValue()
                                + "]" + "(" + inputData.toString() + ")");
                    }

                    // 入力チェックエラー（100:異常終了）
                    LOGGER.error(LogMessages.E_AR_FW_L9003.getMessage(), e);
                    contribution.setExitStatus(new ExitStatus("BUSINESS_ERROR"));
                    return RepeatStatus.FINISHED;
                }

                // DTOの詰め替え処理
                FareTypeAggregationDto printData = beanMapper.map(inputData, FareTypeAggregationDto.class);

                // ファイル書き込み
                try {
                    fareTypeAggregationWriter.write(Arrays.asList(printData));
                } catch (Exception e) {
                    // ファイル書込みエラー（100:異常終了）
                    LOGGER.error(LogMessages.E_AR_FW_L9001.getMessage(outputFilePath), e);
                    contribution.setExitStatus(new ExitStatus("BUSINESS_ERROR"));
                    return RepeatStatus.FINISHED;
                }

                // 出力件数カウントアップ
                outputLineCount++;
            }
        } catch (ItemStreamException e) {
            // ファイルオープンエラー
            LOGGER.error(LogMessages.E_AR_FW_L9006.getMessage());
            throw new AtrsBatchException(e);
        } finally {
            try {
                // ファイルクローズ
                fareTypeAggregationWriter.close();
            } catch (ItemStreamException e) {
                // クローズ失敗
                if (LOGGER.isDebugEnabled()) {
                    LOGGER.debug("クローズ失敗", e);
                }
            }
        }

        // 出力先ファイルとファイル出力件数をログに出力
        LOGGER.info(LogMessages.I_AR_FW_L0003.getMessage(outputFilePath, outputLineCount));

        // ジョブ終了コード（0:正常終了）
        contribution.setExitStatus(new ExitStatus("NORMAL"));
        return RepeatStatus.FINISHED;
    }
}
