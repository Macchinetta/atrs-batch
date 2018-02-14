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
package jp.co.ntt.atrs.batch.jbbb01002;

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
import org.springframework.batch.item.ExecutionContext;
import org.springframework.batch.item.ItemStreamException;
import org.springframework.batch.item.ItemStreamWriter;
import org.springframework.batch.item.support.SingleItemPeekableItemReader;
import org.springframework.batch.item.validator.ValidationException;
import org.springframework.batch.item.validator.Validator;

import java.math.BigDecimal;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Arrays;

import javax.inject.Inject;

/**
 * �?計期間�??の区間搭乗�??�?報をCSVファイルに出力する�??
 * 
 * @author 電電次�?
 */
@Component("JBBB01002Tasklet")
@Scope("step")
public class JBBB01002Tasklet implements Tasklet {
    /**
     * メ�?セージ出力に利用するログ機�?�を提供するインタフェース�?
     */
    private static final Logger LOGGER = LoggerFactory.getLogger(JBBB01002Tasklet.class);

    /**
     * 入力チェ�?ク用のバリ�?ータ�?
     */
    @Inject
    Validator<RouteAggregationResultDto> validator;

    /**
     * メ�?セージ管�?機�?��?
     */
    @Inject
    MessageSource messageSource;
    
    /**
     * DB取得後�?��?ータ操作機�?�で提供する�?��?のインターフェース�?
     */
    @Inject
    SingleItemPeekableItemReader<RouteAggregationResultDto> routeAggregationResultReader;

    /**
     * バックア�?プファイル操作機�?�で提供する�?��?のインターフェース�?
     */
    @Inject
    ItemStreamWriter<RouteAggregationDto> routeAggregationWriter;

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
     * 区間搭乗�??�?計結果ファイルパス�?
     */
    @Value("${path.RouteAggregationData}")
    private String PATH_ROUTE_AGGREGATION_DATA;

    @Override
    public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {

        ExecutionContext executionContext = chunkContext.getStepContext().getStepExecution().getExecutionContext();

        // 出力ファイルパスの取�?
        Path outputFilePath = Paths.get(userDir, PATH_ROUTE_AGGREGATION_DATA);

        // 出力件数カウン�?
        int outputLineCount = 0;

        // �?計期間�?�取得�?�設�?
        AggregationPeriodDto aggregationPeriod = AggregationPeriodUtil.create(firstDateStr, lastDateStr);

        if (aggregationPeriod == null) {
            // �?計期間�?�取得で例外�?100:異常終�??�?
            contribution.setExitStatus(new ExitStatus("BUSINESS_ERROR"));
            return RepeatStatus.FINISHED;
        }

        try {
            // 検索条件�?�?
            executionContext.put("firstDate", aggregationPeriod.getFirstDate());
            executionContext.put("lastDate", aggregationPeriod.getLastDate());

            // 搭乗率算�?�のための席数�?報
            int totalNSeatNum = 0;
            int totalSSeatNum = 0;

            // 搭乗�??数の初期�?
            int passengerCount = 0;

            // DB取得用readerオープン
            routeAggregationResultReader.open(executionContext);

            // 出力用ファイルオープン
            routeAggregationWriter.open(executionContext);

            // 次要�?に�?ータが存在するまで処�?を繰り返す
            while (routeAggregationResultReader.peek() != null) {

                // �?ータ取�?
                RouteAggregationResultDto inputData = routeAggregationResultReader.read();

                // 入力チェ�?クエラーハンドリング
                try {
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
                // 席数?���?般席・特別席?���?�搭乗�??数をそれぞれ加�?
                totalNSeatNum += inputData.getNormalSeatNum();
                totalSSeatNum += inputData.getSpecialSeatNum();
                passengerCount += inputData.getPassengerNum();

                // 次�?ータを取�?
                RouteAggregationResultDto nextdata = routeAggregationResultReader.peek();

                // 次�?ータと現在�?ータを比�?
                if (isBreakByRouteNo(nextdata, inputData)) {

                    // 搭乗�??数の設�?
                    inputData.setPassengerNum(passengerCount);

                    // 搭乗率計�?
                    BigDecimal totalSeatNum = new BigDecimal(totalNSeatNum).add(new BigDecimal(totalSSeatNum));
                    BigDecimal passcount = new BigDecimal(passengerCount);
                    BigDecimal loadFactor = passcount.multiply(new BigDecimal(100)).divide(totalSeatNum, 2,
                            BigDecimal.ROUND_HALF_UP);

                    // DTOの詰め替え�?��?
                    RouteAggregationDto printData = beanMapper.map(inputData, RouteAggregationDto.class);

                    // 搭乗率計�?�設�?
                    printData.setLoadFactor(loadFactor);

                    // ファイル書き込み
                    try {
                        routeAggregationWriter.write(Arrays.asList(printData));
                    } catch (Exception e) {
                        // ファイル書込みエラー?�?100:異常終�??�?
                        LOGGER.error(LogMessages.E_AR_FW_L9001.getMessage(), e);
                        contribution.setExitStatus(new ExitStatus("BUSINESS_ERROR"));
                        return RepeatStatus.FINISHED;
                    }

                    // 出力件数カウントア�?�?
                    outputLineCount++;

                    // 総座席数、搭乗�??数リセ�?�?
                    totalNSeatNum = 0;
                    totalSSeatNum = 0;
                    passengerCount = 0;
                }
            }
        } catch (ItemStreamException e) {
            // ファイルオープンエラー
            LOGGER.error(LogMessages.E_AR_FW_L9006.getMessage());
            throw new AtrsBatchException(e);
        } finally {
            try {
                // DB取得用readerクローズ
                routeAggregationResultReader.close();
            } catch (ItemStreamException e) {
                // クローズ失�?
                if (LOGGER.isDebugEnabled()) {
                    LOGGER.debug("クローズ失�?", e);
                }
            }

            try {
                // ファイルクローズ
                routeAggregationWriter.close();
            } catch (ItemStreamException e) {
                // クローズ失�?
                if (LOGGER.isDebugEnabled()) {
                    LOGGER.debug("クローズ失�?", e);
                }
            }
        }

        if (outputLineCount == 0) {
            // 取得件数�?0件?�?2:正常終�??�?
            LOGGER.warn(LogMessages.W_AR_BB01_L2002.getMessage());
            contribution.setExitStatus(new ExitStatus("NORMAL_NONE_TARGET"));
            return RepeatStatus.FINISHED;
        }

        // 出力�?�ファイルとファイル出力件数をログに出�?
        LOGGER.info(LogMessages.I_AR_FW_L0003.getMessage(outputFilePath, outputLineCount));

        // ジョブ終�?コード�?0:正常終�??�?
        contribution.setExitStatus(new ExitStatus("NORMAL"));
        return RepeatStatus.FINISHED;
    }

    /**
     * 次�?ータと現在�?ータとを比�?し�?�trueまた�?�falseを返す�?
     * 
     * @param nextdata 次�?ータ
     * @param inputData 現在の�?ータ
     * @return true or false
     */
    private boolean isBreakByRouteNo(RouteAggregationResultDto nextdata, RouteAggregationResultDto inputData) {
        // 次�?ータがnullの場合�?�また�?�次�?ータと現在�?ータが�?致しな�?場合�?�trueを返す
        if (nextdata == null || (!nextdata.getRouteNo().equals(inputData.getRouteNo()))) {
            return true;
        }
        return false;
    }
}
