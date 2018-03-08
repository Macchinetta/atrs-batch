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
package jp.co.ntt.atrs.batch.jbba02001;

import jp.co.ntt.atrs.batch.common.exception.AtrsBatchException;
import jp.co.ntt.atrs.batch.common.logging.LogMessages;
import jp.co.ntt.atrs.batch.jbba00.FlightDto;

import org.dozer.Mapper;
import org.joda.time.LocalDate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.batch.core.ExitStatus;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.item.ItemStreamException;
import org.springframework.batch.item.ItemStreamWriter;
import org.springframework.batch.item.validator.ValidationException;
import org.springframework.batch.item.validator.Validator;
import org.springframework.batch.repeat.RepeatStatus;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.validation.BindException;
import org.springframework.validation.FieldError;

import java.util.List;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.MessageFormat;

import javax.inject.Inject;

/**
 * 不要なフライト情報をフライト情報バックアップファイルに出力し、DBの不要なフライト情報を削除する。
 * 
 * @author NTT 電電太郎
 */
@Component("JBBA02001Tasklet")
@Scope("step")
public class JBBA02001Tasklet implements Tasklet {
    /**
     * メッセージ出力に利用するログ機能を提供するインタフェース。
     */
    private static final Logger LOGGER = LoggerFactory.getLogger(JBBA02001Tasklet.class);

    /**
     * フライト情報入力チェック用のバリデータ。
     */
    @Inject
    Validator<FlightDto> flightDtoValidator;

    /**
     * 予約フライト情報入力チェック用のバリデータ。
     */
    @Inject
    Validator<ReserveFlightDto> reserveFlightDtoValidator;

    /**
     * 搭乗者情報入力チェック用のバリデータ。
     */
    @Inject
    Validator<PassengerDto> passengerDtoValidator;

    /**
     * メッセージ管理機能。
     */
    @Inject
    MessageSource messageSource;

    /**
     * フライト情報バックアップファイル操作機能で提供する処理のインターフェース。
     */
    @Inject
    ItemStreamWriter<FlightBackupDto> flightBackupFileWriter;

    /**
     * 予約フライト情報バックアップファイル操作機能で提供する処理のインターフェース。
     */
    @Inject
    ItemStreamWriter<PassengerBackupDto> passengerBackupFileWriter;

    /**
     * 搭乗者情報バックアップファイル操作機能で提供する処理のインターフェース。
     */
    @Inject
    ItemStreamWriter<ReserveFlightBackupDto> reserveFlightBackupFileWriter;

    /**
     * フライト情報退避DAOインタフェース。
     */
    @Inject
    JBBA02001Dao dao;

    /**
     * Beanマッパー。
     */
    @Inject
    Mapper beanMapper;

    /**
     * ユーザーの現在の作業ディレクトリ
     */
    @Value("${user.dir}")
    private String userDir;

    /**
     * フライト情報バックアップファイルパス
     */
    @Value("${path.FlightBackup}")
    private String PATH_FLIGHT_BACKUP;

    /**
     * 予約フライト情報バックアップファイルパス
     */
    @Value("${path.ReserveFlightBackup}")
    private String PATH_RESERVE_FLIGHT_BACKUP;

    /**
     * 搭乗者情報バックアップファイルパス
     */
    @Value("${path.PassengerBackup}")
    private String PATH_PASSENGER_BACKUP;

    @Override
    public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {

        // システム日時を取得し、日を"01"、時間を"00:00:00"に変更した日時をバッチ処理日時として保持
        final Calendar calendar = Calendar.getInstance();
        calendar.set(calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH), 1, 0, 0, 0);

        // 退避を実施した年月
        final String fileYYYYMM = new LocalDate(calendar.getTime()).toString("yyyyMM");

        // バッチ処理日時から1か月さかのぼった日時を退避処理日時として保持
        calendar.add(Calendar.MONTH, -1);
        final Date paramDate = calendar.getTime();

        // バックアップファイルのパスを取得
        Path flightBackupFile = Paths.get(userDir, PATH_FLIGHT_BACKUP);
        Path reserveFlightBackupFile = Paths.get(userDir, PATH_RESERVE_FLIGHT_BACKUP);
        Path passengerBackupFile = Paths.get(userDir, PATH_PASSENGER_BACKUP);

