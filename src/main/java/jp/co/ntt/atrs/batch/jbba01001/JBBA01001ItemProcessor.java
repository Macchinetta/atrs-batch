/*
 * Copyright(c) 2018 NTT Corporation.
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

import javax.inject.Inject;

import org.dozer.Mapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.batch.item.ItemProcessor;
import org.springframework.batch.item.validator.ValidationException;
import org.springframework.batch.item.validator.Validator;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Component;
import org.springframework.validation.BindException;
import org.springframework.validation.FieldError;

import jp.co.ntt.atrs.batch.common.exception.AtrsBatchException;
import jp.co.ntt.atrs.batch.common.logging.LogMessages;
import jp.co.ntt.atrs.batch.common.util.DateUtil;
import jp.co.ntt.atrs.batch.jbba00.FlightDto;

@Component
public class JBBA01001ItemProcessor implements
                                    ItemProcessor<FlightUpdateDto, FlightDto> {

    /**
     * メッセージ出力に利用するログ機能を提供するインタフェース。
     */
    private static final Logger LOGGER = LoggerFactory.getLogger(
            JBBA01001ItemProcessor.class);

    /**
     * 入力チェック用のバリデータ。
     */
    @Inject
    Validator<FlightUpdateDto> validator;

    /**
     * メッセージ管理機能。
     */
    @Inject
    MessageSource messageSource;

    /**
     * Beanマッパー。
     */
    @Inject
    Mapper beanMapper;

    @Override
    public FlightDto process(FlightUpdateDto item) throws Exception {
        // 入力チェックエラーハンドリング
        try {
            validator.validate(item);
        } catch (ValidationException e) {
            // FieldErrorsの個数分、以下の処理を繰り返す
            for (FieldError fieldError : ((BindException) e.getCause())
                    .getFieldErrors()) {
                // 入力チェックエラーメッセージを出力
                LOGGER.warn(messageSource.getMessage(fieldError, null) + "["
                        + fieldError.getRejectedValue() + "]" + "("
                        + item.getCount() + ")");
            }

            // 入力チェックエラー
            LOGGER.error(LogMessages.E_AR_FW_L9003.getMessage(), e);
            throw new AtrsBatchException(e);
        }

        // DTOの詰め替え処理
        FlightDto flightDto = beanMapper.map(item, FlightDto.class);

        try {
            // 日付型変換
            flightDto.setDepartureDate(DateUtil.convertDate(item.getDepartureDateStr()));

            // 数値型変換
            flightDto.setVacantNum(Integer.parseInt(item.getVacantNumStr()));

        } catch (IllegalArgumentException e) {
            // 型変換エラー
            LOGGER.error(LogMessages.E_AR_FW_L9005.getMessage(), e);
            throw new AtrsBatchException(e);
        }

        // フライト情報を登録する
        return flightDto;
    }

}
