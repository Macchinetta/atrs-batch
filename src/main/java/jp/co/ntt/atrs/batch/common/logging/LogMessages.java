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
package jp.co.ntt.atrs.batch.common.logging;

import java.text.MessageFormat;

/**
 * ログメッセージを定義する列挙型。
 * 
 * @author NTT 電電太郎
 */
public enum LogMessages {

    /**
     * ファイル出力失敗が発生した事を通知するログメッセージ。
     */
    E_AR_FW_L9001("e.ar.fw.L9001", "ファイル出力失敗 [ {0} ]"),

    /**
     * 日付変換エラーが発生した事を通知するログメッセージ。
     */
    E_AR_FW_L9002("e.ar.fw.L9002", "日付変換エラー [ {0} ]"),

    /**
     * 入力チェックエラーが発生した事を通知するログメッセージ。
     */
    E_AR_FW_L9003("e.ar.fw.L9003", "入力チェックエラー"),

    /**
     * ファイル削除失敗が発生した事を通知するログメッセージ。
     */
    E_AR_FW_L9004("e.ar.fw.L9004", "ファイル削除失敗 [ {0} ]"),
    
    /**
     * 型変換エラーが発生した事を通知するログメッセージ。
     */
    E_AR_FW_L9005("e.ar.fw.L9005", "型変換エラー"),
    
    /**
     * ファイルオープンエラーが発生した事を通知するログメッセージ。
     */
    E_AR_FW_L9006("e.ar.fw.L9006", "ファイルオープンエラー"),
    
    /**
     * 入力データ読込エラーが発生した事を通知するログメッセージ。
     */
    E_AR_FW_L9007("e.ar.fw.L9007", "入力データ読込エラー"),
    
    /**
     * DB登録エラーが発生した事を通知するログメッセージ。
     */
    E_AR_FW_L9008("e.ar.fw.L9008", "DB登録エラー"),

    /**
     * 更新ファイルのリネーム失敗が発生した事を通知するログメッセージ。
     */
    E_AR_FW_L9009("e.ar.fw.L9009", "更新ファイルのリネーム失敗 [ リネーム元: {0} ] [ リネーム先: {1} ]"),

    /**
     * 入力値エラー(集計可能期間外)が発生した事を通知するログメッセージ。
     */
    E_AR_BB01_L8001("e.ar.bb01.L8001", "入力値エラー (集計可能期間外)"),

    /**
     * 更新ファイルの取得失敗が発生した事を通知するログメッセージ。
     */
    W_AR_BA01_L8001("w.ar.ba01.L8001", "更新ファイルの取得失敗 [ {0} ]"),

    /**
     * 退避対象のフライト情報無しが発生した事を通知するログメッセージ。
     */
    W_AR_BA02_L8001("w.ar.ba02.L8001", "退避対象のフライト情報無し"),

    /**
     * 該当する予約情報が取得できなかった場合に通知するログメッセージ。
     */
    W_AR_BB01_L2001("w.ar.bb01.L2001", "予約情報 該当情報無し (検索条件: 予約日付)"),

    /**
     * 該当するフライト情報が取得できなかった場合に通知するログメッセージ。
     */
    W_AR_BB01_L2002("w.ar.bb01.L2002", "フライト情報 該当情報無し (検索条件: 搭乗日)"),

    /**
     * ジョブの開始を通知するログメッセージ。
     */
    I_AR_FW_L0001("i.ar.fw.L0001", "ジョブID:{0}  ジョブ開始"),

    /**
     * ジョブの終了を通知するログメッセージ。
     */
    I_AR_FW_L0002("i.ar.fw.L0002", "ジョブID:{0}  ジョブ終了"),

    /**
     * 出力先ファイルとファイル出力件数を通知するログメッセージ。
     */
    I_AR_FW_L0003("i.ar.fw.L0003", "出力先ファイル:{0} ファイル出力件数:{1}件"),

    /**
     * 入力ファイルを通知するログメッセージ。
     */
    I_AR_FW_L0004("i.ar.fw.L0004", "入力ファイル:{0}"),

    /**
     * フライト情報登録件数を通知するログメッセージ。
     */
    I_AR_BA01_L0001("i.ar.ba01.L0001", "フライト情報登録件数:{0}件"),

    /**
     * データ削除件数を通知するログメッセージ。
     */
    I_AR_BA02_L0001("i.ar.ba02.L0001", "削除データ:{0} 削除件数:{1}件"),;

    /**
     * メッセージコード。
     */
    private final String code;

    /**
     * メッセージ内容。
     */
    private final String message;

    /**
     * コンストラクタ。
     * 
     * @param code メッセージコード
     * @param message メッセージ内容
     */
    private LogMessages(String code, String message) {
        this.code = code;
        this.message = "[" + code + "] " + message;
    }

    /**
     * メッセージコードを取得する。
     * 
     * @return メッセージコード
     */
    public String getCode() {
        return code;
    }

    /**
     * メッセージ内容を取得する。
     * 
     * @return メッセージ内容
     */
    public String getMessage() {
        return message;
    }

    /**
     * パラメータを指定してメッセージ内容を取得する。
     * 
     * @param args パラメータ
     * @return メッセージ内容
     */
    public String getMessage(Object... args) {
        return MessageFormat.format(message, args);
    }
}
