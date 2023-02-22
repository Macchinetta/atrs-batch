/*
 * Copyright(c) 2023 NTT Corporation.
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
package jp.co.ntt.atrs.batch.common.mapstruct;

import jp.co.ntt.atrs.batch.jbba02001.PassengerBackupDto;
import jp.co.ntt.atrs.batch.jbba02001.PassengerDto;
import org.mapstruct.Mapper;

/**
 * 搭乗者情報テーブルオブジェクト変換用Mapperインタフェース。
 *
 * @author 電電 次郎
 */
@Mapper
public interface PassengerDtoMapper {

    /**
     * PassengerDtoからPassengerBackupDtoへの変換処理。
     *
     * @param passengerDto
     * @return 搭乗者情報退避オブジェクト
     */
    PassengerBackupDto map(PassengerDto passengerDto);

}
