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

import java.nio.file.Paths;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.batch.core.ExitStatus;
import org.springframework.batch.core.StepExecution;
import org.springframework.batch.core.StepExecutionListener;
import org.springframework.batch.item.ItemStreamException;
import org.springframework.batch.item.ReaderNotOpenException;
import org.springframework.batch.item.file.FlatFileParseException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import jp.co.ntt.atrs.batch.common.exception.AtrsBatchException;
import jp.co.ntt.atrs.batch.common.logging.LogMessages;

@Component
public class JBBA01001StepExecutionListener implements StepExecutionListener {

    /**
     * メッセージ出力に利用するログ機能を提供するインタフェース。
     */
    private static final Logger LOGGER = LoggerFactory.getLogger(
            JBBA01001StepExecutionListener.class);
    
    /**
     * フライト情報更新ファイルパス
     */
    @Value("${path.FlightUpdate}")
    private String PATH_FLIGHT_UPDATE;
    
    /**
     * ユーザーの現在の作業ディレクトリ。
     */
    @Value("${user.dir}")
    private String userDir;

    @Override
    public void beforeStep(StepExecution stepExecution) {
        // 入力先ファイルをログに出力
        LOGGER.info(LogMessages.I_AR_FW_L0004.getMessage(Paths.get(userDir, PATH_FLIGHT_UPDATE).toString()));
    }

    @Override
    public ExitStatus afterStep(StepExecution stepExecution) {
        // エラー情報がある場合は、例外ハンドリングを行う。
        for (Throwable th : stepExecution.getFailureExceptions()) {
            if (th instanceof ItemStreamException) {
                if (th.getCause() instanceof IllegalStateException) {
                    // 更新ファイルの取得失敗（10:警告終了）
                    LOGGER.warn(LogMessages.W_AR_BA01_L8001.getMessage(Paths.get(userDir, PATH_FLIGHT_UPDATE).toString()));
                    return new ExitStatus("WARNING");
                } else if (th.getCause() instanceof ReaderNotOpenException) {
                    // ファイルオープンエラー
                    LOGGER.error(LogMessages.E_AR_FW_L9006.getMessage());
                    throw new AtrsBatchException(th);
                }
            } else if (th instanceof FlatFileParseException) {
                // 入力データ読込エラー
                LOGGER.error(LogMessages.E_AR_FW_L9007.getMessage());
                throw new AtrsBatchException(th);
            }
        }
        
        // 登録件数を取得する。
        LOGGER.info(LogMessages.I_AR_BA01_L0001.getMessage(String.valueOf(stepExecution.getWriteCount())));

        return new ExitStatus("NORMAL");
    }
}
