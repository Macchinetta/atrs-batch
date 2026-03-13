/*
 * Copyright(c) 2017 NTT Corporation.
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

import org.springframework.batch.item.file.transform.FieldExtractor;
import org.springframework.stereotype.Component;

import java.time.format.DateTimeFormatter;

@Component
public class ReserveFlightBackupDtoDateChangeFieldExtractor implements FieldExtractor<ReserveFlightBackupDto> {
    @Override
    public Object[] extract(ReserveFlightBackupDto item) {

        DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("yyyyMMdd");

        Object[] values = { item.getReserveFlightNo(),
                item.getReserveNo(),
                dateFormat.format(item.getDepartureDate()),
                item.getFlightName(),
                item.getBoardingClassCd(),
                item.getFareTypeCd() };

        return values;
    }

}
