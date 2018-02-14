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
 * 不要なフライト情報をフライト情報バックア�?プファイルに出力し、DBの不要なフライト情報を削除する�?
 * 
 * @author NTT 電電太�?
 */
@Component("JBBA02001Tasklet")
@Scope("step")
public class JBBA02001Tasklet implements Tasklet {
    /**
     * メ�?セージ出力に利用するログ機�?�を提供するインタフェース�?
     */
    private static final Logger LOGGER = LoggerFactory.getLogger(JBBA02001Tasklet.class);

    /**
     * フライト情報入力チェ�?ク用のバリ�?ータ�?
     */
    @Inject
    Validator<FlightDto> flightDtoValidator;

    /**
     * 予�?フライト情報入力チェ�?ク用のバリ�?ータ�?
     */
    @Inject
    Validator<ReserveFlightDto> reserveFlightDtoValidator;

    /**
     * 搭乗�??�?報入力チェ�?ク用のバリ�?ータ�?
     */
    @Inject
    Validator<PassengerDto> passengerDtoValidator;

    /**
     * メ�?セージ管�?機�?��?
     */
    @Inject
    MessageSource messageSource;

    /**
     * フライト情報バックア�?プファイル操作機�?�で提供する�?��?のインターフェース�?
     */
    @Inject
    ItemStreamWriter<FlightBackupDto> flightBackupFileWriter;

    /**
     * 予�?フライト情報バックア�?プファイル操作機�?�で提供する�?��?のインターフェース�?
     */
    @Inject
    ItemStreamWriter<PassengerBackupDto> passengerBackupFileWriter;

    /**
     * 搭乗�??�?報バックア�?プファイル操作機�?�で提供する�?��?のインターフェース�?
     */
    @Inject
    ItemStreamWriter<ReserveFlightBackupDto> reserveFlightBackupFileWriter;

    /**
     * フライト情報�?避DAOインタフェース�?
     */
    @Inject
    JBBA02001Dao dao;

    /**
     * Beanマッパ�?��?
     */
    @Inject
    Mapper beanMapper;

    /**
     * ユーザーの現在の作業�?ィレクトリ
     */
    @Value("${user.dir}")
    private String userDir;

    /**
     * フライト情報バックア�?プファイルパス
     */
    @Value("${path.FlightBackup}")
    private String PATH_FLIGHT_BACKUP;

    /**
     * 予�?フライト情報バックア�?プファイルパス
     */
    @Value("${path.ReserveFlightBackup}")
    private String PATH_RESERVE_FLIGHT_BACKUP;

    /**
     * 搭乗�??�?報バックア�?プファイルパス
     */
    @Value("${path.PassengerBackup}")
    private String PATH_PASSENGER_BACKUP;

    @Override
    public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {

        // シス�?�?日時を取得し、日�?"01"、時間を"00:00:00"に変更した日時をバッチ�?��?日時として保持
        final Calendar calendar = Calendar.getInstance();
        calendar.set(calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH), 1, 0, 0, 0);

        // �?避を実施した年�?
        final String fileYYYYMM = new LocalDate(calendar.getTime()).toString("yyyyMM");

        // バッチ�?��?日時か�?1か月さかのぼった日時を�?避処�?日時として保持
        calendar.add(Calendar.MONTH, -1);
        final Date paramDate = calendar.getTime();

        // バックア�?プファイルのパスを取�?
        Path flightBackupFile = Paths.get(userDir, PATH_FLIGHT_BACKUP);
        Path reserveFlightBackupFile = Paths.get(userDir, PATH_RESERVE_FLIGHT_BACKUP);
        Path passengerBackupFile = Paths.get(userDir, PATH_PASSENGER_BACKUP);

        // リネ�?��?ファイル
        String renameFlightBackupFile = MessageFormat.format(flightBackupFile.toString(), fileYYYYMM);
        String renameReserveFlightBackupFile = MessageFormat.format(reserveFlightBackupFile.toString(), fileYYYYMM);
        String renamePassengerBackupFile = MessageFormat.format(passengerBackupFile.toString(), fileYYYYMM);

        // 正常終�?フラグ?�?false?��異常?�?
        boolean normalEndFlg = false;

