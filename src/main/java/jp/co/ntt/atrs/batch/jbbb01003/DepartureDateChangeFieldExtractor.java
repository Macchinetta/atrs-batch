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
package jp.co.ntt.atrs.batch.jbbb01003;

import java.text.DateFormat;
import java.text.SimpleDateFormat;

import org.springframework.batch.item.file.transform.FieldExtractor;
import org.springframework.stereotype.Component;

@Component
public class DepartureDateChangeFieldExtractor implements FieldExtractor<FareTypeAggregationDto> {
    @Override
    public Object[] extract(FareTypeAggregationDto item) {

        DateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");

        Object[] values = new Object[4];

        values[0] = dateFormat.format(item.getDepartureDate());
        values[1] = item.getFlightName();
        values[2] = item.getFareTypeName();
        values[3] = item.getPassengerNum();

        return values;
    }

}
