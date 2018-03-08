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
package jp.co.ntt.atrs.batch.jbbb01001;

import jp.co.ntt.atrs.batch.common.validate.FixedLength;
import jp.co.ntt.atrs.batch.common.validate.HalfWidthAlphaNumber;
import jp.co.ntt.atrs.batch.common.validate.HalfWidthNumber;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import java.util.Date;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 * 予約情報集計結果オブジェクト。
 * 
 * @author 電電次郎
 */
public class ReservationResultDto {

    /**
     * 予約日時。
     */
    @NotNull
    private Date reserveDate;

    /**
     * 予約番号。
     */
    @NotNull
    @HalfWidthNumber
    @FixedLength(10)
    private String reserveNo;

    /**
     * 便名。
     */
    @NotNull
    @HalfWidthAlphaNumber
    @FixedLength(6)
    private String flightName;

    /**
     * 搭乗日。
     */
    @NotNull
    private Date departureDate;

    /**
     * 運賃種別名。
     */
    @NotNull
    @Size(max = 10, min = 1)
    private String fareTypeName;

    /**
     * 出発空港。
     */
    @NotNull
    @Size(max = 15, min = 1)
    private String depAirport;

    /**
     * 出発時刻。
     */
    @NotNull
    @HalfWidthNumber
    @FixedLength(4)
    private String departureTime;

    /**
     * 到着空港。
     */
    @NotNull
    @Size(max = 15, min = 1)
    private String arrAirport;

    /**
     * 到着時刻。
     */
    @NotNull
    @HalfWidthNumber
    @FixedLength(4)
    private String arrivalTime;

    /**
     * 合計金額。
     */
    @NotNull
    private Integer totalFare;

    /**
     * 予約日付を取得する。
     * 
     * @return 予約日付
     */
    public Date getReserveDate() {
        return reserveDate;
    }

    /**
     * 予約日付を設定する。
     * 
     * @param reserveDate 予約日付
     */
    public void setReserveDate(Date reserveDate) {
        this.reserveDate = reserveDate;
    }

    /**
     * 予約番号を取得する。
     * 
     * @return 予約番号
     */
    public String getReserveNo() {
        return reserveNo;
    }

    /**
     * 予約番号を設定する。
     * 
     * @param reserveNo 予約番号
     */
    public void setReserveNo(String reserveNo) {
        this.reserveNo = reserveNo;
    }

    /**
     * 便名を取得する。
     * 
     * @return 便名
     */
    public String getFlightName() {
        return flightName;
    }

    /**
     * 便名を設定する。
     * 
     * @param flightName 便名
     */
    public void setFlightName(String flightName) {
        this.flightName = flightName;
    }

    /**
     * 搭乗日を取得する。
     * 
     * @return 搭乗日
     */
    public Date getDepartureDate() {
        return departureDate;
    }

    /**
     * 搭乗日を設定する。
     * 
     * @param departureDate 搭乗日
     */
    public void setDepartureDate(Date departureDate) {
        this.departureDate = departureDate;
    }

    /**
     * 運賃種別名を取得する。
     * 
     * @return 運賃種別名
     */
    public String getFareTypeName() {
        return fareTypeName;
    }

    /**
     * 運賃種別名を設定する。
     * 
     * @param fareTypeName 運賃種別名
     */
    public void setFareTypeName(String fareTypeName) {
        this.fareTypeName = fareTypeName;
    }

    /**
     * 出発空港を取得する。
     * 
     * @return 出発空港
     */
    public String getDepAirport() {
        return depAirport;
    }

    /**
     * 到着空港を設定する。
     * 
     * @param depAirport 到着時刻
     */
    public void setDepAirport(String depAirport) {
        this.depAirport = depAirport;
    }

    /**
     * 出発時刻を取得する。
     * 
     * @return 出発時刻
     */
    public String getDepartureTime() {
        return departureTime;
    }

    /**
     * 出発時刻を設定する。
     * 
     * @param departureTime 出発時刻
     */
    public void setDepartureTime(String departureTime) {
        this.departureTime = departureTime;
    }

    /**
     * 到着空港を取得する。
     * 
     * @return 到着空港
     */
    public String getArrAirport() {
        return arrAirport;
    }

    /**
     * 到着空港を設定する。
     * 
     * @param arrAirport 到着空港
     */
    public void setArrAirport(String arrAirport) {
        this.arrAirport = arrAirport;
    }

    /**
     * 到着時刻を取得する。
     * 
     * @return 到着時刻
     */
    public String getArrivalTime() {
        return arrivalTime;
    }

    /**
     * 到着時刻を設定する。
     * 
     * @param arrivalTime 到着時刻
     */
    public void setArrivalTime(String arrivalTime) {
        this.arrivalTime = arrivalTime;
    }

    /**
     * 合計金額を取得する。
     * 
     * @return 合計金額
     */
    public Integer getTotalFare() {
        return totalFare;
    }

    /**
     * 合計金額を設定する。
     * 
     * @param totalFare 合計金額
     */
    public void setTotalFare(Integer totalFare) {
        this.totalFare = totalFare;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
    }
}
