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

import jp.co.ntt.atrs.batch.jbba00.FlightDto;

import java.util.Date;
import java.util.List;

/**
 * フライト情報退避ジョブで使用するDAOインターフェース。
 * 
 * @author NTT 電電太郎
 */
public interface JBBA02001Dao {

    /**
     * 不要フライト情報を取得する。
     * 
     * @param object パラメータ
     */
    List<FlightDto> findFlightList(Date date);

    /**
     * 不要予約フライト情報を取得する。
     * 
     * @param object パラメータ
     */
    List<ReserveFlightDto> findReserveFlightList(Date date);

    /**
     * 不要搭乗者情報を取得する。
     * 
     * @param object パラメータ
     */
    List<PassengerDto> findPassengerList(Date date);

    /**
     * 不要フライト情報を削除する。
     * 
     * @param date 削除条件の退避処理日時
     * @return 削除件数
     */
    int deleteFlight(Date date);

    /**
     * 不要予約フライト情報を削除する。
     * 
     * @param date 削除条件の退避処理日時
     * @return 削除件数
     */
    int deleteReserveFlight(Date date);

    /**
     * 不要搭乗者情報を削除する。
     * 
     * @param date 削除条件の退避処理日時
     * @return 削除件数
     */
    int deletePassenger(Date date);

}
