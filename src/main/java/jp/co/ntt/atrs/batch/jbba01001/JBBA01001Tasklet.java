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
package jp.co.ntt.atrs.batch.jbba01001;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import javax.inject.Inject;

import org.dozer.Mapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.batch.core.ExitStatus;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.item.ItemStreamException;
import org.springframework.batch.item.ItemStreamReader;
import org.springframework.batch.item.validator.ValidationException;
import org.springframework.batch.item.validator.Validator;
import org.springframework.batch.repeat.RepeatStatus;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.validation.BindException;
import org.springframework.validation.FieldError;

import jp.co.ntt.atrs.batch.common.exception.AtrsBatchException;
import jp.co.ntt.atrs.batch.common.logging.LogMessages;
import jp.co.ntt.atrs.batch.common.util.DateUtil;
import jp.co.ntt.atrs.batch.jbba00.FlightDto;

/**
 * フライト情報更新ファイルを読込み、フライト情報を更新する。
 * 
 * @author NTT 電電太郎
 */
@Component("JBBA01001Tasklet")
@Scope("step")
public class JBBA01001Tasklet implements Tasklet {

    /**
     * メッセージ出力に利用するログ機能を提供するインタフェース。
     */
    private static final Logger LOGGER = LoggerFactory.getLogger(JBBA01001Tasklet.class);

    /**
     * 入力チェック用のバリデータ。
     */
    @Inject
    Validator<FlightUpdateDto> validator;

    /**
     * メッセージ管理機能。
     */
    @Inject
    MessageSource messageSource;

    /**
     * ファイルアクセス用（入力）インターフェース。
     */
    @Inject
    ItemStreamReader<FlightUpdateDto> flightUpdateReader;

    /**
     * フライト情報更新DAOインタフェース。
     */
    @Inject
    JBBA01001BatchDao dao;

    /**
     * Beanマッパー。
     */
    @Inject
    Mapper beanMapper;

    /**
     * フライト情報更新ファイルパス
     */
    @Value("${path.FlightUpdate}")
    private String PATH_FLIGHT_UPDATE;

    /**
     * フライト情報更新ファイル（リネーム後）パス
     */
    @Value("${path.RenameFlightUpdate}")
    private String PATH_RENAME_FLIGHT_UPDATE;

    /**
     * ユーザーの現在の作業ディレクトリ。
     */
    @Value("${user.dir}")
    private String userDir;

    @Override
    public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
        // 入出力ファイルのパスを取得
        Path inputFile = Paths.get(userDir, PATH_FLIGHT_UPDATE);
        Path outputFile = Paths.get(userDir, PATH_RENAME_FLIGHT_UPDATE);

        // フライト情報更新ファイルの存在チェックを実施する。
        if (!Files.exists(inputFile)) {
            // 更新ファイルの取得失敗（10:警告終了）
            LOGGER.warn(LogMessages.W_AR_BA01_L8001.getMessage(inputFile.toString()));
            contribution.setExitStatus(new ExitStatus("WARNING"));
            return RepeatStatus.FINISHED;
        }

        // フライト情報登録件数
        int insertFlightCnt = 0;

        try {
            // フライト情報更新ファイルオープン
            flightUpdateReader.open(chunkContext.getStepContext().getStepExecution().getExecutionContext());

            // 入力先ファイルをログに出力
            LOGGER.info(LogMessages.I_AR_FW_L0004.getMessage(inputFile.toString()));

            // 登録（入力チェック）処理
            insertFlightCnt = registerData(flightUpdateReader);
        } catch (ItemStreamException e) {
            // ファイルオープンエラー
            LOGGER.error(LogMessages.E_AR_FW_L9006.getMessage());
            throw new AtrsBatchException(e);
        } finally {
            try {
                flightUpdateReader.close();
            } catch (ItemStreamException e) {
                // クローズ失敗
                if (LOGGER.isDebugEnabled()) {
                    LOGGER.debug("クローズ失敗", e);
                }
            }
        }

        try {
            // フライト情報更新ファイルのリネーム
            Files.move(inputFile, outputFile);
        } catch (IOException e) {
            // ファイルリネーム失敗
            LOGGER.error(LogMessages.E_AR_FW_L9009.getMessage(inputFile.toString(), outputFile.toString()), e);
            throw new AtrsBatchException(e);
        }

        // 登録件数をログに出力する。
        LOGGER.info(LogMessages.I_AR_BA01_L0001.getMessage(String.valueOf(insertFlightCnt)));

        // ジョブ終了コード（0:正常終了）
        contribution.setExitStatus(new ExitStatus("NORMAL"));

        return RepeatStatus.FINISHED;
    }

    /**
     * 登録（入力チェック）処理
     * 
     * @param reader 入力データ
     * @return フライト情報登録件数
     * @throws AtrsBatchException
     */
    private int registerData(ItemStreamReader<FlightUpdateDto> reader) throws AtrsBatchException {
        // フライト情報登録件数
        int insertFlightCnt = 0;

        try {
            // フライト情報更新ファイルからデータを取得して入力チェック
            FlightUpdateDto flightUpdateData = null;
            while ((flightUpdateData = reader.read()) != null) {
                // 入力チェックエラーハンドリング
                try {
                    validator.validate(flightUpdateData);
                } catch (ValidationException e) {
                    // FieldErrorsの個数分、以下の処理を繰り返す
                    for (FieldError fieldError : ((BindException) e.getCause()).getFieldErrors()) {
                        // 入力チェックエラーメッセージを出力
                        LOGGER.warn(messageSource.getMessage(fieldError, null) + "[" + fieldError.getRejectedValue()
                                + "]" + "(" + flightUpdateData.getCount() + ")");
                    }
                    
                    // 入力チェックエラー
                    LOGGER.error(LogMessages.E_AR_FW_L9003.getMessage(), e);
                    throw new AtrsBatchException(e);
                }

                // DTOの詰め替え処理
                FlightDto flightDto = beanMapper.map(flightUpdateData, FlightDto.class);

                try {
                    // 日付型変換
                    flightDto.setDepartureDate(DateUtil.convertDate(flightUpdateData.getDepartureDateStr()));

                    // 数値型変換
                    flightDto.setVacantNum(Integer.parseInt(flightUpdateData.getVacantNumStr()));

                } catch (IllegalArgumentException e) {
                    // 型変換エラー
                    LOGGER.error(LogMessages.E_AR_FW_L9005.getMessage(), e);
                    throw new AtrsBatchException(e);
                }

                // フライト情報を登録する
                try {
                    dao.insertFlight(flightDto);
                } catch (Exception e) {
                    // DB登録エラー
                    LOGGER.error(LogMessages.E_AR_FW_L9008.getMessage());
                    throw new AtrsBatchException(e);
                }

                insertFlightCnt++;
            }
        } catch (Exception e) {
            // 入力データ読込エラー
            LOGGER.error(LogMessages.E_AR_FW_L9007.getMessage());
            throw new AtrsBatchException(e);
        }

        return insertFlightCnt;
    }
}
