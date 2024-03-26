/*
 * Copyright(c) 2017 NTT Corporation.
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
package jp.co.ntt.atrs.batch.jbbb01002;

import jp.co.ntt.atrs.batch.common.constant.Constant;
import jp.co.ntt.atrs.batch.common.exception.AtrsBatchException;
import jp.co.ntt.atrs.batch.common.logging.LogMessages;
import jp.co.ntt.atrs.batch.jbbb00.AggregationPeriodDto;
import jp.co.ntt.atrs.batch.jbbb00.AggregationPeriodUtil;

import com.github.dozermapper.core.Mapper;
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
import org.springframework.batch.item.ExecutionContext;
import org.springframework.batch.item.ItemStreamException;
import org.springframework.batch.item.ItemStreamWriter;
import org.springframework.batch.item.support.SingleItemPeekableItemReader;
import org.springframework.batch.item.validator.ValidationException;
import org.springframework.batch.item.validator.Validator;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.Locale;

import javax.inject.Inject;

/**
 * 集計期間内の区間搭乗者情報をCSVファイルに出力する。
 * 
 * @author 電電次郎
 */
@Component("JBBB01002Tasklet")
@Scope("step")
public class JBBB01002Tasklet implements Tasklet {
    /**
     * メッセージ出力に利用するログ機能を提供するインタフェース。
     */
    private static final Logger LOGGER = LoggerFactory.getLogger(JBBB01002Tasklet.class);

    /**
     * 入力チェック用のバリデータ。
     */
    @Inject
    Validator<RouteAggregationResultDto> validator;

    /**
     * メッセージ管理機能。
     */
    @Inject
    MessageSource messageSource;

    /**
     * DB取得後のデータ操作機能で提供する処理のインターフェース。
     */
    @Inject
    SingleItemPeekableItemReader<RouteAggregationResultDto> routeAggregationResultReader;

    /**
     * バックアップファイル操作機能で提供する処理のインターフェース。
     */
    @Inject
    ItemStreamWriter<RouteAggregationDto> routeAggregationWriter;

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
     * 区間搭乗者集計結果ファイルパス。
     */
    @Value("${path.RouteAggregationData}")
    private String PATH_ROUTE_AGGREGATION_DATA;

    @Override
    public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {

        ExecutionContext executionContext = chunkContext.getStepContext().getStepExecution().getExecutionContext();

        // 出力ファイルパスの取得
        Path outputFilePath = Paths.get(userDir, PATH_ROUTE_AGGREGATION_DATA);

        // 出力件数カウント
        int outputLineCount = 0;

        // 集計期間の取得・設定
        AggregationPeriodDto aggregationPeriod = AggregationPeriodUtil.create(firstDateStr, lastDateStr);

        if (aggregationPeriod == null) {
            // 集計期間の取得で例外（100:異常終了）
            contribution.setExitStatus(new ExitStatus(Constant.BUSINESS_ERROR));
            return RepeatStatus.FINISHED;
        }

        try {
            // 検索条件指定
            executionContext.put("firstDate", aggregationPeriod.getFirstDate());
            executionContext.put("lastDate", aggregationPeriod.getLastDate());

            // 搭乗率算出のための席数情報
            int totalNSeatNum = 0;
            int totalSSeatNum = 0;

            // 搭乗者数の初期化
            int passengerCount = 0;

            // DB取得用readerオープン
            routeAggregationResultReader.open(executionContext);

            // 出力用ファイルオープン
            routeAggregationWriter.open(executionContext);

            // 次要素にデータが存在するまで処理を繰り返す
            while (routeAggregationResultReader.peek() != null) {

                // データ取得
                RouteAggregationResultDto inputData = routeAggregationResultReader.read();

                // 入力チェックエラーハンドリング
                if (!doValidate(inputData, contribution)){
                    // チェックエラーがある場合
                    return RepeatStatus.FINISHED;
                }

                // 席数（一般席・特別席）、搭乗者数をそれぞれ加算
                totalNSeatNum += inputData.getNormalSeatNum();
                totalSSeatNum += inputData.getSpecialSeatNum();
                passengerCount += inputData.getPassengerNum();

                // 次データを取得
                RouteAggregationResultDto nextdata = routeAggregationResultReader.peek();

                // 次データと現在データを比較
                if (!isBreakByRouteNo(nextdata, inputData)) {
                    continue;
                }

                // 搭乗者数の設定
                inputData.setPassengerNum(passengerCount);

                // 搭乗率計算
                BigDecimal totalSeatNum = new BigDecimal(totalNSeatNum).add(new BigDecimal(totalSSeatNum));
                BigDecimal passcount = new BigDecimal(passengerCount);
                BigDecimal loadFactor = passcount.multiply(new BigDecimal(100)).divide(totalSeatNum, 2,
                        RoundingMode.HALF_UP);

                // DTOの詰め替え処理
                RouteAggregationDto printData = beanMapper.map(inputData, RouteAggregationDto.class);

                // 搭乗率計の設定
                printData.setLoadFactor(loadFactor);

                // ファイル書き込み
                if (!doWrite(printData, contribution)){
                    // Exceptionの場合
                    return RepeatStatus.FINISHED;
                }

                // 出力件数カウントアップ
                outputLineCount++;

                // 総座席数、搭乗者数リセット
                totalNSeatNum = 0;
                totalSSeatNum = 0;
                passengerCount = 0;
            }
        } catch (ItemStreamException e) {
            // ファイルオープンエラー
            LOGGER.error(LogMessages.E_AR_FW_L9006.getMessage());
            throw new AtrsBatchException(e);
        } finally {
            closeResource();
        }

        if (outputLineCount == 0) {
            // 取得件数が0件（2:正常終了）
            LOGGER.warn(LogMessages.W_AR_BB01_L2002.getMessage());
            contribution.setExitStatus(new ExitStatus("NORMAL_NONE_TARGET"));
            return RepeatStatus.FINISHED;
        }

        // 出力先ファイルとファイル出力件数をログに出力
        LOGGER.info(LogMessages.I_AR_FW_L0003.getMessage(outputFilePath, outputLineCount));

        // ジョブ終了コード（0:正常終了）
        contribution.setExitStatus(new ExitStatus("NORMAL"));
        return RepeatStatus.FINISHED;
    }