        // リネームファイル
        String renameFlightBackupFile = MessageFormat.format(flightBackupFile.toString(), fileYYYYMM);
        String renameReserveFlightBackupFile = MessageFormat.format(reserveFlightBackupFile.toString(), fileYYYYMM);
        String renamePassengerBackupFile = MessageFormat.format(passengerBackupFile.toString(), fileYYYYMM);

        // 正常終了フラグ（false：異常）
        boolean normalEndFlg = false;

        try {
            // フライト情報のバックアップ処理
            int flightBackupCnt = backupFlightDb(paramDate, flightBackupFile.toString(), renameFlightBackupFile,
                    chunkContext);

            if (flightBackupCnt == 0) {
                // 退避対象のフライト情報無し（10:警告終了）
                LOGGER.warn(LogMessages.W_AR_BA02_L8001.getMessage());
                contribution.setExitStatus(new ExitStatus("WARNING"));
                return RepeatStatus.FINISHED;
            }

            // フライト情報の出力先ファイルとファイル出力件数をログに出力
            LOGGER.info(LogMessages.I_AR_FW_L0003.getMessage(renameFlightBackupFile, String.valueOf(flightBackupCnt)));

            // 予約フライト情報のバックアップ処理
            int reserveFlightBackupCnt = backupReserveFlightDb(paramDate, reserveFlightBackupFile.toString(),
                    renameReserveFlightBackupFile, chunkContext);

            // 予約フライト情報の出力先ファイルとファイル出力件数をログに出力
            LOGGER.info(LogMessages.I_AR_FW_L0003.getMessage(renameReserveFlightBackupFile,
                    String.valueOf(reserveFlightBackupCnt)));

            // 搭乗者情報のバックアップ処理
            int passengerBackupCnt = backupPassengerDb(paramDate, passengerBackupFile.toString(),
                    renamePassengerBackupFile, chunkContext);

            // 搭乗者情報の出力先ファイルとファイル出力件数をログに出力
            LOGGER.info(LogMessages.I_AR_FW_L0003.getMessage(renamePassengerBackupFile,
                    String.valueOf(passengerBackupCnt)));

            // 搭乗者情報のDB削除と削除件数ログ出力
            int passengerDelCnt = dao.deletePassenger(paramDate);

            LOGGER.info(LogMessages.I_AR_BA02_L0001.getMessage("搭乗者情報", String.valueOf(passengerDelCnt)));

            // 予約フライト情報のDB削除と削除件数ログ出力
            final int reserveFlightDelCnt = dao.deleteReserveFlight(paramDate);
            LOGGER.info(LogMessages.I_AR_BA02_L0001.getMessage("予約フライト情報", String.valueOf(reserveFlightDelCnt)));

            // フライト情報のDB削除と削除件数ログ出力
            final int flightDelCnt = dao.deleteFlight(paramDate);
            LOGGER.info(LogMessages.I_AR_BA02_L0001.getMessage("フライト情報", String.valueOf(flightDelCnt)));

            // 正常終了フラグ（true：正常）
            normalEndFlg = true;
        } finally {
            // エラー発生によるロールバックの場合はバックアップファイルを削除
            if (!normalEndFlg) {
                deleteFile(Paths.get(renameFlightBackupFile));
                deleteFile(Paths.get(renameReserveFlightBackupFile));
                deleteFile(Paths.get(renamePassengerBackupFile));
            }
        }

