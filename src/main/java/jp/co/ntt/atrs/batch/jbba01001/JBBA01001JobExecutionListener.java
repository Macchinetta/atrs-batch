/*
 * Copyright(c) 2018 NTT Corporation.
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

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.batch.core.JobExecution;
import org.springframework.batch.core.JobExecutionListener;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import jp.co.ntt.atrs.batch.common.exception.AtrsBatchException;
import jp.co.ntt.atrs.batch.common.logging.LogMessages;

@Component
public class JBBA01001JobExecutionListener implements JobExecutionListener {

    /**
     * メッセージ出力に利用するログ機能を提供するインタフェース。
     */
    private static final Logger LOGGER = LoggerFactory.getLogger(JBBA01001JobExecutionListener.class);
    
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
    public void beforeJob(JobExecution jobExecution) {
        // do nothing.
    }

    @Override
    public void afterJob(JobExecution jobExecution) {
        // エラーが発生しなかった場合に処理する
        if (jobExecution.getAllFailureExceptions().isEmpty()) {
            // 入出力ファイルのパスを取得
            Path inputFile = Paths.get(userDir, PATH_FLIGHT_UPDATE);
            Path outputFile = Paths.get(userDir, PATH_RENAME_FLIGHT_UPDATE);
            
            try {
                // フライト情報更新ファイルのリネーム
                Files.move(inputFile, outputFile);
            } catch (IOException e) {
                // ファイルリネーム失敗
                LOGGER.error(LogMessages.E_AR_FW_L9009.getMessage(inputFile.toString(), outputFile.toString()), e);
                throw new AtrsBatchException(e);
            }
        }
    }
}
