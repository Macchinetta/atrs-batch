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
package jp.co.ntt.atrs.batch.jbbb01001;

import jp.co.ntt.atrs.batch.common.exception.AtrsBatchException;
import jp.co.ntt.atrs.batch.common.logging.LogMessages;
import jp.co.ntt.atrs.batch.jbbb00.AggregationPeriodDto;
import jp.co.ntt.atrs.batch.jbbb00.AggregationPeriodUtil;

import org.dozer.Mapper;
import org.joda.time.LocalDate;
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

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.inject.Inject;

/**
 * 予約情報を集計し、予約集計情報をCSVファイルに出力する。
 * 
 * @author 電電次郎
 */
@Component("JBBB01001Tasklet")
@Scope("step")
public class JBBB01001Tasklet implements Tasklet {
    /**
     * メッセージ出力に利用するログ機能を提供するインタフェース。
     */
    private static final Logger LOGGER = LoggerFactory.getLogger(JBBB01001Tasklet.class);

    /**
     * 予約情報集計結果入力用reader（コントロールブレイク用）。
     */
    @Inject
    SingleItemPeekableItemReader<ReservationResultDto> reservationResultReader;

    /**
     * 予約情報集計出力用writer。
     */
    @Inject
    ItemStreamWriter<ReservationDto> reservationWriter;

    /**
     * 入力チェック用のバリデータ。
     */
    @Inject
    Validator<ReservationResultDto> validator;

    /**
     * メッセージ管理機能。
     */
    @Inject
    MessageSource messageSource;

    /**
     * Beanマッパー。
     */
    @Inject
    Mapper beanMapper;

    /**
     * ジョブパラメータ 集計開始日。
     */
    @Value("#{jobParameters['firstDateStr']}")
    private String firstDateStr;

    /**
     * ジョブパラメータ 集計終了日。
     */
    @Value("#{jobParameters['lastDateStr']}")
    private String lastDateStr;

    /**
     * ユーザーの現在の作業ディレクトリ。
     */
    @Value("${user.dir}")
    private String userDir;

    /**
     * 予約情報集計結果ファイルパス。
     */
    @Value("${path.ReservationData}")
    private String PATH_RESERVATION_DATA;

    @Override
    public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
        ExecutionContext executionContext = chunkContext.getStepContext().getStepExecution().getExecutionContext();

        // 集計期間の取得・設定
        AggregationPeriodDto aggregationPeriod = AggregationPeriodUtil.create(firstDateStr, lastDateStr);

        if (aggregationPeriod == null) {
            // 集計期間の取得で例外（100:異常終了）
            contribution.setExitStatus(new ExitStatus("BUSINESS_ERROR"));
            return RepeatStatus.FINISHED;
        }

        // 出力ファイルパスと出力件数を保持するMap。
        Map<String, Integer> outputLineCountMap = new LinkedHashMap<>();

        try {
            // 検索条件指定
            executionContext.put("firstDate", aggregationPeriod.getFirstDate());
            executionContext.put("lastDate", aggregationPeriod.getLastDate());

            // 入力ファイルオープン
            reservationResultReader.open(executionContext);

            // 出力件数
            int dataCount = 0;
            int outputLineCount = 0;

            // 処理中の出力先ファイルパス
            Path outputFile = Paths.get(userDir, PATH_RESERVATION_DATA);

            // コントロールブレイクの処理結果を含めたグループ単位のレコードを格納する
            List<ReservationDto> items = new ArrayList<>();

            // 次要素にデータが存在するまで処理を繰り返す
            while (reservationResultReader.peek() != null) {
                dataCount++;
                outputLineCount++;

                // 予約情報を取得する
                ReservationResultDto inputData = reservationResultReader.read();

                // 入力チェックエラーハンドリング
                try {
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
                ReservationDto printData = beanMapper.map(inputData, ReservationDto.class);

                items.add(printData);

                // 次のレコードを先読みする
                ReservationResultDto nextData = reservationResultReader.peek();

                // 対象レコード処理後にコントロールブレイクを実施する
                if (isBreakByReserveDate(nextData, inputData)) {
                    // コントロールブレイクした値を取得し、出力ファイルネーム用に文字列変換する
                    LocalDate ld = new LocalDate(inputData.getReserveDate());
                    String outputDate = ld.toString("yyyyMMdd");

                    // 出力ファイルパス
                    String outputFilePath = MessageFormat.format(outputFile.toString(), outputDate);

                    try {
                        // 出力ファイルオープン
                        reservationWriter.open(executionContext);

                        // 書き込み
                        reservationWriter.write(items);
                        items.clear();

                        // 各ファイルの出力件数を保持する
                        outputLineCountMap.put(outputFilePath, outputLineCount);

                        // 出力件数初期化
                        outputLineCount = 0;
                    } catch (ItemStreamException e) {
                        // ファイルオープンエラー
                        LOGGER.error(LogMessages.E_AR_FW_L9006.getMessage());
                        throw new AtrsBatchException(e);
                    } catch (Exception e) {
                        // ファイル書込みエラー（100:異常終了）
                        LOGGER.error(LogMessages.E_AR_FW_L9001.getMessage(), e);
                        contribution.setExitStatus(new ExitStatus("BUSINESS_ERROR"));
                        return RepeatStatus.FINISHED;
                    } finally {
                        try {
                            // 出力ファイルクローズ
                            reservationWriter.close();
                        } catch (ItemStreamException e) {
                            // クローズ失敗
                            if (LOGGER.isDebugEnabled()) {
                                LOGGER.debug("クローズ失敗", e);
                            }
                        }
                    }
                    
                    try {
                        // リネーム
                        Files.move(outputFile, Paths.get(outputFilePath));
                    } catch (IOException e) {
                        // ファイルリネーム失敗
                        LOGGER.error(LogMessages.E_AR_FW_L9009.getMessage(outputFile.toString(), outputFilePath), e);
                        throw new AtrsBatchException(e);
                    }
                }
            }

            // 取得件数が0件の場合ログを出力する。
            if (dataCount == 0) {
                LOGGER.warn(LogMessages.W_AR_BB01_L2001.getMessage());
                // ジョブ終了コード（2:正常終了）
                contribution.setExitStatus(new ExitStatus("NORMAL_NONE_TARGET"));
                return RepeatStatus.FINISHED;
            }
        } catch (ItemStreamException e) {
            // ファイルオープンエラー
            LOGGER.error(LogMessages.E_AR_FW_L9006.getMessage());
            throw new AtrsBatchException(e);
        } finally {
            try {
                // 入力ファイルクローズ
                reservationResultReader.close();
            } catch (ItemStreamException e) {
                // クローズ失敗
                if (LOGGER.isDebugEnabled()) {
                    LOGGER.debug("クローズ失敗", e);
                }
            }
        }

        // 出力先ファイルとファイル出力件数をログに出力
        for (Entry<String, Integer> entry : outputLineCountMap.entrySet()) {
            LOGGER.info(LogMessages.I_AR_FW_L0003.getMessage(entry.getKey(), entry.getValue()));
        }

        // ジョブ終了コード（0:正常終了）
        contribution.setExitStatus(new ExitStatus("NORMAL"));
        return RepeatStatus.FINISHED;
    }

    /**
     * 次要素のデータと現在のデータとを比較し、trueまたはfalseを返す。
     * 
     * @param nextData 次のデータ
     * @param inputData 現在のデータ
     * @return true or false
     */
    private boolean isBreakByReserveDate(ReservationResultDto nextData, ReservationResultDto inputData) {
        return (nextData == null || nextData.getReserveDate().compareTo(inputData.getReserveDate()) != 0);
    }
}
