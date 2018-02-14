BEGIN;

CREATE OR REPLACE FUNCTION C_RESERVATION() RETURNS VOID AS $$
DECLARE

  -- システム日付-90日間の予約情報を登録
  startDate DATE := current_date-90;
  endDate DATE := current_date;

  -- 登録期間を明示的に指定する場合
  --startDate DATE := '2014-10-01';
  --endDate DATE := '2014-12-31';
  
  -- 1日あたりに登録する予約情報のループ回数（1から2に変更すると、1日当たりの予約数は2倍になる）
  reservationLoopNum INT := 1;
  
  currentDate DATE := startDate;
  
  i INT;
  j INT;
  
BEGIN
  i := 0;
  j := 0;
  
  WHILE currentDate <= endDate LOOP

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT001', 'N', 'OW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT001', 'N', 'RT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT001', 'N', 'RD1');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT001', 'N', 'RD7');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT001', 'N', 'ED');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT001', 'N', 'LD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT001', 'N', 'GD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT001', 'S', 'SOW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT001', 'S', 'SRT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT001', 'S', 'SRD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT061', 'N', 'OW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT061', 'N', 'RT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT061', 'N', 'RD1');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT061', 'N', 'RD7');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT061', 'N', 'ED');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT061', 'N', 'LD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT061', 'N', 'GD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT061', 'S', 'SOW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT061', 'S', 'SRT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT061', 'S', 'SRD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT121', 'N', 'OW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT121', 'N', 'RT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT121', 'N', 'RD1');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT121', 'N', 'RD7');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT121', 'N', 'ED');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT121', 'N', 'LD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT121', 'N', 'GD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT121', 'S', 'SOW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT121', 'S', 'SRT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT121', 'S', 'SRD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT181', 'N', 'OW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT181', 'N', 'RT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT181', 'N', 'RD1');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT181', 'N', 'RD7');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT181', 'N', 'ED');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT181', 'N', 'LD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT181', 'N', 'GD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT181', 'S', 'SOW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT181', 'S', 'SRT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT181', 'S', 'SRD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT241', 'N', 'OW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT241', 'N', 'RT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT241', 'N', 'RD1');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT241', 'N', 'RD7');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT241', 'N', 'ED');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT241', 'N', 'LD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT241', 'N', 'GD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT241', 'S', 'SOW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT241', 'S', 'SRT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT241', 'S', 'SRD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT301', 'N', 'OW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT301', 'N', 'RT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT301', 'N', 'RD1');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT301', 'N', 'RD7');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT301', 'N', 'ED');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT301', 'N', 'LD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT301', 'N', 'GD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT301', 'S', 'SOW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT301', 'S', 'SRT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT301', 'S', 'SRD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT361', 'N', 'OW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT361', 'N', 'RT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT361', 'N', 'RD1');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT361', 'N', 'RD7');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT361', 'N', 'ED');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT361', 'N', 'LD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT361', 'N', 'GD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT361', 'S', 'SOW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT361', 'S', 'SRT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT361', 'S', 'SRD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT421', 'N', 'OW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT421', 'N', 'RT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT421', 'N', 'RD1');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT421', 'N', 'RD7');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT421', 'N', 'ED');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT421', 'N', 'LD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT421', 'N', 'GD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT421', 'S', 'SOW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT421', 'S', 'SRT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT421', 'S', 'SRD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT481', 'N', 'OW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT481', 'N', 'RT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT481', 'N', 'RD1');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT481', 'N', 'RD7');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT481', 'N', 'ED');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT481', 'N', 'LD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT481', 'N', 'GD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT481', 'S', 'SOW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT481', 'S', 'SRT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT481', 'S', 'SRD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT006', 'N', 'OW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT006', 'N', 'RT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT006', 'N', 'RD1');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT006', 'N', 'RD7');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT006', 'N', 'ED');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT006', 'N', 'LD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT006', 'N', 'GD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT006', 'S', 'SOW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT006', 'S', 'SRT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT006', 'S', 'SRD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT066', 'N', 'OW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT066', 'N', 'RT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT066', 'N', 'RD1');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT066', 'N', 'RD7');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT066', 'N', 'ED');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT066', 'N', 'LD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT066', 'N', 'GD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT066', 'S', 'SOW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT066', 'S', 'SRT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT066', 'S', 'SRD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT126', 'N', 'OW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT126', 'N', 'RT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT126', 'N', 'RD1');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT126', 'N', 'RD7');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT126', 'N', 'ED');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT126', 'N', 'LD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT126', 'N', 'GD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT126', 'S', 'SOW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT126', 'S', 'SRT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT126', 'S', 'SRD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT186', 'N', 'OW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT186', 'N', 'RT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT186', 'N', 'RD1');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT186', 'N', 'RD7');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT186', 'N', 'ED');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT186', 'N', 'LD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT186', 'N', 'GD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT186', 'S', 'SOW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT186', 'S', 'SRT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT186', 'S', 'SRD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT246', 'N', 'OW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT246', 'N', 'RT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT246', 'N', 'RD1');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT246', 'N', 'RD7');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT246', 'N', 'ED');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT246', 'N', 'LD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT246', 'N', 'GD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT246', 'S', 'SOW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT246', 'S', 'SRT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT246', 'S', 'SRD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT306', 'N', 'OW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT306', 'N', 'RT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT306', 'N', 'RD1');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT306', 'N', 'RD7');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT306', 'N', 'ED');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT306', 'N', 'LD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT306', 'N', 'GD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT306', 'S', 'SOW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT306', 'S', 'SRT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT306', 'S', 'SRD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT366', 'N', 'OW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT366', 'N', 'RT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT366', 'N', 'RD1');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT366', 'N', 'RD7');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT366', 'N', 'ED');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT366', 'N', 'LD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT366', 'N', 'GD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT366', 'S', 'SOW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT366', 'S', 'SRT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT366', 'S', 'SRD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT426', 'N', 'OW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT426', 'N', 'RT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT426', 'N', 'RD1');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT426', 'N', 'RD7');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT426', 'N', 'ED');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT426', 'N', 'LD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT426', 'N', 'GD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT426', 'S', 'SOW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT426', 'S', 'SRT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT426', 'S', 'SRD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT486', 'N', 'OW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT486', 'N', 'RT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT486', 'N', 'RD1');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT486', 'N', 'RD7');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT486', 'N', 'ED');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT486', 'N', 'LD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT486', 'N', 'GD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT486', 'S', 'SOW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT486', 'S', 'SRT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT486', 'S', 'SRD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT013', 'N', 'OW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT013', 'N', 'RT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT013', 'N', 'RD1');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT013', 'N', 'RD7');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT013', 'N', 'ED');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT013', 'N', 'LD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT013', 'N', 'GD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT013', 'S', 'SOW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT013', 'S', 'SRT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT013', 'S', 'SRD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT073', 'N', 'OW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT073', 'N', 'RT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT073', 'N', 'RD1');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT073', 'N', 'RD7');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT073', 'N', 'ED');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT073', 'N', 'LD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT073', 'N', 'GD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT073', 'S', 'SOW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT073', 'S', 'SRT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT073', 'S', 'SRD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT133', 'N', 'OW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT133', 'N', 'RT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT133', 'N', 'RD1');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT133', 'N', 'RD7');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT133', 'N', 'ED');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT133', 'N', 'LD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT133', 'N', 'GD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT133', 'S', 'SOW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT133', 'S', 'SRT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT133', 'S', 'SRD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT193', 'N', 'OW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT193', 'N', 'RT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT193', 'N', 'RD1');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT193', 'N', 'RD7');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT193', 'N', 'ED');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT193', 'N', 'LD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT193', 'N', 'GD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT193', 'S', 'SOW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT193', 'S', 'SRT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT193', 'S', 'SRD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT253', 'N', 'OW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT253', 'N', 'RT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT253', 'N', 'RD1');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT253', 'N', 'RD7');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT253', 'N', 'ED');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT253', 'N', 'LD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT253', 'N', 'GD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT253', 'S', 'SOW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT253', 'S', 'SRT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT253', 'S', 'SRD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT313', 'N', 'OW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT313', 'N', 'RT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT313', 'N', 'RD1');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT313', 'N', 'RD7');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT313', 'N', 'ED');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT313', 'N', 'LD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT313', 'N', 'GD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT313', 'S', 'SOW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT313', 'S', 'SRT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT313', 'S', 'SRD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT373', 'N', 'OW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT373', 'N', 'RT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT373', 'N', 'RD1');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT373', 'N', 'RD7');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT373', 'N', 'ED');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT373', 'N', 'LD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT373', 'N', 'GD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT373', 'S', 'SOW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT373', 'S', 'SRT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT373', 'S', 'SRD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT433', 'N', 'OW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT433', 'N', 'RT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT433', 'N', 'RD1');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT433', 'N', 'RD7');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT433', 'N', 'ED');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT433', 'N', 'LD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT433', 'N', 'GD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT433', 'S', 'SOW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT433', 'S', 'SRT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT433', 'S', 'SRD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT493', 'N', 'OW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT493', 'N', 'RT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT493', 'N', 'RD1');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT493', 'N', 'RD7');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT493', 'N', 'ED');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT493', 'N', 'LD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT493', 'N', 'GD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT493', 'S', 'SOW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT493', 'S', 'SRT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT493', 'S', 'SRD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT016', 'N', 'OW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT016', 'N', 'RT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT016', 'N', 'RD1');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT016', 'N', 'RD7');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT016', 'N', 'ED');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT016', 'N', 'LD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT016', 'N', 'GD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT016', 'S', 'SOW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT016', 'S', 'SRT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT016', 'S', 'SRD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT076', 'N', 'OW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT076', 'N', 'RT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT076', 'N', 'RD1');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT076', 'N', 'RD7');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT076', 'N', 'ED');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT076', 'N', 'LD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT076', 'N', 'GD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT076', 'S', 'SOW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT076', 'S', 'SRT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT076', 'S', 'SRD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT136', 'N', 'OW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT136', 'N', 'RT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT136', 'N', 'RD1');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT136', 'N', 'RD7');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT136', 'N', 'ED');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT136', 'N', 'LD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT136', 'N', 'GD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT136', 'S', 'SOW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT136', 'S', 'SRT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT136', 'S', 'SRD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT196', 'N', 'OW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT196', 'N', 'RT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT196', 'N', 'RD1');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT196', 'N', 'RD7');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT196', 'N', 'ED');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT196', 'N', 'LD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT196', 'N', 'GD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT196', 'S', 'SOW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT196', 'S', 'SRT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT196', 'S', 'SRD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT256', 'N', 'OW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT256', 'N', 'RT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT256', 'N', 'RD1');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT256', 'N', 'RD7');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT256', 'N', 'ED');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT256', 'N', 'LD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT256', 'N', 'GD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT256', 'S', 'SOW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT256', 'S', 'SRT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT256', 'S', 'SRD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT316', 'N', 'OW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT316', 'N', 'RT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT316', 'N', 'RD1');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT316', 'N', 'RD7');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT316', 'N', 'ED');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT316', 'N', 'LD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT316', 'N', 'GD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT316', 'S', 'SOW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT316', 'S', 'SRT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT316', 'S', 'SRD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT376', 'N', 'OW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT376', 'N', 'RT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT376', 'N', 'RD1');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT376', 'N', 'RD7');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT376', 'N', 'ED');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT376', 'N', 'LD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT376', 'N', 'GD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT376', 'S', 'SOW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT376', 'S', 'SRT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT376', 'S', 'SRD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT436', 'N', 'OW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT436', 'N', 'RT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT436', 'N', 'RD1');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT436', 'N', 'RD7');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT436', 'N', 'ED');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT436', 'N', 'LD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT436', 'N', 'GD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT436', 'S', 'SOW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT436', 'S', 'SRT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT436', 'S', 'SRD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT496', 'N', 'OW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT496', 'N', 'RT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT496', 'N', 'RD1');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT496', 'N', 'RD7');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT496', 'N', 'ED');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT496', 'N', 'LD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT496', 'N', 'GD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT496', 'S', 'SOW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT496', 'S', 'SRT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT496', 'S', 'SRD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT018', 'N', 'OW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT018', 'N', 'RT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT018', 'N', 'RD1');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT018', 'N', 'RD7');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT018', 'N', 'ED');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT018', 'N', 'LD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT018', 'N', 'GD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT018', 'S', 'SOW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT018', 'S', 'SRT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT018', 'S', 'SRD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT078', 'N', 'OW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT078', 'N', 'RT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT078', 'N', 'RD1');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT078', 'N', 'RD7');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT078', 'N', 'ED');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT078', 'N', 'LD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT078', 'N', 'GD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT078', 'S', 'SOW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT078', 'S', 'SRT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT078', 'S', 'SRD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT138', 'N', 'OW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT138', 'N', 'RT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT138', 'N', 'RD1');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT138', 'N', 'RD7');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT138', 'N', 'ED');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT138', 'N', 'LD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT138', 'N', 'GD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT138', 'S', 'SOW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT138', 'S', 'SRT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT138', 'S', 'SRD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT198', 'N', 'OW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT198', 'N', 'RT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT198', 'N', 'RD1');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT198', 'N', 'RD7');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT198', 'N', 'ED');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT198', 'N', 'LD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT198', 'N', 'GD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT198', 'S', 'SOW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT198', 'S', 'SRT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT198', 'S', 'SRD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT258', 'N', 'OW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT258', 'N', 'RT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT258', 'N', 'RD1');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT258', 'N', 'RD7');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT258', 'N', 'ED');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT258', 'N', 'LD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT258', 'N', 'GD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT258', 'S', 'SOW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT258', 'S', 'SRT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT258', 'S', 'SRD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT318', 'N', 'OW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT318', 'N', 'RT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT318', 'N', 'RD1');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT318', 'N', 'RD7');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT318', 'N', 'ED');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT318', 'N', 'LD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT318', 'N', 'GD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT318', 'S', 'SOW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT318', 'S', 'SRT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT318', 'S', 'SRD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT378', 'N', 'OW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT378', 'N', 'RT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT378', 'N', 'RD1');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT378', 'N', 'RD7');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT378', 'N', 'ED');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT378', 'N', 'LD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT378', 'N', 'GD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT378', 'S', 'SOW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT378', 'S', 'SRT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT378', 'S', 'SRD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT438', 'N', 'OW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT438', 'N', 'RT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT438', 'N', 'RD1');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT438', 'N', 'RD7');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT438', 'N', 'ED');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT438', 'N', 'LD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT438', 'N', 'GD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT438', 'S', 'SOW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT438', 'S', 'SRT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT438', 'S', 'SRD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT498', 'N', 'OW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT498', 'N', 'RT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT498', 'N', 'RD1');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT498', 'N', 'RD7');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT498', 'N', 'ED');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT498', 'N', 'LD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT498', 'N', 'GD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT498', 'S', 'SOW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT498', 'S', 'SRT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT498', 'S', 'SRD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT021', 'N', 'OW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT021', 'N', 'RT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT021', 'N', 'RD1');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT021', 'N', 'RD7');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT021', 'N', 'ED');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT021', 'N', 'LD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT021', 'N', 'GD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT021', 'S', 'SOW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT021', 'S', 'SRT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT021', 'S', 'SRD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT081', 'N', 'OW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT081', 'N', 'RT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT081', 'N', 'RD1');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT081', 'N', 'RD7');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT081', 'N', 'ED');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT081', 'N', 'LD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT081', 'N', 'GD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT081', 'S', 'SOW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT081', 'S', 'SRT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT081', 'S', 'SRD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT141', 'N', 'OW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT141', 'N', 'RT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT141', 'N', 'RD1');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT141', 'N', 'RD7');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT141', 'N', 'ED');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT141', 'N', 'LD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT141', 'N', 'GD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT141', 'S', 'SOW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT141', 'S', 'SRT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT141', 'S', 'SRD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT201', 'N', 'OW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT201', 'N', 'RT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT201', 'N', 'RD1');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT201', 'N', 'RD7');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT201', 'N', 'ED');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT201', 'N', 'LD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT201', 'N', 'GD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT201', 'S', 'SOW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT201', 'S', 'SRT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT201', 'S', 'SRD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT261', 'N', 'OW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT261', 'N', 'RT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT261', 'N', 'RD1');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT261', 'N', 'RD7');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT261', 'N', 'ED');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT261', 'N', 'LD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT261', 'N', 'GD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT261', 'S', 'SOW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT261', 'S', 'SRT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT261', 'S', 'SRD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT321', 'N', 'OW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT321', 'N', 'RT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT321', 'N', 'RD1');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT321', 'N', 'RD7');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT321', 'N', 'ED');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT321', 'N', 'LD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT321', 'N', 'GD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT321', 'S', 'SOW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT321', 'S', 'SRT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT321', 'S', 'SRD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT381', 'N', 'OW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT381', 'N', 'RT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT381', 'N', 'RD1');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT381', 'N', 'RD7');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT381', 'N', 'ED');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT381', 'N', 'LD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT381', 'N', 'GD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT381', 'S', 'SOW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT381', 'S', 'SRT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT381', 'S', 'SRD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT441', 'N', 'OW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT441', 'N', 'RT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT441', 'N', 'RD1');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT441', 'N', 'RD7');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT441', 'N', 'ED');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT441', 'N', 'LD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT441', 'N', 'GD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT441', 'S', 'SOW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT441', 'S', 'SRT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT441', 'S', 'SRD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT501', 'N', 'OW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT501', 'N', 'RT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT501', 'N', 'RD1');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT501', 'N', 'RD7');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT501', 'N', 'ED');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT501', 'N', 'LD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'デンデン', 'ジロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000003');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT501', 'N', 'GD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ジロウ', '35', 'M', '0000000003');

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 80000, 'デンデン', 'ハナコ', 35, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000001');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT501', 'S', 'SOW');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ハナコ', '35', 'F', '0000000001');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'タロウ', '35', 'M', '0000000002');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ハナエ', '45', 'F', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 100000, 'デンデン', 'シロウ', 35, 'M', '111-1111-1111', 'xxxxx@ntt.co.jp', '0000000005');
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT501', 'S', 'SRT');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'シロウ', '35', 'M', '0000000005');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'サブロウ', '35', 'M', '0000000004');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'イチロウ', '6', 'M', null);

    INSERT INTO RESERVATION (RESERVE_NO, RESERVE_DATE, TOTAL_FARE, REP_FAMILY_NAME, REP_GIVEN_NAME, REP_AGE, REP_GENDER, REP_TEL, REP_MAIL, REP_CUSTOMER_NO) VALUES (to_char(nextval('sq_reservation_1'), 'FM0999999999'), currentDate, 30000, 'サトウ', 'カズコ', 28, 'F', '111-1111-1111', 'xxxxx@ntt.co.jp', null);
    INSERT INTO RESERVE_FLIGHT(RESERVE_FLIGHT_NO, RESERVE_NO, DEPARTURE_DATE, FLIGHT_NAME, BOARDING_CLASS_CD, FARE_TYPE_CD) VALUES (nextval('sq_reserve_flight_1'), to_char(currval('sq_reservation_1'), 'FM0999999999'), currentDate, 'NTT501', 'S', 'SRD');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'カズコ', '28', 'F', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ゴロウ', '35', 'M', '0000000006');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'デンデン', 'ロクロウ', '35', 'M', '0000000007');
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'タロウ', '58', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'サトウ', 'ジロウ', '45', 'M', null);
    INSERT INTO PASSENGER (PASSENGER_NO, RESERVE_FLIGHT_NO, FAMILY_NAME, GIVEN_NAME, AGE, GENDER, CUSTOMER_NO) VALUES (nextval('sq_passenger_1'), currval('sq_reserve_flight_1'), 'ヤマダ', 'サブロウ', '4', 'M', null);

    j := j + 1;
    
    -- 1日分のループが終わったら日付を進める
    IF j >= reservationLoopNum THEN
        currentDate := currentDate + 1;
        i := i + 1;
        j := 0;
    END IF;
    
  END LOOP;
END;
$$ LANGUAGE plpgsql;

SELECT C_RESERVATION();

DROP FUNCTION C_RESERVATION();

COMMIT;

