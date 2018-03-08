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
package jp.co.ntt.atrs.batch.common.listener;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.batch.core.JobExecution;
import org.springframework.batch.core.JobExecutionListener;
import org.springframework.stereotype.Component;

import jp.co.ntt.atrs.batch.common.logging.LogMessages;

@Component
public class JobLoggingListener implements JobExecutionListener {

    /**
     * メッセージ出力に利用するログ機能を提供するインタフェース。
     */
    private static final Logger LOGGER = LoggerFactory.getLogger(JobLoggingListener.class);

    /**
     * ジョブ開始前処理。
     * 
     * @param jobExecution
     */
    @Override
    public void beforeJob(JobExecution jobExecution) {
        // ジョブが開始したことをログに出力する。
        LOGGER.info(LogMessages.I_AR_FW_L0001.getMessage(jobExecution.getJobInstance().getJobName()));
    }

    /**
     * ジョブ終了後処理。
     * 
     * @param jobExecution
     */
    @Override
    public void afterJob(JobExecution jobExecution) {
        // ジョブが終了したことをログに出力する。
        LOGGER.info(LogMessages.I_AR_FW_L0002.getMessage(jobExecution.getJobInstance().getJobName()));
    }

}
