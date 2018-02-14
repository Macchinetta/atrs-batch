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
package jp.co.ntt.atrs.batch.common.exception;

/**
 * ATRS-Batch用のExceptionクラス�?
 * 
 * @author NTT 電電太�?
 */
public class AtrsBatchException extends BatchException {

    /**
     * シリアルバ�?�ジョンID
     */
    private static final long serialVersionUID = 6368315692983549460L;

    /**
     * AtrsBatchExceptionを生成す�?
     */
    public AtrsBatchException() {
        super();
    }

    /**
     * AtrsBatchExceptionを生成す�?
     * 
     * @param message エラーメ�?セージ
     */
    public AtrsBatchException(String message) {
        super(message);
    }

    /**
     * AtrsBatchExceptionを生成す�?
     * 
     * @param message エラーメ�?セージ
     * @param cause 原因となった例�?
     */
    public AtrsBatchException(String message, Throwable cause) {
        super(message, cause);
    }

    /**
     * AtrsBatchExceptionを生成す�?
     * 
     * @param cause 原因となった例�?
     */
    public AtrsBatchException(Throwable cause) {
        super(cause);
    }
}