        try {
            // フライト情報のバックア�?プ�?��?
            int flightBackupCnt = backupFlightDb(paramDate, flightBackupFile.toString(), renameFlightBackupFile,
                    chunkContext);

            if (flightBackupCnt == 0) {
                // �?避対象のフライト情報無し�?10:警告終�??�?
                LOGGER.warn(LogMessages.W_AR_BA02_L8001.getMessage());
                contribution.setExitStatus(new ExitStatus("WARNING"));
                return RepeatStatus.FINISHED;
            }

            // フライト情報の出力�?�ファイルとファイル出力件数をログに出�?
            LOGGER.info(LogMessages.I_AR_FW_L0003.getMessage(renameFlightBackupFile, String.valueOf(flightBackupCnt)));

            // 予�?フライト情報のバックア�?プ�?��?
            int reserveFlightBackupCnt = backupReserveFlightDb(paramDate, reserveFlightBackupFile.toString(),
                    renameReserveFlightBackupFile, chunkContext);

            // 予�?フライト情報の出力�?�ファイルとファイル出力件数をログに出�?
            LOGGER.info(LogMessages.I_AR_FW_L0003.getMessage(renameReserveFlightBackupFile,
                    String.valueOf(reserveFlightBackupCnt)));

            // 搭乗�??�?報のバックア�?プ�?��?
            int passengerBackupCnt = backupPassengerDb(paramDate, passengerBackupFile.toString(),
                    renamePassengerBackupFile, chunkContext);

            // 搭乗�??�?報の出力�?�ファイルとファイル出力件数をログに出�?
            LOGGER.info(LogMessages.I_AR_FW_L0003.getMessage(renamePassengerBackupFile,
                    String.valueOf(passengerBackupCnt)));

            // 搭乗�??�?報のDB削除と削除件数ログ出�?
            int passengerDelCnt = dao.deletePassenger(paramDate);

            LOGGER.info(LogMessages.I_AR_BA02_L0001.getMessage("搭乗�??�?報", String.valueOf(passengerDelCnt)));

            // 予�?フライト情報のDB削除と削除件数ログ出�?
            final int reserveFlightDelCnt = dao.deleteReserveFlight(paramDate);
            LOGGER.info(LogMessages.I_AR_BA02_L0001.getMessage("予�?フライト情報", String.valueOf(reserveFlightDelCnt)));

            // フライト情報のDB削除と削除件数ログ出�?
            final int flightDelCnt = dao.deleteFlight(paramDate);
            LOGGER.info(LogMessages.I_AR_BA02_L0001.getMessage("フライト情報", String.valueOf(flightDelCnt)));

            // 正常終�?フラグ?�?true?��正常?�?
            normalEndFlg = true;
        } finally {
            // エラー発生によるロールバックの場合�?�バックア�?プファイルを削除
            if (!normalEndFlg) {
                deleteFile(Paths.get(renameFlightBackupFile));
                deleteFile(Paths.get(renameReserveFlightBackupFile));
                deleteFile(Paths.get(renamePassengerBackupFile));
            }
        }

