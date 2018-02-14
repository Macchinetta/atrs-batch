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
package jp.co.ntt.atrs.batch.jbba01001;

import jp.co.ntt.atrs.batch.common.validate.FixedLength;
import jp.co.ntt.atrs.batch.common.validate.HalfWidthAlpha;
import jp.co.ntt.atrs.batch.common.validate.HalfWidthAlphaNumber;
import jp.co.ntt.atrs.batch.common.validate.HalfWidthNumber;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.batch.item.ItemCountAware;

import javax.validation.constraints.Size;

/**
 * フライト情報更新オブジェクト�??
 * 
 * @author NTT 電電太�?
 */
public class FlightUpdateDto implements ItemCountAware {

    // 何件目の�?ータでエラーとなったかを判定す�?
    private int count;

    /**
     * 搭乗日(�?字�??)�?
     */
    @NotEmpty
    @HalfWidthNumber
    @FixedLength(8)
    private String departureDateStr;

    /**
     * 便名�??
     */
    @NotEmpty
    @HalfWidthAlphaNumber
    @FixedLength(6)
    private String flightName;

    /**
     * 搭乗クラスコード�??
     */
    @NotEmpty
    @HalfWidthAlpha
    @FixedLength(1)
    private String boardingClassCd;

    /**
     * 運�?種別コード�??
     */
    @NotEmpty
    @HalfWidthAlphaNumber
    @Size(min = 1, max = 4)
    private String fareTypeCd;

    /**
     * 空席数(�?字�??)�?
     */
    @NotEmpty
    @HalfWidthNumber
    @Size(min = 1, max = 9)
    private String vacantNumStr;

    /**
     * 搭乗日(�?字�??) を取得する�??
     * 
     * @return 搭乗日(�?字�??)
     */
    public String getDepartureDateStr() {
        return departureDateStr;
    }

    /**
     * 搭乗日(�?字�??) を設定する�??
     * 
     * @param departureDateStr 搭乗日(�?字�??)
     */
    public void setDepartureDateStr(String departureDateStr) {
        this.departureDateStr = departureDateStr;
    }

    /**
     * 便�? を取得する�??
     * 
     * @return 便�?
     */
    public String getFlightName() {
        return flightName;
    }

    /**
     * 便�? を設定する�??
     * 
     * @param flightName 便�?
     */
    public void setFlightName(String flightName) {
        this.flightName = flightName;
    }

    /**
     * 搭乗クラスコー�? を取得する�??
     * 
     * @return 搭乗クラスコー�?
     */
    public String getBoardingClassCd() {
        return boardingClassCd;
    }

    /**
     * 搭乗クラスコー�? を設定する�??
     * 
     * @param boardingClassCd 搭乗クラスコー�?
     */
    public void setBoardingClassCd(String boardingClassCd) {
        this.boardingClassCd = boardingClassCd;
    }

    /**
     * 運�?種別コー�? を取得する�??
     * 
     * @return 運�?種別コー�?
     */
    public String getFareTypeCd() {
        return fareTypeCd;
    }

    /**
     * 運�?種別コー�? を設定する�??
     * 
     * @param fareTypeCd 運�?種別コー�?
     */
    public void setFareTypeCd(String fareTypeCd) {
        this.fareTypeCd = fareTypeCd;
    }

    /**
     * 空席数(�?字�??) を取得する�??
     * 
     * @return 空席数(�?字�??)
     */
    public String getVacantNumStr() {
        return vacantNumStr;
    }

    /**
     * 空席数(�?字�??) を設定する�??
     * 
     * @param vacantNumStr 空席数(�?字�??)
     */
    public void setVacantNumStr(String vacantNumStr) {
        this.vacantNumStr = vacantNumStr;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
    }

    /**
     * エラーになったデータのレコード番号を取得する�??
     * 
     * @return エラーになったデータのレコード番号
     */
    public int getCount() {
        return this.count;
    }

    /**
     * エラーになったデータのレコード番号を設定する�??
     * 
     * @param count エラーになったデータのレコード番号
     */
    @Override
    public void setItemCount(int count) {
        this.count = count;
    }
}