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
package jp.co.ntt.atrs.batch.jbbb01001;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import java.util.Date;

/**
 * 予�?�?報�?計オブジェクト�??
 * 
 * @author 電電次�?
 */
public class ReservationDto {

    /**
     * 予�?番号�?
     */
    private String reserveNo;

    /**
     * 便名�??
     */
    private String flightName;

    /**
     * 搭乗日�?
     */
    private Date departureDate;

    /**
     * 運�?種別名�??
     */
    private String fareTypeName;

    /**
     * 出発空港�?
     */
    private String depAirport;

    /**
     * 出発時刻�?
     */
    private String departureTime;

    /**
     * 到�?空港�?
     */
    private String arrAirport;

    /**
     * 到�?時刻�?
     */
    private String arrivalTime;

    /**
     * 合計��額�??
     */
    private int totalFare;

    /**
     * 予�?番号を取得する�??
     * 
     * @return 予�?番号
     */
    public String getReserveNo() {
        return reserveNo;
    }

    /**
     * 予�?番号を設定する�??
     * 
     * @param reserveNo 予�?番号
     */
    public void setReserveNo(String reserveNo) {
        this.reserveNo = reserveNo;
    }

    /**
     * 便名を取得する�??
     * 
     * @return 便�?
     */
    public String getFlightName() {
        return flightName;
    }

    /**
     * 便名を設定する�??
     * 
     * @param flightName 便�?
     */
    public void setFlightName(String flightName) {
        this.flightName = flightName;
    }

    /**
     * 搭乗日を取得する�??
     * 
     * @return 搭乗日
     */
    public Date getDepartureDate() {
        return departureDate;
    }

    /**
     * 搭乗日を設定する�??
     * 
     * @param departureDate 搭乗日
     */
    public void setDepartureDate(Date departureDate) {
        this.departureDate = departureDate;
    }

    /**
     * 運�?種別名を取得する�??
     * 
     * @return 運�?種別�?
     */
    public String getFareTypeName() {
        return fareTypeName;
    }

    /**
     * 運�?種別名を設定する�??
     * 
     * @param fareTypeName 運�?種別�?
     */
    public void setFareTypeName(String fareTypeName) {
        this.fareTypeName = fareTypeName;
    }

    /**
     * 出発空港を取得する�??
     * 
     * @return 出発空港
     */
    public String getDepAirport() {
        return depAirport;
    }

    /**
     * 到�?空港を設定する�??
     * 
     * @param depAirport 到�?時刻
     */
    public void setDepAirport(String depAirport) {
        this.depAirport = depAirport;
    }

    /**
     * 出発時刻を取得する�??
     * 
     * @return 出発時刻
     */
    public String getDepartureTime() {
        return departureTime;
    }

    /**
     * 出発時刻を設定する�??
     * 
     * @param departureTime 出発時刻
     */
    public void setDepartureTime(String departureTime) {
        this.departureTime = departureTime;
    }

    /**
     * 到�?空港を取得する�??
     * 
     * @return 到�?空港
     */
    public String getArrAirport() {
        return arrAirport;
    }

    /**
     * 到�?空港を設定する�??
     * 
     * @param arrAirport 到�?空港
     */
    public void setArrAirport(String arrAirport) {
        this.arrAirport = arrAirport;
    }

    /**
     * 到�?時刻を取得する�??
     * 
     * @return 到�?時刻
     */
    public String getArrivalTime() {
        return arrivalTime;
    }

    /**
     * 到�?時刻を設定する�??
     * 
     * @param arrivalTime 到�?時刻
     */
    public void setArrivalTime(String arrivalTime) {
        this.arrivalTime = arrivalTime;
    }

    /**
     * 合計��額を取得する�??
     * 
     * @return 合計���?
     */
    public int getTotalFare() {
        return totalFare;
    }

    /**
     * 合計��額を設定する�??
     * 
     * @param totalFare 合計���?
     */
    public void setTotalFare(int totalFare) {
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
