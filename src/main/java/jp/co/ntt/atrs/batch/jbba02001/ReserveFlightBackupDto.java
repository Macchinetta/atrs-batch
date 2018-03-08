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
package jp.co.ntt.atrs.batch.jbba02001;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import java.util.Date;

/**
 * 予約フライト情報退避オブジェクト。
 * 
 * @author NTT 電電太郎
 */
public class ReserveFlightBackupDto {

    /**
     * 予約フライト番号。
     */
    private int reserveFlightNo;

    /**
     * 予約番号。
     */
    private String reserveNo;

    /**
     * 搭乗日。
     */
    private Date departureDate;

    /**
     * 便名。
     */
    private String flightName;

    /**
     * 搭乗クラスコード。
     */
    private String boardingClassCd;

    /**
     * 運賃種別コード。
     */
    private String fareTypeCd;

    /**
     * 予約フライト番号 を取得する。
     * 
     * @return 予約フライト番号
     */
    public int getReserveFlightNo() {
        return reserveFlightNo;
    }

    /**
     * 予約フライト番号 を設定する。
     * 
     * @param reserveFlightNo 予約フライト番号
     */
    public void setReserveFlightNo(int reserveFlightNo) {
        this.reserveFlightNo = reserveFlightNo;
    }

    /**
     * 予約番号 を取得する。
     * 
     * @return 予約番号
     */
    public String getReserveNo() {
        return reserveNo;
    }

    /**
     * 予約番号 を設定する。
     * 
     * @param reserveNo 予約番号
     */
    public void setReserveNo(String reserveNo) {
        this.reserveNo = reserveNo;
    }

    /**
     * 搭乗日 を取得する。
     * 
     * @return 搭乗日
     */
    public Date getDepartureDate() {
        return departureDate;
    }

    /**
     * 搭乗日 を設定する。
     * 
     * @param departureDate 搭乗日
     */
    public void setDepartureDate(Date departureDate) {
        this.departureDate = departureDate;
    }

    /**
     * 便名 を取得する。
     * 
     * @return 便名
     */
    public String getFlightName() {
        return flightName;
    }

    /**
     * 便名 を設定する。
     * 
     * @param flightName 便名
     */
    public void setFlightName(String flightName) {
        this.flightName = flightName;
    }

    /**
     * 搭乗クラスコード を取得する。
     * 
     * @return 搭乗クラスコード
     */
    public String getBoardingClassCd() {
        return boardingClassCd;
    }

    /**
     * 搭乗クラスコード を設定する。
     * 
     * @param boardingClassCd 搭乗クラスコード
     */
    public void setBoardingClassCd(String boardingClassCd) {
        this.boardingClassCd = boardingClassCd;
    }

    /**
     * 運賃種別コード を取得する。
     * 
     * @return 運賃種別コード
     */
    public String getFareTypeCd() {
        return fareTypeCd;
    }

    /**
     * 運賃種別コード を設定する。
     * 
     * @param fareTypeCd 運賃種別コード
     */
    public void setFareTypeCd(String fareTypeCd) {
        this.fareTypeCd = fareTypeCd;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
    }
}
