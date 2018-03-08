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
package jp.co.ntt.atrs.batch.jbba01001;

import jp.co.ntt.atrs.batch.jbba00.FlightDto;

/**
 * フライト情報更新ジョブで使用するDAOインターフェース。
 * 
 * @author NTT 電電太郎
 */
public interface JBBA01001BatchDao {

    /**
     * フライト情報を登録する。
     * 
     * @param flightDto フライト情報テーブルオブジェクト
     * @return フライト情報登録件数
     */
    int insertFlight(FlightDto flightDto);

}
