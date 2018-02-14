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
package jp.co.ntt.atrs.batch.jbba02001;

import jp.co.ntt.atrs.batch.common.validate.FixedLength;
import jp.co.ntt.atrs.batch.common.validate.FullWidthKatakana;
import jp.co.ntt.atrs.batch.common.validate.HalfWidthAlpha;
import jp.co.ntt.atrs.batch.common.validate.HalfWidthNumber;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 * 搭乗�??�?報�?ーブルオブジェクト�??
 * 
 * @author NTT 電電太�?
 */
public class PassengerDto {

    /**
     * 搭乗�??番号�?
     */
    @NotNull
    private Integer passengerNo;

    /**
     * 予�?フライト番号�?
     */
    @NotNull
    private Integer reserveFlightNo;

    /**
     * 姓�??
     */
    @NotNull
    @FullWidthKatakana
    @Size(min = 1, max = 10)
    private String familyName;

    /**
     * 名�??
     */
    @NotNull
    @FullWidthKatakana
    @Size(min = 1, max = 10)
    private String givenName;

    /**
     * 年齢�?
     */
    @NotNull
    private Integer age;

    /**
     * 性別�?
     */
    @NotNull
    @HalfWidthAlpha
    @FixedLength(1)
    private String gender;

    /**
     * お客様番号�?
     */
    @HalfWidthNumber
    @FixedLength(10)
    private String customerNo;

    /**
     * 搭乗�??番号 を取得する�??
     * 
     * @return 搭乗�??番号
     */
    public Integer getPassengerNo() {
        return passengerNo;
    }

    /**
     * 搭乗�??番号 を設定する�??
     * 
     * @param passengerNo 搭乗�??番号
     */
    public void setPassengerNo(Integer passengerNo) {
        this.passengerNo = passengerNo;
    }

    /**
     * 予�?フライト番号 を取得する�??
     * 
     * @return 予�?フライト番号
     */
    public Integer getReserveFlightNo() {
        return reserveFlightNo;
    }

    /**
     * 予�?フライト番号 を設定する�??
     * 
     * @param reserveFlightNo 予�?フライト番号
     */
    public void setReserveFlightNo(Integer reserveFlightNo) {
        this.reserveFlightNo = reserveFlightNo;
    }

    /**
     * �? を取得する�??
     * 
     * @return �?
     */
    public String getFamilyName() {
        return familyName;
    }

    /**
     * �? を設定する�??
     * 
     * @param familyName �?
     */
    public void setFamilyName(String familyName) {
        this.familyName = familyName;
    }

    /**
     * �? を取得する�??
     * 
     * @return �?
     */
    public String getGivenName() {
        return givenName;
    }

    /**
     * �? を設定する�??
     * 
     * @param givenName �?
     */
    public void setGivenName(String givenName) {
        this.givenName = givenName;
    }

    /**
     * 年齢 を取得する�??
     * 
     * @return 年齢
     */
    public Integer getAge() {
        return age;
    }

    /**
     * 年齢 を設定する�??
     * 
     * @param age 年齢
     */
    public void setAge(Integer age) {
        this.age = age;
    }

    /**
     * 性別 を取得する�??
     * 
     * @return 性別
     */
    public String getGender() {
        return gender;
    }

    /**
     * 性別 を設定する�??
     * 
     * @param gender 性別
     */
    public void setGender(String gender) {
        this.gender = gender;
    }

    /**
     * お客様番号 を取得する�??
     * 
     * @return お客様番号
     */
    public String getCustomerNo() {
        return customerNo;
    }

    /**
     * お客様番号 を設定する�??
     * 
     * @param customerNo お客様番号
     */
    public void setCustomerNo(String customerNo) {
        this.customerNo = customerNo;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
    }
}
