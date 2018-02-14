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
package jp.co.ntt.atrs.batch.jbbb01003;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import java.util.Date;

/**
 * 運�?種別搭乗�??�?報�?計オブジェクト�??
 * 
 * @author 電電次�?
 */
public class FareTypeAggregationDto {

    /**
     * 搭乗日�?
     */
    private Date departureDate;

    /**
     * 便名�??
     */
    private String flightName;

    /**
     * 運�?種別名�??
     */
    private String fareTypeName;

    /**
     * 搭乗�??数�?
     */
    private int passengerNum;

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
     * 搭乗�??数を取得する�??.
     * 
     * @return 搭乗�??数
     */
    public int getPassengerNum() {
        return passengerNum;
    }

    /**
     * 搭乗�??数を設定する�??
     * 
     * @param passengerNum 搭乗�??数
     */
    public void setPassengerNum(int passengerNum) {
        this.passengerNum = passengerNum;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
    }
}