    /**
     * 次データと現在データとを比較し、trueまたはfalseを返す。
     * 
     * @param nextdata 次データ
     * @param inputData 現在のデータ
     * @return true or false
     */
    private boolean isBreakByRouteNo(RouteAggregationResultDto nextdata, RouteAggregationResultDto inputData) {
        // 次データがnullの場合、または次データと現在データが一致しない場合はtrueを返す
        return nextdata == null || !nextdata.getRouteNo().equals(inputData.getRouteNo());
    }

    /**
     * 入力データのチェックを行う
     * @param inputData 入力データ
     * @param contribution ステップ情報
     * @return 正常終了の場合：true　Exceptionの場合：false
     */
    private boolean doValidate(RouteAggregationResultDto inputData, StepContribution contribution){
        try {
            validator.validate(inputData);
        } catch (ValidationException e) {
            // FieldErrorsの個数分、以下の処理を繰り返す
            for (FieldError fieldError : ((BindException) e.getCause()).getFieldErrors()) {
                // 入力チェックエラーメッセージを出力
                LOGGER.warn("{}[{}]({})", messageSource.getMessage(fieldError, Locale.getDefault()),
                        fieldError.getRejectedValue(), inputData);
            }
            // 入力チェックエラー（100:異常終了）
            LOGGER.error(LogMessages.E_AR_FW_L9003.getMessage(), e);
            contribution.setExitStatus(new ExitStatus(Constant.BUSINESS_ERROR));
            return false;
        }
        return true;
    }

    /**
     * ファイル書き込み
     * @param printData DTOの詰め替え処理データ
     * @param contribution ステップ情報
     * @return 正常終了の場合：true　Exceptionの場合：false
     */
    private boolean doWrite(RouteAggregationDto printData, StepContribution contribution){
        try {
            routeAggregationWriter.write(Arrays.asList(printData));
        } catch (Exception e) {
            // ファイル書込みエラー（100:異常終了）
            LOGGER.error(LogMessages.E_AR_FW_L9001.getMessage(), e);
            contribution.setExitStatus(new ExitStatus(Constant.BUSINESS_ERROR));
            return false;
        }
        return true;
    }

    /**
     * DB取得用reader及びファイルWriterをクローズ
     */
    private void closeResource(){
        try {
            // DB取得用readerクローズ
            routeAggregationResultReader.close();
        } catch (ItemStreamException e) {
            // クローズ失敗
            LOGGER.debug("クローズ失敗", e);
        }

        try {
            // ファイルクローズ
            routeAggregationWriter.close();
        } catch (ItemStreamException e) {
            // クローズ失敗
            LOGGER.debug("クローズ失敗", e);
        }
    }
}
