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
package jp.co.ntt.atrs.batch.jbbb01001;

import java.text.SimpleDateFormat;

import org.springframework.batch.item.file.transform.FieldExtractor;
import org.springframework.stereotype.Component;

@Component
public class DepartureDateChangeFieldExtractor implements FieldExtractor<ReservationDto> {

    private SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");

    @Override
    public Object[] extract(ReservationDto item) {

        Object[] values = new Object[9];

        values[0] = item.getReserveNo();
        values[1] = item.getFlightName();
        values[2] = dateFormat.format(item.getDepartureDate());
        values[3] = item.getFareTypeName();
        values[4] = item.getDepAirport();
        values[5] = item.getDepartureTime();
        values[6] = item.getArrAirport();
        values[7] = item.getArrivalTime();
        values[8] = item.getTotalFare();

        return values;
    }

}
