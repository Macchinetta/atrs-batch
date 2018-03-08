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

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import java.util.Date;

/**
 * 集計期間。
 * 
 * @author 電電次郎
 */
public class AggregationPeriodDto {

    /**
     * 集計開始日。
     */
    private Date firstDate;

    /**
     * 集計終了日。
     */
    private Date lastDate;

    /**
     * コンストラクタ。
     * 
     * @param firstDate 集計開始日
     * @param lastDate 集計終了日
     */
    AggregationPeriodDto(Date firstDate, Date lastDate) {
        this.firstDate = firstDate;
        this.lastDate = lastDate;
    }

    /**
     * 集計開始日を取得する。
     * 
     * @return 集計開始日
     */
    public Date getFirstDate() {
        return firstDate;
    }

    /**
     * 集計開始日を設定する。
     * 
     * @param firstDate 集計開始日
     */
    public void setFirstDate(Date firstDate) {
        this.firstDate = firstDate;
    }

    /**
     * 集計終了日を取得する。
     * 
     * @return 集計終了日
     */
    public Date getLastDate() {
        return lastDate;
    }

    /**
     * 集計終了日を設定する。
     * 
     * @param lastDate 集計終了日
     */
    public void setLastDate(Date lastDate) {
        this.lastDate = lastDate;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
    }
}
