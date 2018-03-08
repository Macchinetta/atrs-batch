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

/**
 * 搭乗者情報退避オブジェクト。
 * 
 * @author NTT 電電太郎
 */
public class PassengerBackupDto {

    /**
     * 搭乗者番号。
     */
    private int passengerNo;

    /**
     * 予約フライト番号。
     */
    private int reserveFlightNo;

    /**
     * 姓。
     */
    private String familyName;

    /**
     * 名。
     */
    private String givenName;

    /**
     * 年齢。
     */
    private int age;

    /**
     * 性別。
     */
    private String gender;

    /**
     * お客様番号。
     */
    private String customerNo;

    /**
     * 搭乗者番号 を取得する。
     * 
     * @return 搭乗者番号
     */
    public int getPassengerNo() {
        return passengerNo;
    }

    /**
     * 搭乗者番号 を設定する。
     * 
     * @param passengerNo 搭乗者番号
     */
    public void setPassengerNo(int passengerNo) {
        this.passengerNo = passengerNo;
    }

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
     * 姓 を取得する。
     * 
     * @return 姓
     */
    public String getFamilyName() {
        return familyName;
    }

    /**
     * 姓 を設定する。
     * 
     * @param familyName 姓
     */
    public void setFamilyName(String familyName) {
        this.familyName = familyName;
    }

    /**
     * 名 を取得する。
     * 
     * @return 名
     */
    public String getGivenName() {
        return givenName;
    }

    /**
     * 名 を設定する。
     * 
     * @param givenName 名
     */
    public void setGivenName(String givenName) {
        this.givenName = givenName;
    }

    /**
     * 年齢 を取得する。
     * 
     * @return 年齢
     */
    public int getAge() {
        return age;
    }

    /**
     * 年齢 を設定する。
     * 
     * @param age 年齢
     */
    public void setAge(int age) {
        this.age = age;
    }

    /**
     * 性別 を取得する。
     * 
     * @return 性別
     */
    public String getGender() {
        return gender;
    }

    /**
     * 性別 を設定する。
     * 
     * @param gender 性別
     */
    public void setGender(String gender) {
        this.gender = gender;
    }

    /**
     * お客様番号 を取得する。
     * 
     * @return お客様番号
     */
    public String getCustomerNo() {
        return customerNo;
    }

    /**
     * お客様番号 を設定する。
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
