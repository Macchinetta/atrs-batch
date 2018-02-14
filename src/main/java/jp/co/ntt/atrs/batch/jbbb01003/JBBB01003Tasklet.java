/*
 * Copyright 2014-2017 NTT Corporation.
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
 * �?計期間�??の運�?種別搭乗�??�?報をCSVファイルに出力する�??
 * 
 * @author 電電次�?
 */
@Component("JBBB01003Tasklet")
@Scope("step")
public class JBBB01003Tasklet implements Tasklet {
    /**
     * メ�?セージ出力に利用するログ機�?�を提供するインタフェース�?
     */
    private static final Logger LOGGER = LoggerFactory.getLogger(JBBB01003Tasklet.class);

    /**
     * 入力チェ�?ク用のバリ�?ータ�?
     */
    @Inject
    Validator<FareTypeAggregationResultDto> validator;

    /**
     * メ�?セージ管�?機�?��?
     */
    @Inject
    MessageSource messageSource;

    /**
     * バックア�?プファイル操作機�?�で提供する�?��?のインターフェース�?
     */
    @Inject
    ItemStreamWriter<FareTypeAggregationDto> fareTypeAggregationWriter;

    /**
     * 運�?種別搭乗�??�?報�?�?DAOインタフェース�?
     */
    @Inject
    JBBB01003Dao dao;

    /**
     * Beanマッパ�?��?
     */
    @Inject
    Mapper beanMapper;

    /**
     * ジョブパラメータ �?計開始日
     */
    @Value("#{jobParameters['firstDateStr']}")
    private String firstDateStr;

    /**
     * ジョブパラメータ �?計終�?日
     */
    @Value("#{jobParameters['lastDateStr']}")
    private String lastDateStr;

    /**
     * ユーザーの現在の作業�?ィレクトリ
     */
    @Value("${user.dir}")
    private String userDir;

    /**
     * 運�?種別搭乗�??�?計結果ファイルパス�?
     */
    @Value("${path.FareTypeAggregationData}")
    private String PATH_FARETYPE_AGGREGATION_DATA;

    @Override
    public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {

        // 出力ファイルパスの取�?
        String outputFilePath = new File(userDir, PATH_FARETYPE_AGGREGATION_DATA).getPath();

        int outputLineCount = 0;

        // �?計期間�?�取得�?�設�?
        AggregationPeriodDto aggregationPeriod = AggregationPeriodUtil.create(firstDateStr, lastDateStr);
        if (aggregationPeriod == null) {
            // ジョブ終�?コード�?100:異常終�??�?
            contribution.setExitStatus(new ExitStatus("BUSINESS_ERROR"));
            return RepeatStatus.FINISHED;
        }

        try {
            // ファイルオープン
            fareTypeAggregationWriter.open(chunkContext.getStepContext().getStepExecution().getExecutionContext());

            // DBから�?ータを取�?
            List<FareTypeAggregationResultDto> items = dao.findFareTypeAggregationByDepartureDateList(aggregationPeriod);

            if (items.size() == 0) {
                // 取得件数�?0件?�?2:正常終�??�?
                LOGGER.warn(LogMessages.W_AR_BB01_L2002.getMessage());
                contribution.setExitStatus(new ExitStatus("NORMAL_NONE_TARGET"));
                return RepeatStatus.FINISHED;
            }

            // 次要�?に�?ータが存在するまで処�?を繰り返す
            for (FareTypeAggregationResultDto inputData : items) {
                try {
                    // 入力チェ�?ク
                    validator.validate(inputData);
                } catch (ValidationException e) {
                    // FieldErrorsの個数�?、以下�?�処�?を繰り返す
                    for (FieldError fieldError : ((BindException) e.getCause()).getFieldErrors()) {
                        // 入力チェ�?クエラーメ�?セージを�?��?
                        LOGGER.warn(messageSource.getMessage(fieldError, null) + "[" + fieldError.getRejectedValue()
                                + "]" + "(" + inputData.toString() + ")");
                    }

                    // 入力チェ�?クエラー?�?100:異常終�??�?
                    LOGGER.error(LogMessages.E_AR_FW_L9003.getMessage(), e);
                    contribution.setExitStatus(new ExitStatus("BUSINESS_ERROR"));
                    return RepeatStatus.FINISHED;
                }

                // DTOの詰め替え�?��?
                FareTypeAggregationDto printData = beanMapper.map(inputData, FareTypeAggregationDto.class);

                // ファイル書き込み
                try {
                    fareTypeAggregationWriter.write(Arrays.asList(printData));
                } catch (Exception e) {
                    // ファイル書込みエラー?�?100:異常終�??�?
                    LOGGER.error(LogMessages.E_AR_FW_L9001.getMessage(outputFilePath), e);
                    contribution.setExitStatus(new ExitStatus("BUSINESS_ERROR"));
                    return RepeatStatus.FINISHED;
                }

                // 出力件数カウントア�?�?
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
                // クローズ失�?
                if (LOGGER.isDebugEnabled()) {
                    LOGGER.debug("クローズ失�?", e);
                }
            }
        }

        // 出力�?�ファイルとファイル出力件数をログに出�?
        LOGGER.info(LogMessages.I_AR_FW_L0003.getMessage(outputFilePath, outputLineCount));

        // ジョブ終�?コード�?0:正常終�??�?
        contribution.setExitStatus(new ExitStatus("NORMAL"));
        return RepeatStatus.FINISHED;
    }
}
