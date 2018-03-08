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
package jp.co.ntt.atrs.batch.jbbb00;

import jp.co.ntt.atrs.batch.common.logging.LogMessages;
import jp.co.ntt.atrs.batch.common.util.DateUtil;

import org.joda.time.DateTime;
import org.joda.time.Interval;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Date;

/**
 * 集計期間に関するユーティリティクラス。
 * 
 * @author 電電 次郎
 */
public class AggregationPeriodUtil {

    /**
     * メッセージ出力に利用するログ機能を提供するインタフェース。
     */
    private static final Logger LOGGER = LoggerFactory.getLogger(AggregationPeriodUtil.class);

    /**
     * コンストラクタ。
     */
    private AggregationPeriodUtil() {
        // do nothing.
    }

    /**
     * 集計期間オブジェクトを生成する。
     * 
     * @param firstDateStr 集計開始日(yyyyMMddの日付文字列)
     * @param lastDateStr 集計終了日(yyyyMMddの日付文字列)
     * @return 集計期間。引数が日付に変換できない場合、または集計可能期間内でない場合はnull。
     */
    public static AggregationPeriodDto create(String firstDateStr, String lastDateStr) {

        Date firstDate = null;
        Date lastDate = null;
        try {
            // 日付文字列をDate型に変換
            firstDate = DateUtil.convertDate(firstDateStr);
            lastDate = DateUtil.convertDate(lastDateStr);
        } catch (IllegalArgumentException e) {
            // 型変換エラー
            LOGGER.error(LogMessages.E_AR_FW_L9005.getMessage(), e);
            return null;
        }

        // 集計可能期間であるかのチェック。
        if (check(firstDate, lastDate)) {
            return new AggregationPeriodDto(firstDate, lastDate);
        }

        return null;
    }

    /**
     * 集計期間が集計可能期間であるかを判定する。
     * 
     * @param firstDate 集計開始日
     * @param lastDate 集計終了日
     * @return 判定結果
     */
    private static boolean check(Date firstDate, Date lastDate) {

        // 集計開始日、終了日のInterval作成
        DateTime firstDateTime = new DateTime(firstDate);
        DateTime lastDateTime = new DateTime(lastDate);
        Interval interval = null;
        try {
            interval = new Interval(firstDateTime, lastDateTime);
        } catch (IllegalArgumentException e) {
            // 日付チェックエラー
            LOGGER.error(LogMessages.E_AR_BB01_L8001.getMessage(), e);
            return false;
        }

        // 参照可能期間の作成
        DateTime currentDate = new DateTime().withTimeAtStartOfDay();
        DateTime firstFindAvailableDate = currentDate.minusMonths(1).dayOfMonth().withMinimumValue();
        DateTime lastFindAvailableDate = currentDate.plusMillis(1);
        Interval findAvailableInterval = new Interval(firstFindAvailableDate, lastFindAvailableDate);

        if (findAvailableInterval.contains(interval)) {
            return true;
        }
        // 日付チェックエラー
        LOGGER.error(LogMessages.E_AR_BB01_L8001.getMessage());
        return false;
    }

}
