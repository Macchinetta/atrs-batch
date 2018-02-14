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
package jp.co.ntt.atrs.batch.common.listener;

import java.util.List;

import org.springframework.batch.core.ExitStatus;
import org.springframework.batch.core.StepExecution;
import org.springframework.batch.core.StepExecutionListener;
import org.springframework.stereotype.Component;

import jp.co.ntt.atrs.batch.common.exception.AtrsBatchException;

@Component
public class AtrsExceptionHandlingListener implements StepExecutionListener {
    @Override
    public void beforeStep(StepExecution stepExecution) {
        // do nothing.
    }

    @Override
    public ExitStatus afterStep(StepExecution stepExecution) {
        // stepExecutionからエラー�?報を取得する�??
        List<Throwable> exceptions = stepExecution.getFailureExceptions();

        // エラー�?報がな�?場合�?�、正常終�?とする�?
        if (exceptions.isEmpty()) {
            return new ExitStatus("NORMAL");
        }

        // エラー�?報がある�?�合�?�、例外ハンドリングを行う�?
        for (Throwable th : exceptions) {
            if (th instanceof AtrsBatchException) {
                // 業務上で想定�??のエラーの場合�?�ジョブ終�?コー�?
                return new ExitStatus("BUSINESS_ERROR");
            }
        }

        // 業務上で想定外�?�エラーの場合�?�ジョブ終�?コー�?
        return new ExitStatus("SYSTEM_ERROR");
    }
}