        // ジョブ終�?コード�?0:正常終�??�?
        contribution.setExitStatus(new ExitStatus("NORMAL"));
        return RepeatStatus.FINISHED;
    }

    /**
     * フライト情報DB�?ータのバックア�?プ�?��?�?
     * 
     * @param paramDate �?避処�?日�?
     * @param fileName バックア�?プファイルのファイル�?(リネ�?��?�?)
     * @param newFileName バックア�?プファイルのファイル�?(リネ�?��?�?)
     * @param chunkContext ファイル入出力パラメータ
     * @return バックア�?プ件数
     * @throws AtrsBatchException
     */
    private int backupFlightDb(Date paramDate, String fileName, String newFileName, ChunkContext chunkContext)
            throws AtrsBatchException {

        int cnt = 0;

        try {
            // ファイルオープン
            flightBackupFileWriter.open(chunkContext.getStepContext().getStepExecution().getExecutionContext());

            // DBから�?ータ取�?
            List<FlightDto> dbData = dao.findFlightList(paramDate);

            // DBから�?ータを取�?
            for (FlightDto inputdata : dbData) {
                // 入力チェ�?クエラーハンドリング
                try {
                    flightDtoValidator.validate(inputdata);
                } catch (ValidationException e) {
                    // FieldErrorsの個数�?、以下�?�処�?を繰り返す
                    for (FieldError fieldError : ((BindException) e.getCause()).getFieldErrors()) {
                        // 入力チェ�?クエラーメ�?セージを�?��?
                        LOGGER.warn(messageSource.getMessage(fieldError, null) + "[" + fieldError.getRejectedValue()
                                + "]" + "(" + inputdata.toString() + ")");
                    }
                    // 入力チェ�?クエラー
                    LOGGER.error(LogMessages.E_AR_FW_L9003.getMessage(), e);
                    throw new AtrsBatchException(e);
                }
                // DTOの詰め替え�?��?
                FlightBackupDto printData = beanMapper.map(inputdata, FlightBackupDto.class);

                // バックア�?プファイルへの書込み
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
                // クローズ失�?
                if (LOGGER.isDebugEnabled()) {
                    LOGGER.debug("クローズ失�?", e);
                }
            }
        }
        
        try {
            // リネ�?��?
            Files.move(Paths.get(fileName), Paths.get(newFileName));
        } catch (IOException e) {
            // リネ�?��?失�?
            LOGGER.error(LogMessages.E_AR_FW_L9009.getMessage(fileName, newFileName), e);
            throw new AtrsBatchException(e);
        }

        return cnt;
    }

    /**
     * 予�?フライト情報DB�?ータのバックア�?プ�?��?�?
     * 
     * @param paramDate �?避処�?日�?
     * @param fileName バックア�?プファイルのファイル�?(リネ�?��?�?)
     * @param newFileName バックア�?プファイルのファイル�?(リネ�?��?�?)
     * @param chunkContext ファイル入出力パラメータ
     * @return バックア�?プ件数
     * @throws AtrsBatchException
     */
    private int backupReserveFlightDb(Date paramDate, String fileName, String newFileName, ChunkContext chunkContext)
            throws AtrsBatchException {

        int cnt = 0;

        try {
            // ファイルオープン
            reserveFlightBackupFileWriter.open(chunkContext.getStepContext().getStepExecution().getExecutionContext());

            // DBから�?ータ取�?
            List<ReserveFlightDto> dbData = dao.findReserveFlightList(paramDate);

            // 次要�?に�?ータが存在するまで処�?を繰り返す
            for (ReserveFlightDto inputdata : dbData) {
                // 入力チェ�?クエラーハンドリング
                try {
                    reserveFlightDtoValidator.validate(inputdata);
                } catch (ValidationException e) {
                    // FieldErrorsの個数�?、以下�?�処�?を繰り返す
                    for (FieldError fieldError : ((BindException) e.getCause()).getFieldErrors()) {
                        // 入力チェ�?クエラーメ�?セージを�?��?
                        LOGGER.warn(messageSource.getMessage(fieldError, null) + "[" + fieldError.getRejectedValue()
                                + "]" + "(" + inputdata.toString() + ")");
                    }

                    // 入力チェ�?クエラー
                    LOGGER.error(LogMessages.E_AR_FW_L9003.getMessage(), e);
                    throw new AtrsBatchException(e);
                }
                // DTOの詰め替え�?��?
                ReserveFlightBackupDto printData = beanMapper.map(inputdata, ReserveFlightBackupDto.class);

                // バックア�?プファイルへの書込み
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
                // クローズ失�?
                if (LOGGER.isDebugEnabled()) {
                    LOGGER.debug("クローズ失�?", e);
                }
            }
        }
        
        try {
            // リネ�?��?
            Files.move(Paths.get(fileName), Paths.get(newFileName));
        } catch (IOException e) {
            // リネ�?��?失�?
            LOGGER.error(LogMessages.E_AR_FW_L9009.getMessage(fileName, newFileName), e);
            throw new AtrsBatchException(e);
        }

        return cnt;
    }

    /**
     * 搭乗�??�?報DB�?ータのバックア�?プ�?��?�?
     * 
     * @param paramDate �?避処�?日�?
     * @param fileName バックア�?プファイルのファイル�?(リネ�?��?�?)
     * @param newFileName バックア�?プファイルのファイル�?(リネ�?��?�?)
     * @param chunkContext ファイル入出力パラメータ
     * @return バックア�?プ件数
     * @throws AtrsBatchException
     */
    private int backupPassengerDb(Date paramDate, String fileName, String newFileName, ChunkContext chunkContext)
            throws AtrsBatchException {

        int cnt = 0;

        try {
            // ファイルオープン
            passengerBackupFileWriter.open(chunkContext.getStepContext().getStepExecution().getExecutionContext());

            // DBから�?ータ取�?
            List<PassengerDto> dbData = dao.findPassengerList(paramDate);

            // 次要�?に�?ータが存在するまで処�?を繰り返す
            for (PassengerDto inputdata : dbData) {
                // 入力チェ�?クエラーハンドリング
                try {
                    passengerDtoValidator.validate(inputdata);
                } catch (ValidationException e) {
                    // FieldErrorsの個数�?、以下�?�処�?を繰り返す
                    for (FieldError fieldError : ((BindException) e.getCause()).getFieldErrors()) {
                        // 入力チェ�?クエラーメ�?セージを�?��?
                        LOGGER.warn(messageSource.getMessage(fieldError, null) + "[" + fieldError.getRejectedValue()
                                + "]" + "(" + inputdata.toString() + ")");
                    }

                    // 入力チェ�?クエラー
                    LOGGER.error(LogMessages.E_AR_FW_L9003.getMessage(), e);
                    throw new AtrsBatchException(e);
                }

                // DTOの詰め替え�?��?
                PassengerBackupDto printData = beanMapper.map(inputdata, PassengerBackupDto.class);

                // バックア�?プファイルへの書込み
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
                // クローズ失�?
                if (LOGGER.isDebugEnabled()) {
                    LOGGER.debug("クローズ失�?", e);
                }
            }
        }
        
        try {
            // リネ�?��?
            Files.move(Paths.get(fileName), Paths.get(newFileName));
        } catch (IOException e) {
            // リネ�?��?失�?
            LOGGER.error(LogMessages.E_AR_FW_L9009.getMessage(fileName, newFileName), e);
            throw new AtrsBatchException(e);
        }

        return cnt;
    }

    /**
     * バックア�?プファイル削除�?
     * 
     * @param fileName バックア�?プファイルのファイル�?
     */
    private void deleteFile(Path fileName) {
        // バックア�?プファイルの存在チェ�?ク
        if (Files.exists(fileName)) {
            try {
                // バックア�?プファイルの削除
                Files.delete(fileName);

            } catch (IOException e) {
                // バックア�?プファイルの削除に失�?
                LOGGER.error(LogMessages.E_AR_FW_L9004.getMessage(fileName), e);
            }
        }
    }
}
