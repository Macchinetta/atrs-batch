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

import org.springframework.batch.core.ExitStatus;
import org.springframework.batch.core.JobExecution;
import org.springframework.batch.core.JobExecutionListener;
import org.springframework.batch.core.StepExecution;
import org.springframework.stereotype.Component;

import java.util.Collection;

@Component
public class JobExitCodeChangeListener implements JobExecutionListener {

    @Override
    public void beforeJob(JobExecution jobExecution) {
        // do nothing.
    }

    @Override
    public void afterJob(JobExecution jobExecution) {
        Collection<StepExecution> stepExecutions = jobExecution.getStepExecutions();
        for (StepExecution stepExecution : stepExecutions) {
            String exitCode = stepExecution.getExitStatus().getExitCode();

            if (exitCode != null && !exitCode.isEmpty()) {
                switch (exitCode) {
                    case "NORMAL":
                    case "NORMAL_NONE_TARGET":
                    case "WARNING":
                    case "BUSINESS_ERROR":
                    case "SYSTEM_ERROR":
                        jobExecution.setExitStatus(new ExitStatus(exitCode));
                        break;
                    default:
                        // do nothing.
                }
            }
        }
    }
}