        // ジョブ終了コード（0:正常終了）
        contribution.setExitStatus(new ExitStatus("NORMAL"));
        return RepeatStatus.FINISHED;
    }

    /**
     * フライト情報DBデータのバックアップ処理。
     * 
     * @param paramDate 退避処理日時
     * @param fileName バックアップファイルのファイル名(リネーム前)
     * @param newFileName バックアップファイルのファイル名(リネーム後)
     * @param chunkContext ファイル入出力パラメータ
     * @return バックアップ件数
     * @throws AtrsBatchException
     */
    private int backupFlightDb(Date paramDate, String fileName, String newFileName, ChunkContext chunkContext)
            throws AtrsBatchException {

        int cnt = 0;

        try {
            // ファイルオープン
            flightBackupFileWriter.open(chunkContext.getStepContext().getStepExecution().getExecutionContext());

            // DBからデータ取得
            List<FlightDto> dbData = dao.findFlightList(paramDate);

            // DBからデータを取得
            for (FlightDto inputdata : dbData) {
                // 入力チェックエラーハンドリング
                try {
                    flightDtoValidator.validate(inputdata);
                } catch (ValidationException e) {
                    // FieldErrorsの個数分、以下の処理を繰り返す
                    for (FieldError fieldError : ((BindException) e.getCause()).getFieldErrors()) {
                        // 入力チェックエラーメッセージを出力
                        LOGGER.warn(messageSource.getMessage(fieldError, null) + "[" + fieldError.getRejectedValue()
                                + "]" + "(" + inputdata.toString() + ")");
                    }
                    // 入力チェックエラー
                    LOGGER.error(LogMessages.E_AR_FW_L9003.getMessage(), e);
                    throw new AtrsBatchException(e);
                }
                // DTOの詰め替え処理
                FlightBackupDto printData = beanMapper.map(inputdata, FlightBackupDto.class);

                // バックアップファイルへの書込み
                try {
                    flightBackupFileWriter.write(Arrays.asList(printData));
                } catch (Exception e) {
                    // ファイル書込みエラー
                    LOGGER.error(LogMessages.E_AR_FW_L9001.getMessage(fileName), e);
                    throw new AtrsBatchException(e);
                }

                cnt++;
            }

        } catch (ItemStreamException e) {
            // ファイルオープンエラー
            LOGGER.error(LogMessages.E_AR_FW_L9006.getMessage());
            throw new AtrsBatchException(e);
        } finally {
            try {
                // ファイルクローズ
                flightBackupFileWriter.close();
            } catch (ItemStreamException e) {
                // クローズ失敗
                if (LOGGER.isDebugEnabled()) {
                    LOGGER.debug("クローズ失敗", e);
                }
            }
        }
        
        try {
            // リネーム
            Files.move(Paths.get(fileName), Paths.get(newFileName));
        } catch (IOException e) {
            // リネーム失敗
            LOGGER.error(LogMessages.E_AR_FW_L9009.getMessage(fileName, newFileName), e);
            throw new AtrsBatchException(e);
        }

        return cnt;
    }

    /**
     * 予約フライト情報DBデータのバックアップ処理。
     * 
     * @param paramDate 退避処理日時
     * @param fileName バックアップファイルのファイル名(リネーム前)
     * @param newFileName バックアップファイルのファイル名(リネーム後)
     * @param chunkContext ファイル入出力パラメータ
     * @return バックアップ件数
     * @throws AtrsBatchException
     */
    private int backupReserveFlightDb(Date paramDate, String fileName, String newFileName, ChunkContext chunkContext)
            throws AtrsBatchException {

        int cnt = 0;

        try {
            // ファイルオープン
            reserveFlightBackupFileWriter.open(chunkContext.getStepContext().getStepExecution().getExecutionContext());

            // DBからデータ取得
            List<ReserveFlightDto> dbData = dao.findReserveFlightList(paramDate);

            // 次要素にデータが存在するまで処理を繰り返す
            for (ReserveFlightDto inputdata : dbData) {
                // 入力チェックエラーハンドリング
                try {
                    reserveFlightDtoValidator.validate(inputdata);
                } catch (ValidationException e) {
                    // FieldErrorsの個数分、以下の処理を繰り返す
                    for (FieldError fieldError : ((BindException) e.getCause()).getFieldErrors()) {
                        // 入力チェックエラーメッセージを出力
                        LOGGER.warn(messageSource.getMessage(fieldError, null) + "[" + fieldError.getRejectedValue()
                                + "]" + "(" + inputdata.toString() + ")");
                    }

                    // 入力チェックエラー
                    LOGGER.error(LogMessages.E_AR_FW_L9003.getMessage(), e);
                    throw new AtrsBatchException(e);
                }
                // DTOの詰め替え処理
                ReserveFlightBackupDto printData = beanMapper.map(inputdata, ReserveFlightBackupDto.class);

                // バックアップファイルへの書込み
                try {
                    reserveFlightBackupFileWriter.write(Arrays.asList(printData));
                } catch (Exception e) {
                    // ファイル書込みエラー
                    LOGGER.error(LogMessages.E_AR_FW_L9001.getMessage(fileName), e);
                    throw new AtrsBatchException(e);
                }

                cnt++;
            }

        } catch (ItemStreamException e) {
            // ファイルオープンエラー
            LOGGER.error(LogMessages.E_AR_FW_L9006.getMessage());
            throw new AtrsBatchException(e);
        } finally {
            try {
                // ファイルクローズ
                reserveFlightBackupFileWriter.close();
            } catch (ItemStreamException e) {
                // クローズ失敗
                if (LOGGER.isDebugEnabled()) {
                    LOGGER.debug("クローズ失敗", e);
                }
            }
        }
        
        try {
            // リネーム
            Files.move(Paths.get(fileName), Paths.get(newFileName));
        } catch (IOException e) {
            // リネーム失敗
            LOGGER.error(LogMessages.E_AR_FW_L9009.getMessage(fileName, newFileName), e);
            throw new AtrsBatchException(e);
        }

        return cnt;
    }

    /**
     * 搭乗者情報DBデータのバックアップ処理。
     * 
     * @param paramDate 退避処理日時
     * @param fileName バックアップファイルのファイル名(リネーム前)
     * @param newFileName バックアップファイルのファイル名(リネーム後)
     * @param chunkContext ファイル入出力パラメータ
     * @return バックアップ件数
     * @throws AtrsBatchException
     */
    private int backupPassengerDb(Date paramDate, String fileName, String newFileName, ChunkContext chunkContext)
            throws AtrsBatchException {

        int cnt = 0;

        try {
            // ファイルオープン
            passengerBackupFileWriter.open(chunkContext.getStepContext().getStepExecution().getExecutionContext());

            // DBからデータ取得
            List<PassengerDto> dbData = dao.findPassengerList(paramDate);

            // 次要素にデータが存在するまで処理を繰り返す
            for (PassengerDto inputdata : dbData) {
                // 入力チェックエラーハンドリング
                try {
                    passengerDtoValidator.validate(inputdata);
                } catch (ValidationException e) {
                    // FieldErrorsの個数分、以下の処理を繰り返す
                    for (FieldError fieldError : ((BindException) e.getCause()).getFieldErrors()) {
                        // 入力チェックエラーメッセージを出力
                        LOGGER.warn(messageSource.getMessage(fieldError, null) + "[" + fieldError.getRejectedValue()
                                + "]" + "(" + inputdata.toString() + ")");
                    }

                    // 入力チェックエラー
                    LOGGER.error(LogMessages.E_AR_FW_L9003.getMessage(), e);
                    throw new AtrsBatchException(e);
                }

                // DTOの詰め替え処理
                PassengerBackupDto printData = beanMapper.map(inputdata, PassengerBackupDto.class);

                // バックアップファイルへの書込み
                try {
                    passengerBackupFileWriter.write(Arrays.asList(printData));
                } catch (Exception e) {
                    // ファイル書込みエラー
                    LOGGER.error(LogMessages.E_AR_FW_L9001.getMessage(fileName), e);
                    throw new AtrsBatchException(e);
                }

                cnt++;
            }

        } catch (ItemStreamException e) {
            // ファイルオープンエラー
            LOGGER.error(LogMessages.E_AR_FW_L9006.getMessage());
            throw new AtrsBatchException(e);
        } finally {
            try {
                // ファイルクローズ
                passengerBackupFileWriter.close();
            } catch (ItemStreamException e) {
                // クローズ失敗
                if (LOGGER.isDebugEnabled()) {
                    LOGGER.debug("クローズ失敗", e);
                }
            }
        }
        
        try {
            // リネーム
            Files.move(Paths.get(fileName), Paths.get(newFileName));
        } catch (IOException e) {
            // リネーム失敗
            LOGGER.error(LogMessages.E_AR_FW_L9009.getMessage(fileName, newFileName), e);
            throw new AtrsBatchException(e);
        }

        return cnt;
    }

    /**
     * バックアップファイル削除。
     * 
     * @param fileName バックアップファイルのファイル名
     */
    private void deleteFile(Path fileName) {
        // バックアップファイルの存在チェック
        if (Files.exists(fileName)) {
            try {
                // バックアップファイルの削除
                Files.delete(fileName);

            } catch (IOException e) {
                // バックアップファイルの削除に失敗
                LOGGER.error(LogMessages.E_AR_FW_L9004.getMessage(fileName), e);
            }
        }
    }
}
