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

import jp.co.ntt.atrs.batch.jbba00.FlightDto;
import jp.co.ntt.atrs.batch.jbba01001.FlightUpdateDto;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Named;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * フライト情報更新オブジェクト変換用Mapperインタフェース。
 *
 * @author 電電 次郎
 */
@Mapper
public interface FlightUpdateDtoMapper {

    /**
     * FlightUpdateDtoからFlightDtoへの変換処理。
     *
     * @param flightUpdateDto
     * @return フライト情報テーブルオブジェクト
     */
    @Mapping(target="vacantNum", source="vacantNumStr")
    @Mapping(target="departureDate",source="departureDateStr", qualifiedByName = "stringToDate")
    FlightDto map(FlightUpdateDto flightUpdateDto) throws ParseException;

    @Named("stringToDate")
    default Date stringToDate(String string) throws ParseException {
        if(string == null) {
            return null;
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        Date date = sdf.parse(string);
        return date;
    }

}
