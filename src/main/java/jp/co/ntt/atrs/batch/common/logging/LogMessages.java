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
package jp.co.ntt.atrs.batch.common.logging;

import java.text.MessageFormat;

/**
 * ログメ�?セージを定義する列挙型�??
 * 
 * @author NTT 電電太�?
 */
public enum LogMessages {

    /**
     * ファイル出力失敗が発生した事を通知するログメ�?セージ�?
     */
    E_AR_FW_L9001("e.ar.fw.L9001", "ファイル出力失�? [ {0} ]"),

    /**
     * 日付変換エラーが発生した事を通知するログメ�?セージ�?
     */
    E_AR_FW_L9002("e.ar.fw.L9002", "日付変換エラー [ {0} ]"),

    /**
     * 入力チェ�?クエラーが発生した事を通知するログメ�?セージ�?
     */
    E_AR_FW_L9003("e.ar.fw.L9003", "入力チェ�?クエラー"),

    /**
     * ファイル削除失敗が発生した事を通知するログメ�?セージ�?
     */
    E_AR_FW_L9004("e.ar.fw.L9004", "ファイル削除失�? [ {0} ]"),
    
    /**
     * 型変換エラーが発生した事を通知するログメ�?セージ�?
     */
    E_AR_FW_L9005("e.ar.fw.L9005", "型変換エラー"),
    
    /**
     * ファイルオープンエラーが発生した事を通知するログメ�?セージ�?
     */
    E_AR_FW_L9006("e.ar.fw.L9006", "ファイルオープンエラー"),
    
    /**
     * 入力データ読込エラーが発生した事を通知するログメ�?セージ�?
     */
    E_AR_FW_L9007("e.ar.fw.L9007", "入力データ読込エラー"),
    
    /**
     * DB登録エラーが発生した事を通知するログメ�?セージ�?
     */
    E_AR_FW_L9008("e.ar.fw.L9008", "DB登録エラー"),

    /**
     * 更新ファイルのリネ�?��?失敗が発生した事を通知するログメ�?セージ�?
     */
    E_AR_FW_L9009("e.ar.fw.L9009", "更新ファイルのリネ�?��?失�? [ リネ�?��?�?: {0} ] [ リネ�?��?�?: {1} ]"),

    /**
     * 入力�?�エラー(�?計可能期間�?)が発生した事を通知するログメ�?セージ�?
     */
    E_AR_BB01_L8001("e.ar.bb01.L8001", "入力�?�エラー (�?計可能期間�?)"),

    /**
     * 更新ファイルの取得失敗が発生した事を通知するログメ�?セージ�?
     */
    W_AR_BA01_L8001("w.ar.ba01.L8001", "更新ファイルの取得失�? [ {0} ]"),

    /**
     * �?避対象のフライト情報無しが発生した事を通知するログメ�?セージ�?
     */
    W_AR_BA02_L8001("w.ar.ba02.L8001", "�?避対象のフライト情報無�?"),

    /**
     * 該当する予�?�?報が取得できなかった�?�合に通知するログメ�?セージ�?
     */
    W_AR_BB01_L2001("w.ar.bb01.L2001", "予�?�?報 該当情報無�? (検索条件: 予�?日�?)"),

    /**
     * 該当するフライト情報が取得できなかった�?�合に通知するログメ�?セージ�?
     */
    W_AR_BB01_L2002("w.ar.bb01.L2002", "フライト情報 該当情報無�? (検索条件: 搭乗日)"),

    /**
     * ジョブ�?�開始を通知するログメ�?セージ�?
     */
    I_AR_FW_L0001("i.ar.fw.L0001", "ジョブID:{0}  ジョブ開�?"),

    /**
     * ジョブ�?�終�?を�?�知するログメ�?セージ�?
     */
    I_AR_FW_L0002("i.ar.fw.L0002", "ジョブID:{0}  ジョブ終�?"),

    /**
     * 出力�?�ファイルとファイル出力件数を�?�知するログメ�?セージ�?
     */
    I_AR_FW_L0003("i.ar.fw.L0003", "出力�?�ファイル:{0} ファイル出力件数:{1}件"),

    /**
     * 入力ファイルを�?�知するログメ�?セージ�?
     */
    I_AR_FW_L0004("i.ar.fw.L0004", "入力ファイル:{0}"),

    /**
     * フライト情報登録件数を�?�知するログメ�?セージ�?
     */
    I_AR_BA01_L0001("i.ar.ba01.L0001", "フライト情報登録件数:{0}件"),

    /**
     * �?ータ削除件数を�?�知するログメ�?セージ�?
     */
    I_AR_BA02_L0001("i.ar.ba02.L0001", "削除�?ータ:{0} 削除件数:{1}件"),;

    /**
     * メ�?セージコード�??
     */
    private final String code;

    /**
     * メ�?セージ�?容�?
     */
    private final String message;

    /**
     * コンストラクタ�?
     * 
     * @param code メ�?セージコー�?
     * @param message メ�?セージ�?容
     */
    private LogMessages(String code, String message) {
        this.code = code;
        this.message = "[" + code + "] " + message;
    }

    /**
     * メ�?セージコードを取得する�??
     * 
     * @return メ�?セージコー�?
     */
    public String getCode() {
        return code;
    }

    /**
     * メ�?セージ�?容を取得する�??
     * 
     * @return メ�?セージ�?容
     */
    public String getMessage() {
        return message;
    }

    /**
     * パラメータを指定してメ�?セージ�?容を取得する�??
     * 
     * @param args パラメータ
     * @return メ�?セージ�?容
     */
    public String getMessage(Object... args) {
        return MessageFormat.format(message, args);
    }
}
