-- Drop existing tables
DROP TABLE RESERVATIONS CASCADE CONSTRAINTS;
DROP TABLE NOTICES CASCADE CONSTRAINTS;
DROP TABLE DISCOUNTS CASCADE CONSTRAINTS;
DROP TABLE MEMBERS CASCADE CONSTRAINTS;
DROP TABLE BUSES CASCADE CONSTRAINTS;
DROP TABLE SEATS CASCADE CONSTRAINTS;
DROP TABLE TERMINALS CASCADE CONSTRAINTS;
DROP TABLE ROUTES CASCADE CONSTRAINTS;
DROP TABLE NONMEMBERS CASCADE CONSTRAINTS;
DROP SEQUENCE bus_id;

-- Create tables with new schema
CREATE TABLE DISCOUNTS (
    DISOUNT_ID NUMBER(2) PRIMARY KEY,
    DISCOUNT_TYPE VARCHAR2(20),
    DISCOUNT_RATE FLOAT
);

CREATE TABLE MEMBERS (
    MEMBER_ID NUMBER(8) PRIMARY KEY,
    ID VARCHAR2(30) UNIQUE,
    PASSWORD VARCHAR2(80),
    EMAIL VARCHAR2(30),
    BIRTH_DATE DATE,
    SEX VARCHAR(6),
    NAME VARCHAR2(20),
    PHONE_NUM VARCHAR2(15),
    ROLE VARCHAR2(15),
    MILEAGE NUMBER(6)
);

CREATE TABLE NONMEMBERS (
    NMEMBER_ID NUMBER(8) PRIMARY KEY,
    PHONE_NUM VARCHAR2(15)
);

CREATE TABLE TERMINALS (
    TERMINAL_ID VARCHAR2(100) PRIMARY KEY,
    TERMINAL_NAME VARCHAR2(100),
    CITY_ID NUMBER(2) NOT NULL,
    CITY_NAME VARCHAR2(100)
);

CREATE TABLE ROUTES (
    ROUTE_ID VARCHAR2(40) PRIMARY KEY,
    DEPARTURE_ID VARCHAR2(15) REFERENCES TERMINALS(TERMINAL_ID),
    ARRIVAL_ID VARCHAR2(15) REFERENCES TERMINALS(TERMINAL_ID),
    DEPARTURE_TIME DATE,
    ARRIVAL_TIME DATE,
    PRICE NUMBER(6)
);

CREATE TABLE BUSES (
    BUS_ID NUMBER(6) PRIMARY KEY ,
    ROUTE_ID VARCHAR2(40) REFERENCES ROUTES(ROUTE_ID),
    GRADE_NAME VARCHAR2(21),
    SEAT_CNT NUMBER(2) default 28
);

CREATE TABLE SEATS (
    SEAT_ID VARCHAR2(50) PRIMARY KEY,
    BUS_ID NUMBER(6) REFERENCES BUSES(BUS_ID),
    IS_RES VARCHAR2(6) default 'FALSE'
);

CREATE TABLE RESERVATIONS (
    RES_ID NUMBER(8) PRIMARY KEY,
    MEMBER_ID NUMBER(8) REFERENCES MEMBERS(MEMBER_ID),
    NMEMBER_ID NUMBER(8) REFERENCES NONMEMBERS(NMEMBER_ID),
    ROUTE_ID VARCHAR2(40) REFERENCES ROUTES(ROUTE_ID),
    BUS_ID NUMBER(6) REFERENCES BUSES(BUS_ID),
    SEAT_ID NUMBER(2),
    DISOUNT_ID NUMBER(2) REFERENCES DISCOUNTS(DISOUNT_ID),
    RES_DATE DATE,
    PAY_ID VARCHAR(30),
    TOTAL_PRICE NUMBER(8),
    IS_CANCLED VARCHAR2(5),
    CANCLED_DATE DATE
);

CREATE TABLE NOTICES (
    NOTICE_ID NUMBER(4) PRIMARY KEY,
    MEMBER_ID NUMBER(8) REFERENCES MEMBERS(MEMBER_ID),
    TITLE VARCHAR2(20),
    CONTENT VARCHAR2(2000),
    DIR_PATH VARCHAR2(200)
);

-- ============================== Sequence λ§λ€?΄?κΈ? 
CREATE SEQUENCE bus_id
    INCREMENT BY 1
    START WITH 1
    MINVALUE 0
    MAXVALUE 99999
    NOCYCLE
    NOCACHE
    NOORDER;

CREATE SEQUENCE member_id
    INCREMENT BY 1
    START WITH 1
    MINVALUE 0
    MAXVALUE 99999
    NOCYCLE
    NOCACHE
    NOORDER;




---==================================INSERT=============================
INSERT INTO TERMINALS (TERMINAL_ID, TERMINAL_NAME, CITY_ID, CITY_NAME)
SELECT 'NAI0281501', '?­?μ΄?', 11, '??Έ?Ήλ³μ' FROM DUAL UNION ALL
SELECT 'NAI0272601', 'λ―Έμμ΄?', 11, '??Έ?Ήλ³μ' FROM DUAL UNION ALL
SELECT 'NAI0511601', '???Έ', 11, '??Έ?Ήλ³μ' FROM DUAL UNION ALL
SELECT 'NAI0550201', '? ?€?­', 11, '??Έ?Ήλ³μ' FROM DUAL UNION ALL
SELECT 'NAI0550202', '? ?€?­(μ€μ)', 11, '??Έ?Ήλ³μ' FROM DUAL UNION ALL
SELECT 'NAI0569901', 'κ°??½??₯', 11, '??Έ?Ήλ³μ' FROM DUAL UNION ALL
SELECT 'NAI0581601', '?₯μ§??­', 11, '??Έ?Ήλ³μ' FROM DUAL UNION ALL
SELECT 'NAI0603802', '? ?¬?', 11, '??Έ?Ήλ³μ' FROM DUAL UNION ALL
SELECT 'NAI0616401', 'μ½μ?€(??¬κ³΅ν­)', 11, '??Έ?Ήλ³μ' FROM DUAL UNION ALL
SELECT 'NAI0616407', '??¬κ³΅ν­(??½?κ·Όμ)', 11, '??Έ?Ήλ³μ' FROM DUAL UNION ALL
SELECT 'NAI0619501', '?Έ?', 11, '??Έ?Ήλ³μ' FROM DUAL UNION ALL
SELECT 'NAI0636201', '???­', 11, '??Έ?Ήλ³μ' FROM DUAL UNION ALL
SELECT 'NAI0654501', '??Έκ³ μλ²μ€?°λ―Έλ(κ²½λ?)', 11, '??Έ?Ήλ³μ' FROM DUAL UNION ALL
SELECT 'NAI0654601', '?Ό?Έ?΄', 11, '??Έ?Ήλ³μ' FROM DUAL UNION ALL
SELECT 'NAI0671801', '??Έ?¨λΆ?', 11, '??Έ?Ήλ³μ' FROM DUAL UNION ALL
SELECT 'NAI0732001', '?¬??λ©λ¦¬?΄?Έ?Έ?', 11, '??Έ?Ήλ³μ' FROM DUAL UNION ALL
SELECT 'NAI0750501', 'κΉ??¬κ³΅ν­', 11, '??Έ?Ήλ³μ' FROM DUAL UNION ALL
SELECT 'NAI0750503', 'κΉ??¬κ³΅ν­(??¬κ³΅ν­)', 11, '??Έ?Ήλ³μ' FROM DUAL UNION ALL
SELECT 'NAI0101101', '?? λ¦?(?? ?­)', 11, '??Έ?Ήλ³μ' FROM DUAL UNION ALL
SELECT 'NAI0134901', '?λ΄μ°', 11, '??Έ?Ήλ³μ' FROM DUAL UNION ALL
SELECT 'NAI0161301', '?Έ?Όμ΄κ΅', 11, '??Έ?Ήλ³μ' FROM DUAL UNION ALL
SELECT 'NAI0162503', '??½?°λ―Έλ(??¬κ³΅ν­)', 11, '??Έ?Ήλ³μ' FROM DUAL UNION ALL
SELECT 'NAI0170401', '??½?°', 11, '??Έ?Ήλ³μ' FROM DUAL UNION ALL
SELECT 'NAI0499101', '??κ³΅μ ?λ¬?', 11, '??Έ?Ήλ³μ' FROM DUAL UNION ALL
SELECT 'NAI0215101', '?λ΄?', 11, '??Έ?Ήλ³μ' FROM DUAL UNION ALL
SELECT 'NAI0271902', '? λ¦?(??¬κ³΅ν­)', 11, '??Έ?Ήλ³μ' FROM DUAL UNION ALL
SELECT 'NAI0393701', 'λ§ν¬κ΅¬μ²­?­', 11, '??Έ?Ήλ³μ' FROM DUAL UNION ALL
SELECT 'NAI0750508', 'κΉ??¬κ³΅ν­(?κ·Όμ)', 11, '??Έ?Ήλ³μ' FROM DUAL UNION ALL
SELECT 'NAI0273503', 'κΈΈμ(??¬κ³΅ν­)', 11, '??Έ?Ήλ³μ' FROM DUAL UNION ALL
SELECT 'NAI0511604', 'κ°λ??­', 11, '??Έ?Ήλ³μ' FROM DUAL UNION ALL
SELECT 'NAI2073502', 'κΈΈμ?­(μ’μ?)', 11, '??Έ?Ήλ³μ' FROM DUAL;


INSERT INTO TERMINALS (TERMINAL_ID, TERMINAL_NAME, CITY_ID, CITY_NAME)
SELECT 'NAI3000301', '? ?', 12, '?Έμ’νΉλ³μ' FROM DUAL UNION ALL
SELECT 'NAI3002601', 'μ‘°μΉ?', 12, '?Έμ’νΉλ³μ' FROM DUAL UNION ALL
SELECT 'NAI3004701', 'λ΄μ', 12, '?Έμ’νΉλ³μ' FROM DUAL UNION ALL
SELECT 'NAI3006401', 'μ’μ΄', 12, '?Έμ’νΉλ³μ' FROM DUAL UNION ALL
SELECT 'NAI3010701', '?Έμ’μ²­?¬', 12, '?Έμ’νΉλ³μ' FROM DUAL UNION ALL
SELECT 'NAI3015401', '?Έμ’?', 12, '?Έμ’νΉλ³μ' FROM DUAL;


INSERT INTO TERMINALS (TERMINAL_ID, TERMINAL_NAME, CITY_ID, CITY_NAME)
SELECT 'NAI4603301', 'μ’μ²', 21, 'λΆ??°κ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI4606101', 'κΈ°μ₯', 21, 'λΆ??°κ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI4620401', 'λΆ??°?λΆ?', 21, 'λΆ??°κ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI4671801', 'κΉ??΄κ³΅ν­', 21, 'λΆ??°κ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI4674502', 'κ²½λ§?₯', 21, 'λΆ??°κ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI4696901', 'λΆ??°?λΆ?(?¬?)', 21, 'λΆ??°κ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI4773401', 'λΆ??°??', 21, 'λΆ??°κ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI4781201', '??κ³ κ΅', 21, 'λΆ??°κ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI4809501', 'λΆ??°?΄?΄??', 21, 'λΆ??°κ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI4671803', 'κΉ??΄κ³΅ν­(?Έ?Έ)', 21, 'λΆ??°κ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI4671804', 'κΉ??΄κ³΅ν­(?Έ?Έ)', 21, 'λΆ??°κ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI4671805', 'κΉ??΄κ³΅ν­(??)', 21, 'λΆ??°κ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI4671806', 'κΉ??΄κ³΅ν­(??)', 21, 'λΆ??°κ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI4696902', 'λΆ??°?¬?/?¬?Ό', 21, 'λΆ??°κ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI4773409', 'λΆ??°??/?¬?Ό', 21, 'λΆ??°κ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI4781209', '??κ³ κ΅/?¬?Ό', 21, 'λΆ??°κ΄μ­?' FROM DUAL;


INSERT INTO TERMINALS (TERMINAL_ID, TERMINAL_NAME, CITY_ID, CITY_NAME)
SELECT 'NAI4298801', '??(??)', 22, '??κ΅¬κ΄?­?' FROM DUAL UNION ALL
SELECT 'NAI4124699', '???κ΅?', 22, '??κ΅¬κ΄?­?' FROM DUAL UNION ALL
SELECT 'NAI4297601', '?Όλ¦?', 22, '??κ΅¬κ΄?­?' FROM DUAL UNION ALL
SELECT 'NAI4124601', '???κ΅?', 22, '??κ΅¬κ΄?­?' FROM DUAL UNION ALL
SELECT 'NAI4171101', '??κ΅¬λΆλΆ?', 22, '??κ΅¬κ΄?­?' FROM DUAL UNION ALL
SELECT 'NAI4228801', '?μ§?', 22, '??κ΅¬κ΄?­?' FROM DUAL UNION ALL
SELECT 'NAI4248201', '??κ΅¬μλΆ?', 22, '??κ΅¬κ΄?­?' FROM DUAL UNION ALL
SELECT 'NAI4271801', '???', 22, '??κ΅¬κ΄?­?' FROM DUAL UNION ALL
SELECT 'NAI4299301', '?? ', 22, '??κ΅¬κ΄?­?' FROM DUAL UNION ALL
SELECT 'NAI4299302', 'μ°¨μ²', 22, '??κ΅¬κ΄?­?' FROM DUAL UNION ALL
SELECT 'NAI4300001', '??', 22, '??κ΅¬κ΄?­?' FROM DUAL UNION ALL
SELECT 'NAI4300801', 'κ΅¬μ?', 22, '??κ΅¬κ΄?­?' FROM DUAL UNION ALL
SELECT 'NAI4301201', '???', 22, '??κ΅¬κ΄?­?' FROM DUAL UNION ALL
SELECT 'NAI4105201', '??κ΅¬κ³΅?­', 22, '??κ΅¬κ΄?­?' FROM DUAL UNION ALL
SELECT 'NAI4114901', '?©κ³?', 22, '??κ΅¬κ΄?­?' FROM DUAL UNION ALL
SELECT 'NAI5040801', '?Έκ΅?', 22, '??κ΅¬κ΄?­?' FROM DUAL UNION ALL
SELECT 'NAI4275101', '??κ΅?(?±?)', 22, '??κ΅¬κ΄?­?' FROM DUAL UNION ALL
SELECT 'NAI4291901', '?€?¬(???€)', 22, '??κ΅¬κ΄?­?' FROM DUAL UNION ALL
SELECT 'NAI4013572', 'κ³μ ', 22, '??κ΅¬κ΄?­?' FROM DUAL;


INSERT INTO TERMINALS (TERMINAL_ID, TERMINAL_NAME, CITY_ID, CITY_NAME)
SELECT 'NAI2135401', 'λΆ??κ΅¬μ²­', 23, '?Έμ²κ΄?­?' FROM DUAL UNION ALL
SELECT 'NAI2140401', 'λΆ???­', 23, '?Έμ²κ΄?­?' FROM DUAL UNION ALL
SELECT 'NAI2200901', '?‘???Ή?Ό?°', 23, '?Έμ²κ΄?­?' FROM DUAL UNION ALL
SELECT 'NAI2214401', '?λ°μ', 23, '?Έμ²κ΄?­?' FROM DUAL UNION ALL
SELECT 'NAI2224201', '?Έμ²?', 23, '?Έμ²κ΄?­?' FROM DUAL UNION ALL
SELECT 'NAI2238201', '?Έμ²κ³΅?­1?°λ―Έλ', 23, '?Έμ²κ΄?­?' FROM DUAL UNION ALL
SELECT 'NAI2238202', '?Έμ²κ³΅?­2?°λ―Έλ', 23, '?Έμ²κ΄?­?' FROM DUAL UNION ALL
SELECT 'NAI1506602', '?΄λ§νΈ', 23, '?Έμ²κ΄?­?' FROM DUAL;


INSERT INTO TERMINALS (TERMINAL_ID, TERMINAL_NAME, CITY_ID, CITY_NAME)
SELECT 'NAI6245901', 'λͺνλ¦?', 24, 'κ΄μ£Όκ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI6242902', '?‘? ?­(?¬?Ό)', 24, 'κ΄μ£Όκ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI6242903', '?‘? ?­(κΈνΈ)', 24, 'κ΄μ£Όκ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI6111601', '?΄??', 24, 'κ΄μ£Όκ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI6111701', '??΄?', 24, 'κ΄μ£Όκ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI6116401', '?λ°©μ?₯', 24, 'κ΄μ£Όκ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI6119901', 'λ¬Έν?', 24, 'κ΄μ£Όκ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI6119902', 'λ¬Έν?', 24, 'κ΄μ£Όκ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI6123701', 'κ΄μ£Ό?­?λ¬?', 24, 'κ΄μ£Όκ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI6145601', '??', 24, 'κ΄μ£Όκ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI6150401', '???­', 24, 'κ΄μ£Όκ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI6172801', 'μ§μ?', 24, 'κ΄μ£Όκ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI6173701', 'μ§μ?', 24, 'κ΄μ£Όκ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI6193701', 'κ΄μ£Ό(? Β·?€?μ΄)', 24, 'κ΄μ£Όκ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI6242901', '?‘? ?­', 24, 'κ΄μ£Όκ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI5840004', '?¨κ΄μ£Ό(??)', 24, 'κ΄μ£Όκ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI5840006', 'κ΄μ£Ό??', 24, 'κ΄μ£Όκ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI5840016', '???­2', 24, 'κ΄μ£Όκ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI6119201', '?°?°?', 24, 'κ΄μ£Όκ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI6150402', '??κΈνΈμ§ν', 24, 'κ΄μ£Όκ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI6193703', 'κ΄μ£ΌκΈνΈμ§ν', 24, 'κ΄μ£Όκ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI6193709', 'κ΄μ£Ό(??)', 24, 'κ΄μ£Όκ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI6193710', 'κ΄μ£Όμ§ν΅', 24, 'κ΄μ£Όκ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI6193711', 'κ΄μ£Ό(?¬?Ό)', 24, 'κ΄μ£Όκ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI5704302', '?Έ?¨??', 24, 'κ΄μ£Όκ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI5715384', '?¨? λ³μ', 24, 'κ΄μ£Όκ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI5715463', 'μ€λ°©', 24, 'κ΄μ£Όκ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI5715465', 'κΈλ³΅μ€νκ΅?', 24, 'κ΄μ£Όκ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI5825513', '??', 24, 'κ΄μ£Όκ΄μ­?' FROM DUAL;



INSERT INTO TERMINALS (TERMINAL_ID, TERMINAL_NAME, CITY_ID, CITY_NAME)
SELECT 'NAI3403801', 'λΆλ?? IC', 25, '??? κ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI3405501', '??? ?λ£?', 25, '??? κ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI3410701', '?΅?©λ³μ', 25, '??? κ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI3411201', '???λ¬Έν?Ό?°', 25, '??? κ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI3417501', '? ?±', 25, '??? κ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI3455101', '??? λ³΅ν©', 25, '??? κ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI3455102', '??? (??¨)', 25, '??? κ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI3463901', '??? ? ?₯', 25, '??? κ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI3482301', '?©??', 25, '??? κ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI3498701', '??? ??¨λΆ?', 25, '??? κ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI3504801', '??? λΆ??¬', 25, '??? κ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI3520501', '??? μ²??¬', 25, '??? κ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI3520502', '??? μ²??¬(κ³΅ν­? )', 25, '??? κ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI3533501', '?λ§λ', 25, '??? κ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI3536502', 'κ±΄μ??λ³μ', 25, '??? κ΄μ­?' FROM DUAL;


INSERT INTO TERMINALS (TERMINAL_ID, TERMINAL_NAME, CITY_ID, CITY_NAME)
SELECT 'NAI4422901', '?Έκ³?', 26, '?Έ?°κ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI4423801', '?Έ?°κ³΅ν­', 26, '?Έ?°κ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI4425702', '?? ', 26, '?Έ?°κ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI4426401', '??λ§μ', 26, '?Έ?°κ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI4463201', '?Έ?°? λ³?', 26, '?Έ?°κ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI4463202', '? λ³?(κΈμ)', 26, '?Έ?°κ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI4472001', '?Έ?°', 26, '?Έ?°κ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI4494601', '?Έ?', 26, '?Έ?°κ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI4463203', '? λ³΅λ‘?°λ¦?(λ¦¬λ¬΄μ§?)', 26, '?Έ?°κ΄μ­?' FROM DUAL UNION ALL
SELECT 'NAI4467901', '?Έ?°(??)', 26, '?Έ?°κ΄μ­?' FROM DUAL;



INSERT INTO TERMINALS (TERMINAL_ID, TERMINAL_NAME, CITY_ID, CITY_NAME)
SELECT 'NAI1009601', 'κΉ??¬', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1697301', '? κ°?(??)', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1697902', 'κ°λ¨??', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1705801', 'λͺμ???', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1706301', '?©?Έ', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1706402', 'κΈ°ν₯?­', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1709401', '? κ°?(?©?Έ)', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1715801', '?μ§?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1715901', 'μ£½μ°', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1716701', 'μ’μ ', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1717801', 'λ°±μ', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1730601', '?κ΅?κ΄?κ΄λ?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1733201', '?λ―Έλ¦¬', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1733601', '??΄??€', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1737301', '?΄μ²?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1738701', '?€μ²?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1738901', '??IC', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1738902', 'μ²?κ°λ?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1740001', '?¨?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1740701', '?°?΄λ¦?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1741201', '?Έκ΅??(?΄μ²?)', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1741401', '?΄?©λ¦?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1741901', '?₯?Έ?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1751601', '??λ°©μ‘??', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1752001', '??κ³΅λ?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1752901', '?Όμ£?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1754701', 'μ€μ??(??±)', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1756101', 'κ³΅λ', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1756201', '??±?λ¦?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1758501', '??±', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1775601', '?‘?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1780601', 'μ²?λΆκ³ ', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1781101', 'μ²?λΆ?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1782001', '?????Έ', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1786901', '????', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1112801', '?±?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1112901', '?λ¬?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1113001', '? ?₯(κ²½κΈ°)', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1113701', '? λΆ?(κ²½κΈ°)', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1113901', 'λ§μΈκ΅?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1114501', '?¬μ²?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1115901', '??μ§λ?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1116901', '?‘?°λ¦?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1118401', 'μΆμκ³ κ°', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1118801', '??', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1119201', '?΄μ΄?(?¬μ²?)', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1123902', '?Έλ§μ­', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1130702', '??μ²μ­', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1136601', '??μ²?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1141901', '?μ£Όμ­', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1143501', '?μ£Όκ²½μ°°μ', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1149601', '?±λͺ¨λ³?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1150101', '?μ£?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1152302', '?‘μΆIC', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1172001', '?₯?(μ£Όκ³΅)', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1174901', '?? λΆ?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1176501', '?±λͺ¨λ³?(?? λΆ?)', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1181501', 'λ―Όλ½?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1194401', 'κ΅¬λ¦¬', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1201301', '?₯?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1202001', 'κ΄λ¦?΄', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1210201', 'KCC(λ³λ΄)', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1225901', '???­', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1242001', 'κ°??', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1243701', '?λ¦¬κ³΅?©', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1244001', 'λ΄μλ¦?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1244101', '?¨κΈΈλ¦¬', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1244202', '?λ΄λ¦¬', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1244401', '?°?λ¦?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1244501', '?­?¬λ¦?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1244601', '??λ¦?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1244701', '?μ΄λ¦¬', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1244901', 'μ²??', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1245701', '???±λ¦?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI2464601', 'λΆ??(??΄)', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1302301', '??¨BRT', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1310901', 'κ°?μ²λ?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1332601', 'λͺ¨λ??­', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1336401', 'λͺ¨λ???₯', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1349701', '?±?¨', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1359001', '?λ¦?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1359101', '???­', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1399201', '???­', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1403901', 'λΉμ°?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1407201', 'λ²κ³?­', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1407301', 'λ²κ³', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1407701', '?Έκ³λ', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1423601', 'κ΄λͺ(μ² μ°?­)', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1434701', 'κ΄λͺ', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1454501', 'λΆ?μ²?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1459901', '?‘?΄?­', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1474301', '?‘?΄', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1506601', '??₯', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1529901', '??°?°λ―Έλ', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1543101', '??°?­', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1553801', '?λ‘μ', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1588001', 'κ΅°ν¬', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1606601', '??TG', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1607601', 'κ³ μ²', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1607801', '??', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1622801', '??κ΄κ΅λ°λ¬Όκ΄?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1624001', '?°λ§λ', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1640501', '???', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1651001', '?΄??', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1654501', '??΅', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1658501', '???°λ―Έλ', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1669001', 'λ§ν¬?­', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1671301', '??΅?κ΅?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1689601', 'μ£½μ ', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1694901', '? κ°μ?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1649501', 'κ΄κ΅(μ€κΈ°?Ό?°)', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1650001', '?μ£Όλ?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1253001', '?©?(??)', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1253002', 'λΉλ£‘λ¦?(??΄)', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1255901', '??', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1258001', 'κ΅??λ¦?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1260003', '?©?΄λ¦?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1260801', 'μ²μλ¦?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1263101', '?¬μ£?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1264701', '?₯?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1265201', '?¬μ£Όλ?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1266201', '?¬μ£Όν?λ¦?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1266301', '??λ¦?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1275701', 'κ΄μ£Ό(κ²½κΈ°)', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1003901', '?©?°??κ΅?(κΉ??¬?)', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI5893502', '?? ??', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1756202', '?λ¦Όμ??Έ(??±)', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1759102', '??±μ’ν©?΄??₯', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI2460602', '?©?λ¦?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1580401', 'κ΄μ @(κ΅°ν¬)', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1585601', '?Ή?(κ΅°ν¬)', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1782401', 'μ§?? ?­', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1252910', '?¨?(??΄)', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1400601', '??', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1110206', '??Έ', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1110903', '?Όλ―?2λ¦?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1136301', 'μ§???', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1161102', '??€??΄?Έ(?Ή??­)', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1181301', '?°?€λ§μ2?¨μ§?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1110104', 'μ΄κ³Ό,κ΄??Έ', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1649502', 'κ΄κ΅μ€μ?­', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1658503', '??TR(? )', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1490203', '??₯ABC?λ³΅ν??΄', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1498301', '??₯???΄κ²μ', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1501002', 'λ°°κ³§μ€μ¬?κ°?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI2513563', 'λ΄μλ¦?(??΄)', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI2513601', '?μ§?λ§μ(??΄)', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI2513614', '?©?λ¦?(??΄)', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI2513617', '?©λ¬?(??΄)', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI3142702', 'κΆκ?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI2513572', '?Ό?±λ¦?(??΄)', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI2516022', '?©?(??΄)', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1793501', '?μ€μ€κ±°λ¦¬', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1794301', '?μ€?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1794801', '???Έ', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1795002', '?΄κ΅°κΈ°μ§?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1798301', '?? λ¦?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1810601', '?Έλ§μ­(?€?°)', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1813701', '?€?°', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1813901', '? ????Έ?¬κ±°λ¦¬', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1829201', '??λ¦?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1833403', '??Ό??΄λΉ?(λ΄λ΄?)', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1839701', 'μ£Όκ³΅11?¨μ§?,?°?¨(λ³μ )', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1844201', '?λ£¨λ§?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1844401', '??', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1854301', 'λ§λ(??±?)', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1858801', '?₯?¨(λ°μ)', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI1860801', '? ?½?¨μ§?', 31, 'κ²½κΈ°?' FROM DUAL
UNION ALL SELECT 'NAI5972503', '?¬?(??κ΅?)', 31, 'κ²½κΈ°?' FROM DUAL;




INSERT INTO TERMINALS (TERMINAL_ID, TERMINAL_NAME, CITY_ID, CITY_NAME)
SELECT 'NAI2401401', '??‘', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2402101', '?΄?λ¦?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2402901', 'μ§?κ²½λ¦¬', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2403101', 'λ¬Έν2λ¦?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2403201', 'λ¬Ένλ¦?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2404201', '? μ² μ', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2404601', 'κ°ν¬λ¦?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2405402', '??¬λ¦?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2405901', '???λ¦?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2406101', '??±λ¦?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2406201', '? ?λ¦?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2406303', '38?°??', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2406401', '?‘?¨λ¦?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2406501', '? κ³‘λ¦¬', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2410001', 'κ²?λ¬Έμ', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2410002', '15μ΄μ', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2410101', '?°?λ¦?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2410401', '?€λͺ©λ¦¬', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2410701', '?¬?¨?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2413401', 'κ°μ²?¬κ±°λ¦¬', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2414801', 'λͺμλ¦?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2415401', '?¬μ°½λ¦¬', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2420001', '? ?¬λ¦?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2420002', '?΄λ¦¬κ³ κ°?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2420003', 'μ§?μ΄?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2420004', '??λ¦?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2420006', '?μ§??¬', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2420007', '?€?λ¦?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2420008', '?€?2λ¦?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2420009', 'μ§??λ¦?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2420010', '??λ―?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2420011', '???Έ2', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2420701', '? ?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2422601', '?λ―Έλ₯΄???Έ', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2570801', '??μ§?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2573501', '??΄', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2590303', '?Όκ±°λ¦¬', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2590403', '?κ±°λΈ', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2590502', '?κ±°λΈ', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2590601', '?κ²?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2590801', 'κ°μ²', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2591801', '??Ή', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2592901', '?Όμ²?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2593601', 'κ·Όλ', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2593801', '?₯?Έ', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2595302', 'κΈ°κ³‘', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2595601', '??', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2596101', '?Έ?°', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2600701', '?λ°?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2455901', '?λ¦?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2456301', '?΄?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2460001', '??(κ°μ)', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2460301', 'μ²λλ¦?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2460501', 'λ°±λ΄?¬', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2460601', '?¨κ΅?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2460603', '?©???Όκ±°λ¦¬', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2460701', '?₯???', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2461201', '??΅', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2462201', '?€??°?κ΅?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2423501', '??????Έ(μΆμ²)', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2426001', '?΄κ΅?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2441001', '?Ήλ©΄κ³΅?₯', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2443101', '???Έ', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2443501', 'μΆμ²', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2446001', 'μΆμ²?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2446201', '???', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2446301', 'κ°μ΄', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2446302', '?λ³΄λ¦¬', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2446401', '?μ²?2λ¦?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2446402', '?μ²?1λ¦?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2446501', '?¨?°λ©΄μ¬λ¬΄μ', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2446502', '? ? ₯IT?¨μ§?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2446503', '?Ή?λ¦?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2446506', 'κ°μ΄? ?μ§?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2446507', 'κ°μ΄?­', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2446801', 'λ°μ°λ¦?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2452401', '?κ΅?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2454501', '?±?¬λ³μ', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2454901', '?‘μ²?λ¦?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2455401', '?κ΅¬μ μ€μ', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2455402', 'μ²?λ¦?(κ°μ)', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2463501', '?Έ? ', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2463801', '?Έ? μ²΄μ‘κ΄?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2464501', 'κ΄???λ¦?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2464701', '? ?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2464801', '? ?¨', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2465001', '? ?¨(??΄)', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2465201', '?΄λ‘?(??΄)', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2465801', 'κ΅°λ¨?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2465901', '?λ¦?(κ°μ)', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2465902', '??€λ¦?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2466801', 'κ°?λ‘λ¦¬(??΄)', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2471001', '?μ§ν¬', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2472501', 'κ±°μ§', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2473401', 'κ°μ±', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2474101', '?₯? ', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2474201', 'μ§λ?? Ή', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2476801', 'μ°½λ°?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2482701', '?μ΄?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2500001', 'λ¬ΌμΉ', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2500701', '??°', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2503101', '??', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2503301', '?€??λ¦Όκ³¨', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2503302', '?€??±?°λ‘?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2503303', '?κ³λ Ή', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2503304', '?€?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2503501', '??', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2503701', '?Ό?λ¦?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2503702', '?‘μ²?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2503703', 'κ³΅μ? ', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2503901', '?λ¦?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2503902', '?©?΄', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2504201', '??κ΅?? κ³΅ν­', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2504401', '??', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2504701', '?μ‘°λ?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2505301', '?Έκ΅?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2505801', '?¨? λ¦?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2510101', '?λ΄μ°', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2620902', 'λ§μ°¨', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2621401', '??©', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2621701', '?°?Ή', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2623601', '??', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2624201', '??­', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2624301', '?Ή? ', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2624601', '?λ―?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2624801', '?΄?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2624802', '??', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2630201', '?κ³?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2634101', '?°?°?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2636801', 'λ¬Έλ§', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2638201', '?μ£?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2640101', '?₯?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2645301', '?¨κ΅¬λ', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2650601', '? λ¦?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2650801', '?©?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI5930604', '?₯?κΈνΈμ§ν', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2440902', '??°', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2460607', '?¨κ΅λ¦¬', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2461202', '??΅(??΄)', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2461224', '??΅(??΄)', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2463401', 'κ°?λ¦?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2463502', '?₯?¨(??΄)', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2503103', '???₯', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2503621', '??λͺμ€?€?₯(??΄)', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2503622', '??κ³?2λ¦?(??λͺ?)', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2503623', '??(??λͺμ€?€?₯)', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2503903', '??', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2511601', 'λΆλ°©', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2513451', '??(??΄)', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2513507', '(κ΅?)μΆμ₯?(??΄)', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2451402', 'κ³ λ?λ¦?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2451403', 'κ³΅μλ¦?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2452402', '?κ΅¬κ??΄', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2456302', '?΄?(??΄)', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2460302', '?Όκ±?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2463545', '?Έ? (??΄)', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2463550', '?©??λ¦?(??΄)', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2463567', '?©λΆ??°(?κΈ?)', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2513533', '?€??λ¦?(??΄)', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2513551', 'λͺ¨κ³‘(??΄)', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2513597', '?λ‘±κ?μ§?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2513620', '???κ΅?(??΄)', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2513644', 'μ² μ (??΄)', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2513651', '??¨(??΄)', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2526871', '? ??2λ¦?(??΄)', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2531201', '?Έ?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2531202', '??¬', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2536503', '?λ°©λ¦Ό', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2536504', 'λ°©λ¦Ό?Όκ±°λ¦¬', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2537102', 'μ‘°λ', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2537801', 'λ§μ?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2615508', 'κ³ ν', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2621202', '?λ©?(??)', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2540401', 'μ£Όλ¬Έμ§ν΄λ³?(μ²???)', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2562001', '?λͺ?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2591701', 'μ£½μλ£?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2515603', '? ?΄', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2515703', '?±?°(??΄)', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2513590', '?μ²?(??΄)', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2516010', '?μ΄?(??΄)', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2516601', '??', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2517101', '?΄λ©?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2517103', '?΄?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2517104', '?΄?? Ή', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2517105', 'κΈ°λκ΄?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2512601', 'κ²°μ΄λ¦?(??΄)', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2513501', '?μ²?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2515602', '? ?΄(??΄)', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2515701', '?±?°', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2515702', 'λ§κ³ κ°?(??΄)', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2515801', '?Ό?¬', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2515903', 'κ΅°μ', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2515905', '?°? ', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2516001', '?μ΄?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2516401', 'μ² μ ', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2516402', '?­?΄λ¦?(??΄)', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2516403', 'μ§??€μΉ?(??΄)', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2516701', '?κ³?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2517002', 'μ²??', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2517003', 'κ΄μ', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2517004', '? ? ', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2520601', 'κ³΅κ·Ό', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2523401', '?‘?±', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2523901', '?μ£Όκ³΅?­', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2524801', '?λ§?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2526501', '??΄', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2527101', '??₯', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2531501', '?₯?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2533201', 'μ§λ?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2534501', '?‘κ³?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2535601', '???3λ¦?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2535801', '???', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2536401', 'λ°©λ¦Ό', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2536901', 'λ±μ¬', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2537601', '?μ°?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2537602', '?? ?€', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2537603', '?μΉ¨μ ', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2538001', '?λ¦¬μ¬', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2538401', 'λ―Έν', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2541901', 'μ£Όλ¬Έμ§?', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2544001', '??°λ³μ(κ°λ¦)', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2551901', 'κ°λ¦??Έ?°λ―Έλ', 32, 'κ°μ?' FROM DUAL
UNION ALL SELECT 'NAI2563301', '?Έ?κ³?', 32, 'κ°μ?' FROM DUAL;


INSERT INTO TERMINALS (TERMINAL_ID, TERMINAL_NAME, CITY_ID, CITY_NAME)
SELECT 'NAI2746901', 'κ΅ν΅??', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2747801', 'κ±΄κ΅­??(μΆ©μ£Ό)', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2749401', '?΄λ―?', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2749601', '??λ³?', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2761001', 'κ°κ³‘', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2761901', '?κ·?', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2763601', 'λ¬΄κ·Ή', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2764801', '?Ό?±', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2766801', '???', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2769501', '??±', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2773201', 'κ½λ?€', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2773301', 'λ§Ήλ', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2773901', 'μΆ©λΆ?? ??', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2780501', 'κ΄ν?', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2782001', '?΄?', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2782601', '?¬?', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2783101', 'μ§μ²', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2785101', '??°(μΆ©λΆ)', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2787001', 'λ¬Έλ°±', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2790201', '??', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2793101', 'μ¦ν', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2800201', 'λͺ©λ', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2800601', 'κ°λ¬Ό', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2801201', '?°??Όκ±°λ¦¬', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2801301', '?°?', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2801801', 'μΉ μ±', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2801802', '??±', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2802001', '?? ', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2803301', 'κ΄΄μ°', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2803601', '???¬λ¦?', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2804101', '??', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2804501', '?¬λ¦?', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2804601', '? λͺ?', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2812001', 'μ²?μ£ΌλΆλΆ??°λ―Έλ', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2814201', 'μ²?μ£Όκ³΅?­', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2815001', 'μΆ©λΆλ³΄κ±΄??', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2819901', 'λ―Έμ', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2833901', '?¨?', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2837001', '??(AFC)', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2839701', 'μ²?μ£?', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2848501', 'λΆμ²­μ£?', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2850301', 'μ²?μ£Όλ?', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2863501', '?¨μ²?μ£?', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2864301', 'μ²?μ£Όμ¬μ°?', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2864401', 'μΆ©λΆ??λ³μ', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2890801', '?λ¦¬μ°', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2891101', 'λ³΄μ?', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2891202', '?₯?(μΆ©λΆ)', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2892501', '??¨', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2896301', 'κ΄?κΈ?', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2899101', '?₯?¬', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2900601', '?λ¦?', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2900602', '??΄', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2903301', '?₯μ²?', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2906101', '?΄?', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2910601', '?₯κ³?', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2912001', 'μΆν? Ή', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2912701', '?κ°?λ¦?', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2912702', 'μ€κ?λ¦?', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2914101', '??', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2916601', '??°', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2700301', 'λ§€ν¬', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2701101', '?¨?', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2702001', 'κ΅¬μΈ?¬', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2710401', 'λ°±μ΄', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2710501', 'λ°±μ΄', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2711701', 'λ΄μ', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2716501', '? μ²?', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2730301', '?©?¬', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2731301', '?? ', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2731501', '?°μ²?', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2732901', 'λͺ©ν', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2736001', 'μΆ©μ£Ό', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2745701', '?©?(μΆ©λΆ)', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2746201', 'μ£Όλ', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2746601', 'λ³Έλ¦¬? λ₯μ', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2831901', '? ?₯κ³?(μ²?μ£?)', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2832301', '?¨??±λͺ¨λ³?', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2845101', 'λ΄λͺ??¬κ±°λ¦¬', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2914102', '??(?)', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2916602', '??°(?)', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI4013539', '?©?', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2764902', '?‘?°κ³?', 33, 'μΆ©μ²­λΆλ' FROM DUAL
UNION ALL SELECT 'NAI2744801', '?μΆ©μ£Ό', 33, 'μΆ©μ²­λΆλ' FROM DUAL;


INSERT INTO TERMINALS (TERMINAL_ID, TERMINAL_NAME, CITY_ID, CITY_NAME)
SELECT 'NAI3240602', '? ?', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3100601', '?±?', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3102101', '?¨??Έ??', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3112001', 'μ²μ', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3115501', '??©?', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3118701', 'κ³μ', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3123201', '?λ¦½κΈ°?κ΄?', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3125301', 'μ½λ¦¬??', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3143601', 'λ°??λ¦?', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3147001', 'μ²μ??°(KTX)?­', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3147701', 'λ΄κ°κ΅?', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3148401', 'λ°°λ°©? λ₯μ', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3149301', '?λΆ??΄κ²μ(??°)', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3149901', '?Έ???', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3151704', '??°(?¨?)', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3153401', '? μ°?', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3153601', '? μ°½λ©΄(??΄λ¦?)', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3155701', '?‘?', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3173301', 'κΈ°μ??', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3173801', '?‘?? ??', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3174401', '?½κ΅μ²', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3174402', '?΄? ', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3174801', '? ?', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3175901', '??±', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3177101', '?Ήμ§?', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3178902', 'κ΅¬λ£‘(?Ή)', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3181201', '?©?', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3190901', '???°', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3191001', '??λ‘λ¦¬', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3192401', '?΄?‘', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3193601', '??', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3193602', '????Ή', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3194501', '?΄?°', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3196001', '?΄λ―?', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3196201', '????', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3196202', '??κ³‘λ¦¬', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3198101', '??°', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3201301', '?Έμ§?', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3201701', 'λΆ??', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3202701', 'κ³ λΆ', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3212301', 'λ§λ¦¬?¬', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3212302', '??', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3213301', 'κ·Όν₯', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3214401', '??', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3215301', '?¨λ©?(??)', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3215401', '?¬?°', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3215801', '?¨λ©?', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3216201', 'μ°½κΈ°λ¦?', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3216401', '?λ©΄λ', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3216501', '?Ή?Έλ¦?(?λ©΄λ)', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3216502', 'κ½μ?', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3216801', 'μ€μ₯', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3217201', 'κ³ λ¨', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3217202', '?λͺ?', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3220001', '??±', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3220201', 'κ°μ°', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3221401', 'κ΅¬ν­', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3221801', '??κ΅?(μΆ©λ¨)', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3222001', '??±', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3228301', 'κΈλΉ', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3229501', 'κ΄μ²(μΆ©λ¨)', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3240301', 'κ³ λ', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3240601', '??°?€?', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3240702', 'μΆ©μ?¬', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3240801', '??°(μΆ©λ¨)', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3241101', '?½κ΅?', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3241601', '?΄?¬?', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3242101', '? λ‘??', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3242801', '??°', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3243801', '??±?', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3244601', '?λ΄?', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3245001', '???₯', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3245301', '? ?', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3250601', '? κ΅?', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3251101', '?Έ?', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3251201', 'κ΄μ ', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3251401', 'λͺ¨λ?(κ³΅μ£Ό)', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3252501', '? ?', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3252502', '??λ£?', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3253001', '?°?±', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3253801', 'κ³΅μ£Ό(?°?±)', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3254901', 'λ΄ν©(κ³΅μ£Ό)', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3258501', 'κ³΅μ£Ό', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3258801', 'κ³΅μ£Ό??.?¬???κ΅?', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3259001', '?₯κΈ?', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3260601', 'κ³΅μ£Ό(KTX)', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3260701', '?΄?Έ', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3260901', '?μ²?', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3261301', 'κ³λ£‘(κ³΅μ£Ό)', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3261801', '?λ§λ£¨', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3262201', 'κ³΅μ', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3262601', '???¬', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3270101', 'λ³΅μ', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3271401', 'λ§μ (μΆ©λ¨)', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3271801', '?λ§?', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3272102', '?Έ?Ό??(?)', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3273501', 'κΈμ°', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3275401', 'λΆ?λ¦?', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3280102', '?¨? ', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3281401', '?? ', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3290201', '?Έ?±', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3290501', '??', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3291301', '?°?°? λ³΄κ³ ', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3293601', 'κ°κ²½', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3295401', '?Ό?°', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3300801', '?°λ¬΄λ?', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3301101', '?Ό?°TG', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3301103', '??°(?°λ¬?)', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3301401', '?©?', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3302001', '??μ§?', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3310501', '?Έ?°', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3310801', '?κ³?', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3311101', '???°(λΆ??¬)', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3312301', 'κ·μ', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3315201', 'λΆ??¬', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3317601', '?­?κ°?', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3319201', '?Ό?°', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3319501', '?΄?°', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3320501', '?₯?°(μΆ©λ¨)', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3320502', '? ?(μΆ©λ¨)', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3331501', '?΄κ³?', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3331601', 'λΉλ΄', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3332601', 'μ²??', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3334501', 'μ£Όμ ', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3334601', '? ?°', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3334602', 'λ§ν°', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3335901', 'λͺ©λ©΄', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3336201', 'λ―ΈλΉ', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3341401', 'μ£Όν¬', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3341501', 'μ£Όκ΅', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3341801', 'μ²??', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3342401', 'μ²??Ό', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3345801', 'λ³΄λ Ή(??μ²?)', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3348501', '?±μ£?(μΆ©λ¨)', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3348901', '??μ²μ?₯', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3349701', '?¨?¬(λ³΄λ Ή)', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3351230', '???΄', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3352201', '?μ²?(λ³΄λ Ή)', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3360801', 'λΉμΈ', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3361101', 'μ’μ²', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3361501', '?κ΅?(μΆ©λ¨)', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3364501', '?μ²?', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3367401', '?₯?­', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI5492601', 'κ³λ£‘κΈμ', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3141101', '??¬', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3215303', '???¨λ©?(μ’μ)', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3216202', 'μ°½κΈ°λ¦?(μ’μ)', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3216402', '?λ©΄λ(μ’μ)', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3251002', '? ??΄κ²μ', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI4014901', '?₯?°', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3271402', '??΄κΆ?', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3311501', '?κ΅?? ?΅λ¬Έν??', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3170901', 'μ°½λ¦¬', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3174405', 'λ°??λ¦?(??΄)', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3174415', '??°(??΄)', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3174421', '?Ήμ§?(??΄)', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3196002', 'μ²μ₯?Έ', 34, 'μΆ©μ²­?¨?' FROM DUAL
UNION ALL SELECT 'NAI3345850', 'λ³΄λ Ή??₯', 34, 'μΆ©μ²­?¨?' FROM DUAL;





INSERT INTO TERMINALS (TERMINAL_ID, TERMINAL_NAME, CITY_ID, CITY_NAME)
SELECT 'NAI5550603', 'κ΅΄μ²λ¦?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5551201', 'κ°??₯(λ¬΄μ£Ό)', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5551202', 'κ°?λ¦?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5551501', 'λ¬΄μ£Ό', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5552301', '?€?°λ¦?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5552502', '??₯λ°?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5552602', 'λ°©μ΄λ¦?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5552603', 'λ°°λ°©λ¦?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5552604', '?΄??€λ¦?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5552701', '? ?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5552702', 'κΈΈμ', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5552703', '?μ°?(λ¬΄μ£Ό)', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5552802', '?΄μ°?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5553001', '?μ‘?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5553004', 'κ΄΄λͺ©(λ¬΄μ£Ό)', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5553101', '??΄', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5553201', '?¬?λ¦?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5553203', '? ?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5553301', '?Ό? λ¦?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5553304', '?±? λ¦?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5553305', '?? λ¦?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5553501', '??±(? λΆ?)', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5553502', '?΄λͺ?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5554301', 'κ³΅μ§', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5554502', '?κΈΈμ°', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5555101', 'λ―Έμ²λ¦?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5555201', '?₯?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5555301', '?€μ²?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5555302', '?Ό? ?΅λ¬?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5555303', '?΄?¨', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5555304', '?λ¦?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5555503', '???', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5555701', 'κ΅¬μ²?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5555801', 'λ¬μ', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5555802', '?¬??κ΅?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5555901', 'λ¬΄ν', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5556002', 'λ§λ', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5556003', 'κ³λ?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5556004', 'λΆ??(λ¬΄μ£Ό)', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5556203', '??€? ', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5556204', '?? λ¦?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5556201', '??', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5556202', '?μ§?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5556205', '?€λ―?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5556207', '??€', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5560002', '?Έλ¦?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5560101', 'κ³λΆ', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5560301', 'λ§€κ³', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5561401', '?₯κ³?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5562301', 'κ³λ¨', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5563201', '?₯?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5565901', 'λ²μ', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5576001', '?¨?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5577901', '???°', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5580404', 'λ°μ ', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5592801', '??€', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5593401', 'μ²??', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5593901', 'κ°μ§(? λΆ?)', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5594601', '?Όκ³?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5595101', '?€?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5600001', 'λ°μ', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5601401', 'κ΅¬μ°λ¦?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5602002', 'κ°μ²?¬', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5602201', '? ?±', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5602901', '?κ³?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5603101', '? κΈ?(?μ°?)', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5603501', '?μ°?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5605201', 'κΈκ³Ό', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5610601', '? ??Έ', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5610901', 'κ°κ³‘(? ??)', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5611501', '??Έ', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5612501', '?¬κ΅?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5615801', '? ?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5615802', 'λ΄λ€', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5619901', '?΄?₯?°', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5621501', '??? ', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5630602', '?λΆ?λ²μ€? λ₯μ₯(λΆ??)', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5630801', 'λΆ??', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5630901', '?λΆ?λ²μ€? λ₯μ₯(λΆ??)', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5632601', 'μ€ν¬', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5633701', 'κ²©ν¬', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5634401', '?΄??¬', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5634601', 'κ³°μ', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5640001', '?¬?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5640301', '?΄λ¦?(κ³ μ°½)', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5640801', 'κ΅¬μ?¬', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5641001', '??', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5641501', '?₯?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5643301', 'κ³ μ°½', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5643401', 'κ³ μ°½?¬κ³?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5645201', '? ?΄?¬', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5645401', '??°', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5645501', 'λ¬΄μ₯', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5646801', '???°', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5403701', 'κ΅°μ°', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5406001', '???Ό', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5415001', 'κ΅°μ°??', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5430701', 'λ§κ²½', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5437901', 'κΉ?? ', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5452001', '?¬?°', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5457602', '?΅?°?κΆ?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5467401', '?΅?°', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5480801', '?Έ?¨? ?Όλ¬?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5490001', '?μ§λ', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5493301', '? μ£Όμ?Έ?°λ―Έλ', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5493302', '? μ£? ?κ³?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5493401', '? μ£?(λ¦¬λ¬΄μ§ν°λ―Έλ)', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5504201', '? ?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5504701', '??°?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5504901', '?λΆ???₯', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5508001', '?¨????@(? μ£?)', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5511901', '???', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5530701', '??°', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5531301', '?΅?°IC', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5532101', '??°κ³΅μ', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5536501', '? λΆ?(?μ£?)?? ??', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5540001', '??λΆ?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5540101', '?©?(? λΆ?)', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5540501', '?‘?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5540702', 'λ°±νλ¦?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5540703', 'λ°±ν?¬', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5541101', 'κΈμ?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5541801', '?‘??', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5541802', '?Έκ±?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5544601', '??₯', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5545601', '?μ΄?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5550001', 'κ°??Ήλ¦?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5550003', '???Ή', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5550201', '?κ΅΄μ', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5550202', 'κ΅΄μ?κ΅?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5550203', 'λ°€μ', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5550301', '? ?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5550401', '?₯?λ¦?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5550402', 'κ³ μ°½λ¦?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5550403', '??λ¦?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5093701', '?κ³?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5934001', '?¨?°', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5493308', '? μ£?(μ§ν΅)', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5496801', '?¨??', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5506501', 'κ΅μ‘μ²?(? λΆ?)', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5506502', '? λΆλκ΅μ‘μ²?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5508002', '?¨?Β·?λΆ?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5508003', '? μ£?(?κ΅μ‘μ²?)', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5532501', 'μ€λ¦¬', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5536302', '???(?)', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5536504', '?μ£Όν? ??', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5540203', 'κ΄΄μ ', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5540704', '?μ²?(?)', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5550004', 'κ°??Ή(?)', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5550101', '???°', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5550302', 'λΆ??¨', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5550404', '???κ³?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5550605', '? ?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5551101', '? ?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5551204', '?Έ?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5552302', '?€?°', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5552605', 'κ³ λ°©λ¦?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5553102', 'λ§μ°', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5553103', 'λ§μ°?¬', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5553504', '??±(?)', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5553601', '?¬? ', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5553701', '?μ΄?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5553801', '?κ³?', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5554202', 'λͺμ²', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5554401', 'κΈ°κ³‘', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5555305', '?€μ²?(?)', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5555401', '??', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5555702', 'κ΅¬μ²(?)', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5556005', 'κΈμ²(?)', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5231801', 'λΆμ²', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5560102', 'κ³λΆ(?)', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5561402', '?₯κ³?(?)', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5562302', 'κ³λ¨(?)', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5563202', '?₯?(?)', 35, '? ?ΌλΆλ' FROM DUAL
UNION ALL SELECT 'NAI5263701', '? ?', 35, '? ?ΌλΆλ' FROM DUAL;




INSERT INTO TERMINALS (TERMINAL_ID, TERMINAL_NAME, CITY_ID, CITY_NAME)
SELECT 'NAI0000154', '??λ¦?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5926602', 'κ΅¬κ³‘', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5926901', 'λ§λ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5930101', '? μΉ?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5930102', '?Έ?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5930301', 'λ΄λ¦Ό', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5930601', '?₯?(? ?¨)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5930602', '?©?°', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5930701', 'λ°°μ°', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5932401', '?₯?₯', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5933501', '?? ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5934101', '??', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5934201', '?©?°(?₯?₯)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5934202', 'κ³μ°', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5934203', 'λͺ¨μ°', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5934303', '?λ°?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5934304', '?κΈ?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5934401', 'μ²?? ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5934402', 'κ΄?μ§?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5935101', 'κ΄??°', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5935303', '??(?₯?₯)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5935501', '?λ°?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5935701', '?Ό?°(?₯?₯)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5935801', '? ?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5935802', '??λ¦?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5935902', '?Έ? ₯?­', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5936001', '?μ§?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5936102', '?­κΈ?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5936401', '?μ΄?(?₯?₯)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5936402', 'κ°??', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5936501', '???', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5936502', '?μ²?(? ?¨)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5936601', '? λ¦?(? ?¨)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5936605', '?Ή?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5936608', '??', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5936609', '? ?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5940001', 'λ¬Έλ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5940501', 'λ³΅λ΄', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5942301', 'λ²κ΅', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5943601', '??Ή', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5944001', 'μ‘°μ±', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5944501', 'κΈνΈ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5945501', 'λ³΄μ±λΆλ¬Έ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5945801', 'λ³΄μ±', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5947101', '?¨?¬(? ?¨)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5950102', '?κ°?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5950201', 'λ§€κ³‘(κ³ ν₯)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5950903', '?₯μ²?(? ?¨)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5951101', 'κ³Όμ­', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5951301', '?±?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5951901', '? ?(κ³ ν₯)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5952201', '?μ΄?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5700401', '??', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5701501', 'λ²μ±?¬', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5703601', '?κ΄κ΅°μ²?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5704901', '?κ΄κ³ ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5704301', '?κ΄?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5710601', '??°', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5710801', '? κ΄?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5711701', 'λ¬Έμ₯', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5712901', '??°', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5715301', '?¨?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5716201', '?¨?¬κ±°λ¦¬', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5720101', '?₯?±?¬κ±°λ¦¬', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5720502', '?΄?₯?¬', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5721901', '?₯?±', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5730101', 'κΈμ±', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5730201', 'μΆμ?°', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5731601', 'μ£Όν', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5734401', '?΄?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5750401', '?₯κ³?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5750501', 'κ΅°λ΄κΈ°λ³Έ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5952501', 'κ³ λΉ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5952701', '?΅κΈ?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5952702', '?¨?±', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5952901', '??', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5953101', 'κ΅¬μ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5954001', 'κ³ ν₯', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5954601', 'λ΄μ±', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5954806', '??κ°?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5954904', '?¨μΉ?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5778101', '?±?©', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5754201', 'κ³‘μ±', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5754902', '?°?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5755901', '?κ³?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5762401', '?¬μ§κ°(??)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5763901', 'λ΄λ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5765401', 'κ΅¬λ?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5770801', '?¬μ§κ°', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5771201', '?¬μ§κ°(??)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5772001', 'κ΄μ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5772401', '?μ΄?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5775801', 'κ΄μ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5880301', '??(??κ΄?)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5926308', 'κ°??°?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5924807', '? ?¨?Έ?¬κ°λ°?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5825516', '160λ²κ΄μ£Όμ?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5778701', '?κ΄μ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5955102', '?₯?(? ?¨)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5778702', 'μ€λ§?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5955501', '?Ή?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5781401', '??Έ?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5790201', 'κ΄΄λͺ©', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5956001', '?Ή?? ?­', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5956101', '?λ‘λ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5956401', '?©?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5791401', 'κ³‘μ²', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5792201', '?μ²λ??κ΅?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5956402', 'κΈμ°(? ?¨)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5794001', '?μ²λΆλΆ?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5956403', '?μ§?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5794002', '?μ²λΆλΆ?(??)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5956407', 'κΈμ₯', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5796001', '?μ²?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5956501', '?? ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5796201', '?μ²μ­', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5815801', '??(??)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5815802', '? μ²λ¦¬', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5815803', '??μ΄λ¦¬', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5815804', '?±κ΄λ¦¬', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5815805', 'μ§??3', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5815806', 'μ€μ₯?°', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5815807', '?΄μ£?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5815901', 'μΆμ(? ?¨)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5816001', '?Έ?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5816002', '?°μΉλ¦¬', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5956503', '?Ό? ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5956504', '?±μΉ?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5816003', '??°', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5956505', '? ? ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5956601', '??¬', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5796401', '?μ²μ­(??)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5800001', '?μ²λ§λ°λ?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5801101', '?μ²μ ??μ§?κ΅?(CGV)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5810105', '?©λ°?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5810301', 'λΆκ΅', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5811501', '?©κ³?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5812001', '??', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5815301', '?₯μ£?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5815402', 'λ²½μ?λ¦?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5816101', '?Έμ²?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5816102', '?μ§?λ¦?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5956603', 'λͺμ²', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5816201', 'μ²??', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5956604', 'μ²??', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5956605', '?€μ²?(? ?¨)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5956701', 'λ°±μ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5956901', '?λ‘λ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5956902', '? κΈλ¦¬', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5963501', '?¬μ²?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5964901', '??', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5967701', '? ?Όλ³μ(?μ°?)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5971501', '?¬?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI6242801', '?κ΄ν΅', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5816202', '??λΉλ¦¬', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5816203', 'λ°±μ΄(??)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5816204', '? ?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5816205', 'κ³°μΉ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5816301', '?λ¦?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5816302', 'μ΄λ°©', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5816401', '?΄?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5816402', 'κΈλ₯', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5816403', 'μ§λ±', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5816404', 'κ°μ±λ¦?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5816405', 'λ¬΅κ³‘', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5816501', 'μ²??', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5816502', '??λ¦?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5816503', '?€λ₯λ¦¬', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5901902', '?©μ£?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5902001', 'λ§Ήμ§λ¦?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5902004', 'λ§μ°(?΄?¨)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5902102', '??', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5902105', '?? (?΄?¨)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5902107', '?₯μ²?(?΄?¨)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5903801', '?΄?¨', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5904901', 'μ’μΌ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5904903', '??Έ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5904904', '??°(?΄?¨)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5904905', '??', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5905102', '?₯μ΄?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5905501', '?¨μ°?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5905601', '??λ¦?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5905602', '?΄μ§?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5905702', '??', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5905802', '??°', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5905902', '?λͺ¨λ¦¬', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5905903', 'λ°±ν¬', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5906101', '??‘', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5906102', '?? ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5906201', '?΄?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5906301', '?°? ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5906302', '?΄??', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5906308', '??', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5906309', 'λ―ΈμΌ(λ―Έν©)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5906310', '??', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5906312', 'κ°?μ°¨λ¦¬', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5906401', '?‘μ’?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5906502', '??', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5906601', '?¬κ΅¬λ¦¬', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5906602', '?΅?Έλ¦?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5906705', '?₯μΆ?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5910101', '??', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5911001', '??', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5911401', '??', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5912901', '?₯?©', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5913001', 'κ³ κΈ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5913002', '?μΉ?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5913202', '??(κ³ κΈ)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5913205', '?΄?(??)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5844605', '??μ΄?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5913402', '?κ°?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5844701', '?Έ???', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5913404', 'μ²λ(??)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5913601', '?Ήλͺ?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5914601', 'λͺμ¬?­λ¦?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5920006', '??¨(κ°μ§)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5920301', '?λΆ?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5920601', '?±? ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5920801', '?΄μ²?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5920803', '?°?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5921201', '?μ²?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5921401', 'λ³μ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5921704', 'κ΅λ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5922402', 'κ°μ ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5844902', '? μ΄?(? ?¨)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5923401', 'κ°μ§(? ?¨)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5923501', '? ?(? ?¨)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5846102', '???? ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5846104', '???(??)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5850201', '?΄? ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5850801', '??', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5850901', '?κ²?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5851101', '?‘? λ¦?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5852401', 'λ¬΄μ(? ?¨)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5853301', 'λ¬΄μκ³΅ν­', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5855301', 'μ²?κ³?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5855401', 'λͺ©ν¬??', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5856201', '?μ²??', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5856701', '?¨?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5864201', 'λͺ©ν¬', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5872401', '?¨κ΅?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5881201', '? ?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5881301', 'μ§??', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5890001', '?Ήμ§?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5892201', 'μ§λ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5892801', 'μ§??', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5893607', '? λΉμΉμ§λ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5894501', 'κ΅΄ν¬', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5900101', 'κ΅¬μ?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5900102', 'λ³μλ¦?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5900201', '??', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5900302', 'λ¬΄κ³ ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5900303', 'κ°μ°λ¦?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5900401', '?°??', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5900501', '?λ¬?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5900601', '?₯?(? ?¨)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5900605', '?? ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5900610', '?‘?°(?΄?¨)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5900701', '?¨λ¦?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5900705', '?°?Ή', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5900802', '?Ό? ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5900901', '??λ¦?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5901101', '??μ§λ¦¬', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5901102', 'μ΄μ‘', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5901201', '??Έλ¦?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5901202', '?Έ?‘λ¦?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5901402', '??λ¦?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5901601', '?‘?Ό?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5901603', '?°κ΅?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5901604', '??λ¦?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5901701', 'λ°©μΆλ¦?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5901702', '?¬?λ¦?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5901703', '?μ£Όν¬', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5901704', 'κ°??λ¦?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5901705', '?¬? λ¦?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5924601', 'κ΅¬μ±', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5925102', '?‘?(? ?¨)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5925501', '?Ό? ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5925601', 'κ΄??', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5926101', 'μΉ λ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5926201', '?₯κ³λ¦¬', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5901706', 'λ°κ³', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5901708', '?? λ¦?(? ?¨)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI0000150', '?κ΄?(κΈνΈ)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI0000151', '?κ΄?(?¬?Ό)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5732602', '??? ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5923402', 'κ°μ§κ΅°λ΄', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5923403', 'κ°μ§2', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5924804', '? ?,?΅κΈ?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5761601', '???¬', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5770802', '?¬μ§κ°?΄κ²μ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5812002', '??κΈνΈμ§ν', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5930005', 'λ³΄λ¦Ό?¬', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5930104', 'λ§μ ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5930108', '?₯μ£?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5930114', '? μΉ?2', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5930302', 'λ΄λ¦ΌκΈνΈμ§ν', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5930306', 'λ΄λ¦Ό2', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5815711', '??? λ¦?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5930502', '?κ³?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5930605', '?©?°κΈνΈμ§ν', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5930607', '?₯??©?°', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5930608', '? ? ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5930609', 'κ΄ν', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5930702', 'λ°°μ°κΈνΈμ§ν', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5930703', 'λ°°μ°2', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5930802', 'λ°μ°', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5930803', 'λΆλ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5930804', 'λ°©μ΄', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5932403', '?₯?₯κΈνΈμ§ν', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5933804', '??', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5933901', '??‘', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5933902', '??½', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5933904', '?₯?¬', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5934103', '?¬?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5934204', '?©?°2', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5934404', 'μ²μ°', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5934406', '? ?₯', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5815809', '?΄μ£Όμ¬', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5816103', '?΄λ¦?(??)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5934505', 'λ¬΅μ΄', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5935106', 'κ΄??°κΈνΈμ§ν', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5935110', 'κ΄??°2', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5935306', '??2', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5935602', 'μ§?? 1', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5936007', '?μ§?2', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5816407', '?₯μΉ?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5816408', '?΄?κΈνΈμ§ν', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5816409', 'κΈλ₯-??', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5816529', '?Έλ¦¬λͺ©', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5936506', '???κΈνΈμ§ν', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5936507', '???2', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5940201', 'μ§μ°', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5942303', 'λ²κ΅(? ?­)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5944801', '?Ήμ°¨λ°­', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5945503', 'λ³΄μ±λΆλ¬Έ(μ§ν΅)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5945802', 'λ³΄μ±(μ§ν΅)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5947102', '?¨?¬(μ§ν΅)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5947501', 'κ΅°ν', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5947502', '? ?Ό', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5840005', 'κ΄μ£Ό(??)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5841103', '??κ΅°κ΅¬κ°?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5952151', '?¨?΄λ¦?,?©?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5952152', 'κ°μ²,??¬', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5843411', '?κ³?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5952206', '?°?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5230001', '?? ,?¨μ²?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5230203', 'λͺ¨μ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5843903', 'κ΅°λ΄?μ²?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5844501', 'κΈ°λ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5953703', '?°?°2', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5954003', 'κ³ ν₯(? ?­)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5954704', '??? ,μ£½μ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5954905', 'μ£½μ2', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5955502', '?Ή?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5955504', '?Ή?(? ?­)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5956408', '? ?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5850902', '?κ²?(?)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5853402', 'λ§μ΄.??΄λ¬?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5853701', '?΄?¨', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5857101', '??°', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5857501', '?°??₯', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5864202', 'κ΅°λ΄λͺ©ν¬', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5880802', '?°? λ¦¬μ?₯', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5883601', '??', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5956411', 'κΈμ₯?€μ²?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5956412', 'κΆμ ?°?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5956903', '?λ‘λ(?)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5971502', '?¬?(? ?­)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5890002', 'κ΅°λΉμ§?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5890003', 'μ£½μ ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5890004', '?λ¦?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5890005', 'λ§κΈ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5890201', '?? ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5890203', '??', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5890602', 'κ³ κ΅°?€λ₯?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5890603', '?΄?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5890604', 'λ²½ν', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5890605', 'λ§μ°', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5890606', 'κ³ κ΅°?°?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5890607', 'μ§??°?€λ₯?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5890701', 'μ§?λ§?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5890703', 'λ²ν¬', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5890704', '?©μ‘?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5890706', 'κ΅°ν¬', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5890902', 'κ΅°λ΄? ?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5890903', '??? ?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5891002', 'λͺ¨μ¬', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5891102', 'κ°?κ³?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5892601', '?κ΅?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5892802', '???¬', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5893501', '?? ?‘? ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5893504', 'κ°?κ³ν?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5893505', '?λͺ©μ‘? ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5893602', '?°μ£?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5893603', 'μ΄μ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5893604', 'μ΄μ¬', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5893701', '?λͺ?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5893702', '??­', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5893703', '?λͺ?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5893801', '?κ³?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5893901', '?κΈκ°', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5893902', 'κΈκ°', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5893903', '?? ?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5893905', '? ?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5894201', '?­?Ό?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5894202', 'κ΅¬λΆ?€', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5894203', '???‘? ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5894401', 'κ·??±', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5894402', '?λ¦?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5894403', 'μ£½λ¦Ό', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5894404', 'κ°κ³', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5894405', '?λ³΅λ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5894406', 'μ€λ§', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5894502', '?¨? ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5894503', '?½λͺ?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5894504', '?¨?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5894505', '?½λͺ©ν­', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5894506', '?λ§?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5894604', 'κ±°μ ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5894605', 'κΈΈμ?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5894606', '??¬', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5894607', '?μΉ?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5894702', '?΅λ¬΄κ³ ?Ό', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5894703', 'κ³ μΌ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5894802', 'κ°λ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5894901', '???°', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5894902', 'κΈλΈ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5895002', '?Έμ§?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5895101', 'κ΄?λ§?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5895102', '?‘?Έ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5895201', 'κ°?μΉ?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5895202', 'λ΄μ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5895203', '?λ΄μ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5900402', '?°??(κ΅°λ΄)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5900606', 'κ΅°λ΄?₯?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5900702', 'κ΅°λ΄?¨λ¦?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5900801', '?©?°?‘?Έ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5901203', '?‘μ²?(?΄?¨)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5901204', 'κΈμ‘', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI3894501', '?΄?°?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5704310', 'λ¬λ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5901906', '?‘? ?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5901907', 'μ¦μ?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5901908', '??‘', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5902201', '?©?°?΄λͺ?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5902302', 'κ΄??', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5903802', '?΄?¨κ΅°λ΄', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5903803', '?΄?¨κ΅¬κ°', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5904101', 'μ΄νΈ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5904104', '?¬κ΅?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5904501', '?΄?¬λ¦?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5715329', 'λ§μΉ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5715352', '?΄?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5715373', '?Ό?°', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5715388', '??', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5904801', 'λͺκΈ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5904902', 'κ°?μ’?', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5905503', '?¨μ°?(κ΅°λ΄)', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5905801', 'κ΅¬μ', 36, '? ?Ό?¨?' FROM DUAL
UNION ALL SELECT 'NAI5905813', 'κ³ ν(?΄?¨)', 36, '? ?Ό?¨?' FROM DUAL UNION ALL
SELECT 'NAI5905901', 'κ³ λ΄λ¦?', 36, '? ?Ό?¨?' FROM DUAL UNION ALL
SELECT 'NAI5906103', 'κ΅°λ΄??‘', 36, '? ?Ό?¨?' FROM DUAL UNION ALL
SELECT 'NAI5906113', '??°?©?°', 36, '? ?Ό?¨?' FROM DUAL UNION ALL
SELECT 'NAI5906311', 'κ΅°λ΄?°? ', 36, '? ?Ό?¨?' FROM DUAL UNION ALL
SELECT 'NAI5906503', 'κ΅°λ΄??', 36, '? ?Ό?¨?' FROM DUAL UNION ALL
SELECT 'NAI5906504', 'κ΅°λ΄?‘?Έ', 36, '? ?Ό?¨?' FROM DUAL UNION ALL
SELECT 'NAI5910201', '?©μ§λ¦¬', 36, '? ?Ό?¨?' FROM DUAL UNION ALL
SELECT 'NAI5715483', '?λ¬?', 36, '? ?Ό?¨?' FROM DUAL UNION ALL
SELECT 'NAI5720105', '?₯?±?', 36, '? ?Ό?¨?' FROM DUAL UNION ALL
SELECT 'NAI5720702', '???₯', 36, '? ?Ό?¨?' FROM DUAL UNION ALL
SELECT 'NAI5721801', '??μ°?1κ΅?', 36, '? ?Ό?¨?' FROM DUAL UNION ALL
SELECT 'NAI5920204', 'κ΅°λ΄?±? ', 36, '? ?Ό?¨?' FROM DUAL UNION ALL
SELECT 'NAI5921402', 'λ³μ2', 36, '? ?Ό?¨?' FROM DUAL UNION ALL
SELECT 'NAI3216203', '?°?‘κ΅?(μ’μ)', 36, '? ?Ό?¨?' FROM DUAL UNION ALL
SELECT 'NAI4013188', '??? ', 36, '? ?Ό?¨?' FROM DUAL UNION ALL
SELECT 'NAI4013570', '?€μ²λ', 36, '? ?Ό?¨?' FROM DUAL UNION ALL
SELECT 'NAI5715407', '?₯?', 36, '? ?Ό?¨?' FROM DUAL UNION ALL
SELECT 'NAI5715414', '?΄?°.?μ§?', 36, '? ?Ό?¨?' FROM DUAL UNION ALL
SELECT 'NAI5715451', '?°λ΄?', 36, '? ?Ό?¨?' FROM DUAL UNION ALL
SELECT 'NAI5715471', '?₯? ', 36, '? ?Ό?¨?' FROM DUAL UNION ALL
SELECT 'NAI5715472', '?΄μ°?', 36, '? ?Ό?¨?' FROM DUAL UNION ALL
SELECT 'NAI5715481', 'λ³΄μ ', 36, '? ?Ό?¨?' FROM DUAL UNION ALL
SELECT 'NAI5910202', 'μ€λ¦¬', 36, '? ?Ό?¨?' FROM DUAL UNION ALL
SELECT 'NAI5910203', '?¬?', 36, '? ?Ό?¨?' FROM DUAL UNION ALL
SELECT 'NAI5910204', 'κ΅μΈ?', 36, '? ?Ό?¨?' FROM DUAL UNION ALL
SELECT 'NAI5910205', '??(κ΅°λ΄)', 36, '? ?Ό?¨?' FROM DUAL UNION ALL
SELECT 'NAI5910301', 'λΆλͺ©λ¦?', 36, '? ?Ό?¨?' FROM DUAL UNION ALL
SELECT 'NAI5910602', '?Ό?λ¦?', 36, '? ?Ό?¨?' FROM DUAL UNION ALL
SELECT 'NAI5913207', '??', 36, '? ?Ό?¨?' FROM DUAL UNION ALL
SELECT 'NAI5914604', '?‘κ³?', 36, '? ?Ό?¨?' FROM DUAL UNION ALL
SELECT 'NAI5914605', '?μ΄μΌκ±°λ¦¬', 36, '? ?Ό?¨?' FROM DUAL UNION ALL
SELECT 'NAI5914607', '???', 36, '? ?Ό?¨?' FROM DUAL UNION ALL
SELECT 'NAI5914801', '?λΆ?λ¦?', 36, '? ?Ό?¨?' FROM DUAL UNION ALL
SELECT 'NAI5914802', '?μ΄λ¦¬', 36, '? ?Ό?¨?' FROM DUAL UNION ALL
SELECT 'NAI5914803', '?κ³ λ¦¬', 36, '? ?Ό?¨?' FROM DUAL UNION ALL
SELECT 'NAI5915001', '? ?₯λ¦?', 36, '? ?Ό?¨?' FROM DUAL UNION ALL
SELECT 'NAI5916101', '???', 36, '? ?Ό?¨?' FROM DUAL;



------------------insert ? μ£Όλ------------------------------------------
INSERT INTO TERMINALS (TERMINAL_ID, TERMINAL_NAME, CITY_ID, CITY_NAME)
SELECT
    'NAI6362004', '132 κΈνΈλ¦¬μ‘°?Έ(κ΅λ)', 39, '? μ£Όλ' FROM DUAL
UNION ALL SELECT
    'NAI6362003', '131 κΈνΈλ¦¬μ‘°?Έ(λ΄κ°)', 39, '? μ£Όλ' FROM DUAL
UNION ALL SELECT
    'NAI6314601', '? μ£?', 39, '? μ£Όλ' FROM DUAL
UNION ALL SELECT
    'NAI9990036', '211 λ΄κ° -?±?°?­', 39, '? μ£Όλ' FROM DUAL
UNION ALL SELECT
    'NAI9990037', '212 κ΅λ - ?±?°?­', 39, '? μ£Όλ' FROM DUAL
UNION ALL SELECT
    'NAI9990038', '221 λ΄κ° - ?? ', 39, '? μ£Όλ' FROM DUAL
UNION ALL SELECT
    'NAI9990039', '222 κ΅λ - ?? ', 39, '? μ£Όλ' FROM DUAL
UNION ALL SELECT
    'NAI9990044', '291 ?Έ?,?λ¦?', 39, '? μ£Όλ' FROM DUAL
UNION ALL SELECT
    'NAI6311501', 'κ³΅ν­Airport', 39, '? μ£Όλ' FROM DUAL
UNION ALL SELECT
    'NAI6334305', '231 λ΄κ°?¨μ‘°λ‘', 39, '? μ£Όλ' FROM DUAL
UNION ALL SELECT
    'NAI6334308', '232 κ΅λ?¨μ‘°λ‘', 39, '? μ£Όλ' FROM DUAL
UNION ALL SELECT
    'NAI6362001', '131 ?¨?μ²΄μ‘κ΄?(λ΄κ°)', 39, '? μ£Όλ' FROM DUAL
UNION ALL SELECT
    'NAI6362002', '132 ?¨?μ²΄μ‘κ΄?(κ΅λ)', 39, '? μ£Όλ' FROM DUAL
UNION ALL SELECT
    'NAI6351305', '151 ??? ?΄μ§ν­(??΄??)', 39, '? μ£Όλ' FROM DUAL
UNION ALL SELECT
    'NAI6351306', '152 ??? ?΄μ§ν­(??,?¬κ³?)', 39, '? μ£Όλ' FROM DUAL
UNION ALL SELECT
    'NAI6351904', '255 ??΄κ΅μ‘??', 39, '? μ£Όλ' FROM DUAL;
    

----------------κ²½μ?¨? ---------------
INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5880201', '??(μ§λ¦¬)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5080201', '?? (κΉ??΄)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5135402', 'κ³ μ?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5135601', 'λ§μ°');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5139301', 'μ°½μ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5146901', '?±?°');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5152601', '?΄??κ°?(λ¦¬λ¬΄μ§?)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5153601', 'μ°½μ?¨?°');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5156701', '? μ΄?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5158701', 'μ§ν΄κ²½μ°°?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5160301', '?©?(?Ή?°,λͺμ?)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5161001', '??');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5170301', 'μ§ν΄');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5175001', 'λ§μ°?¨λΆ?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5177501', '?°?°');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5179401', 'μ§λ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5201101', '???°');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5201701', '?¨?κ°??Ό');  

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5202701', 'μΉ μ?κ³?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5203502', '?Όλ΄?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5204101', 'μΉ μ?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5204301', '?΄?? ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5204902', '??°');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5205402', '?¨?λ©?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5205701', '?λ¬?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5205702', '?¬?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5206104', '?μ΄?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5206201', '?°??₯');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5206202', '?¬?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5206301', 'λͺ¨μ ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5206501', '?¨?κ΅°λΆ(39?¬?¨)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5206601', 'μ£½μ°');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5210301', '? λ°?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5210801', '? κΈ?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5210802', '? κ³?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5210901', '?Έκ°?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5210902', '?Ό?°');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5211601', 'λ§λ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5211605', '?μ§?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5211606', '?±??');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5212201', '? κ³?(κ²½λ¨)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5212202', '?Έλ―?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5212206', '? κ³?(μ€κ΅)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5212801', '?©?(κ²½λ¨)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5213404', 'μΉ κ³‘');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5213405', '?°?¨');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5213502', '???');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5213506', '?€?¬');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5213701', 'κ°?λ‘?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5213801', '?? Ή');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5214901', '?¨?°μ£Όμ ?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5083101', '?Όκ³?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5086801', 'μ§μ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI3886901', '?‘μ²?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5087401', '? ?λ§μ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5087404', 'μ§λ?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5087606', 'μ΄μ ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5092201', '? ?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5092302', '?±λͺ¨λ³?(κΉ??΄)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5093801', 'κΉ??΄');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5096001', '? ?(κ²½λ¨)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5097103', '?? ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5100701', '?₯? ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5101101', '?₯? ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5102102', '?₯? λΆ?κ³?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5110801', '?μ΄?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5112303', '? κ³?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5112402', 'κ°?? ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5112403', '???°');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5112503', '??');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5119101', 'μ°½μ?­');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5121601', '?΄?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5130101', 'λ§μ°?­');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5000101', '??(?¨?? ?°)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5000601', 'λ΄μ°');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5001201', '??');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5001601', 'μ£½μ°');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5002201', '??(?¨?)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5003901', '?¨?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5005502', '?Όλ΄?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5010302', '?μ²?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5012001', 'κ°?μ‘?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5020001', '?΄?Έ?¬');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5020101', 'κ°??Ό');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5020601', '?Όλ‘?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5020602', 'λΆκΈ°');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5020801', '?μ΄?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5020802', 'λ¬μ°');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5020804', '??±(?©μ²?)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5020806', 'κ°??°');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5020902', 'κ΄?κΈ?(?©μ²?)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5021501', 'μ€μ΄');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5021801', '?λ°?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5022101', '?΄?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5022201', '?Όκ°?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5022704', '?΄κ³?(?©μ²?)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5023301', '?©μ²?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5024001', '???');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5024201', '?¨κ³?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5030101', '?΄λ°?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5030801', 'λ¬΄μ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5030901', '? ?Ή');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5031002', 'λͺ¨μ ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5031003', 'λͺ¨μ?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5031101', '??κ²?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5031102', '?­?΄λ¦?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5031103', '?±?°(μ°½λκ΅?)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5031701', '??°');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5032301', 'μ°½λ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5035701', '?¨μ§?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5036501', 'λΆ?κ³?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5036502', '??€');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5041701', '??(?λ£?)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5042301', 'λ°??');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5044903', '?λ¦?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5025302', '? κ΅?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5050201', '?΅??¬');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5053601', '?μ°?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5062901', '??°');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5240301', '?λ§?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5240302', '?€κ³?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5240401', '???¬');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5240402', 'μ°¨λ©΄');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5241401', '?¨?΄');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5243601', 'κ°?μ²?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5244104', '?λͺ?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5244501', '? ?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5250401', 'κ³€μ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5250901', 'μΆλ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5251001', '?κ³?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5251601', '?¬μ²κ³΅?­');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5251801', '?¬μ²?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5252502', '? ?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5253607', '?¬μ²μ¬?¨');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5253902', '?¬μ²μμ²?(?©?)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5253904', '?κ³?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5254601', '???¬');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5255901', '?Όμ²ν¬');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5263901', 'μ§??΄');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5272201', '? ?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5275901', 'μ§μ£Ό');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5275902', 'μ§μ£Ό(μ§ν΅)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5275903', 'μ§μ£Ό');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5275907', 'μ§μ£Ό');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5275908', 'μ§μ£Ό');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5215801', 'μ€λ¦¬');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5282201', 'κ±°μ°½');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5282202', 'κ°μ(μ§μ£Ό)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5284701', '??(μ§μ£Ό?)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5290001', '?΅?€');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5290401', 'λ΄μΉ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5290601', '??');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5290602', '?λΆ?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5291201', 'λ§μ(κ°μ²)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5291401', '?μ§?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5291501', 'λ°°λ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5291701', '?΄? ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5291801', 'κ΅°μ§');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5291802', '?₯κΈ?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5291803', 'κ²??¬');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5292514', 'μ’μ΄');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5292515', 'κ΅¬λ§?Όμ£?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5292520', '?Ή?­?¬');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5292701', 'λ²μ΄');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5292803', '?? ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5292902', '??λ¦?(κ³ μ±)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5220401', '?μ΄?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5220801', '?μ΄?(?°μ²?)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5221801', '?°μ²?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5224404', 'κ΅¬λ§(??°)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5224601', 'κ΅¬μ¬');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5224901', '?μ§?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5225501', '?‘κ³?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5230302', '?κ°κ³΅?©');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5230401', '?κ°?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293101', 'κ³ μ±(κ²½λ¨)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293120', '???κ΅?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293121', '?©λ¦?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293122', '??¬');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293124', '??Ή');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293125', '?‘? ?Όμ£?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293126', 'μ²κ³‘');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293127', '?₯? ?κ΅?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293128', 'κ°μ²/?Έκ°?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293129', '??λ²?/??μ΄?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293130', 'μ’μ/?΄?€');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293131', '?°?/? λΆ?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293133', 'λ¬΄λ/??');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293134', '?Έ?/κ΄??');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293137', '??°/λ§€μ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293139', 'κ°μ²/?₯μ²μ¬');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293140', '???/?₯?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293144', '?Ήλͺ?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293301', '?΄?Ή');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293302', '?κ³?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293401', '??¨?¬κ±°λ¦¬');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5295102', '?λ¦?(κ³ μ±)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5295201', 'λ§λ¦Ό');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5295301', 'λΆ??¬');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5295502', '??');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5296101', '??΄');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5302001', '?΅?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5303201', '?λΆ?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5303802', 'λ¬΄μ ?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5320101', '?₯λͺ?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5322401', '?₯?¬');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5325101', 'κ±°μ (κ³ ν)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5327801', '?¬κ³?(κ±°μ )');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5331601', '?₯?Ή?¬');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5333402', '?΄κΈκ°');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5231802', '?¨?¬');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5232501', '??');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5233301', '??°');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5234101', '?μ΄?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5234201', '??¬');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5234401', 'μ§κ΅');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5235002', '?Έ?/??κ΅?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5235101', '??μΉ?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5235203', '?Έ?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5086809', 'μ§μ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293105', 'λ§€μ /?©? ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293106', '???λ§κ°');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293107', '?°λ§κ°(?΄? )');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293108', 'κ°μ²/?₯μ²μ¬(μ§ν)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293110', '?₯?­(κ²½λ¨)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293111', '?°κ΅¬ν?¬');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293112', '?Έλ°?/?κ΅¬ν');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293113', '?₯μ’?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293114', 'μ€μ΄/?°??¬');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293116', '?°κ°?λ£?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293117', '?Έκ³?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293118', 'κ±°μ°/?­??');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293119', 'κ°μ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293123', '??');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293132', '?΄κ°?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293135', 'κ³μ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293136', '??/?Ή?°');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293138', '??°/??€');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293141', '?€?/?΅?€');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293142', 'κΈκ³‘(κ΅¬λ§)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293143', 'μ§λΆκ³?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293145', '?±? ?κ΅?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293146', '??°/μ΄μ ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293147', '?λ§?/? λ¦?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293148', 'μ’λ ¨/? ?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293149', 'λ΄ν');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293150', '?₯λ°?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293151', '?? /?₯μ§?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293153', '?μ΄?/?₯μΉ?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293154', 'κΈκ³‘(λ§μ)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293155', 'κ°μ(κ²½λ¨)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293156', '?¨μ§?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293159', 'κ³΅λ£‘??€?¬');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293160', '?μ΄?/?°λΆ?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293161', 'κ°??/λ¬΄μ ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293162', 'λͺμ‘');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293163', '?? ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293164', 'κ³€κΈ°');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293166', '?? ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293167', '?°κ³?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293168', '?°κ³?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293169', 'κ°??/λ¬΄μ ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293170', '?λ¦?/μ€μ΄');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293171', 'λΉκ³‘/? μ΄?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293172', 'κ³ λ΄');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293174', '?΄??/κ΅¬μ€');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293175', '?¨?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293176', 'μΆκ³/????');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293177', 'λ΄λ°1λ¦?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293178', 'λ΄λ°2λ¦?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293179', '?΄?κ³΅μ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293180', '??¬/??Ό');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293181', '?©?/λ§₯μ ?¬');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293182', '?μ‘±μ/? ? ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293183', '?λͺ?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293184', '??΄(λ§₯μ ?¬)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293185', '??Ό/??¬');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293186', '? κ³?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293187', '??΄(?Ό?°)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293188', '?Όμ²ν¬(?Ό?°)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293189', '?¬κ΅?/??°');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293191', 'κ³ λ΄');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293194', 'μ€μ΄/?λ¦?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293198', 'κ±΄λ‘?¬');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293201', '?°??¬');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293202', '??μ²?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293203', '?λ§?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293204', 'μ’λ?μ²?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5101102', '?₯? (λ¦¬λ¬΄μ§?)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5102104', 'κΉ??΄?Έκ³?(?¨?)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293206', 'μ§??');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293252', '?₯?°');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293256', '??');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5293257', 'κ΅?κ²?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5295202', 'μΆμ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5135611', 'μ°½μ/?λͺ?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5135612', '? ?©');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5135618', '??΄μ΄λ²?€');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5135699', '? μ§?.? κΈ?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5136302', 'μ°½μ(λ¦¬λ¬΄μ§?)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5139306', 'λ¬΄κΈ°');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5152402', 'μ°½μλ³μ(λ¦¬λ¬΄μ§?)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5153602', '?¨?°?(λ¦¬λ¬΄μ§?)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5176301', 'λ¬Έν(κ²½λ¨)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5320705', '??΄(μ§ν)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5320706', '??΄(??)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5201702', '?¨?/??');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5206502', 'κ΅°λΆ/??');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5210803', '? κΈ?,μ€κΈ°');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5841102', '??κ΅°λ΄');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5215602', '?? (κ²½λ¨)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5215603', '?? ,μ€μ΄');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5215804', '??€');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5222201', 'κ°μ(?Ή?)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5222202', '?Ή?(??)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5222203', '?Ή?(μ§ν)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5222801', '?κ³?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5553202', 'κ΄ν¬');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5230201', '?κ³?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5230202', '?κ³?,?©κ°?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5230204', 'λͺ©μ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5230304', 'λ²ν,κ°??');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5230307', '? κΈ?,μΉ¨μ ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5230404', 'κ²??');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5230406', '? ?₯(?κ°?)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5230502', '?λ§?,?μ΄?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5230703', '??¬,??μ΄?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5230803', '?κ³?,?? ??');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5230804', 'μΆμ?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5231101', 'λ¬Έμ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5231103', '??');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5231204', '??');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5231401', '?₯μ’?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5231403', 'λ°±ν (κ²½λ¨)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5231503', '?μ²μ¬');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5231601', '??©');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5231704', 'κ°??');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5231805', '?΄λͺ?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5000102', '??');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5232506', '?΅? ,? ? ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5233309', '??°');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5234004', 'κ³ λ¨μ΄λ±');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5890705', '??¬');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5005103', '? ?,??');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5234801', '? μ°?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5235007', 'κΈλ¨κ³?,?μ²?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5235050', 'κ΅°λ???');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5235210', '???‘,??‘');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5235211', '?¨?΄');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5240403', '???¬,κ³ ν');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5250004', 'μ΄λ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5250005', 'κ³€λͺ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5250103', '??¬');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5250104', 'κ΅¬λͺ°');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5250902', 'κ΅¬νΈ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5044201', 'μ΄λ±');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5251810', 'κ²?λ¬Έμ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5252001', '?¬μ£Όλ¦¬');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5252510', '??, ??');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5253603', '?°μ²?(κ²½λ¨)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5253605', 'λ³λ,?? ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5253801', '?κ³?(κ²½λ¨)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5253802', '?¨? (κ²½λ¨)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5254101', 'κΈμ§(κ²½λ¨)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5254105', 'κ΅΄ν¬(?¬μ²?)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5254301', '??');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5254402', '?€λ§?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5254503', 'λΉν ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5254701', '?¨?(κ²½λ¨)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5275910', 'μ§μ£Ό');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5283101', 'μ§μ£Ό?? ??');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5290102', '??,? ?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5291503', 'κ±°μ ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5291504', '? ?¬');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5291506', '?°λΆ?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5291507', 'μ²?κ΄?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI4012989', 'λͺ¨λ‘?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI4013502', '? λ΄μ°');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI4013510', '?₯λ¦?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI4013511', '?¬?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI4013512', '?¨μ§?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI4013580', '?? ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI4013599', '?¨?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI4015301', '?κ³‘λ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5045401', '??');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5045501', '? ?Έ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5050202', '? ?(?΅??¬)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5058701', '??(κ²½λ¨)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (38, 'κ²½μ?¨?', 'NAI5254702', 'λ²½λ');


---------isnert κ²½μλΆλ -------
INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3626201', '?¬?°(λ΄ν)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI4015004', 'λ§€νλ§μ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3845402', '??κ΅¬λ?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI5840601', '??Ό');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3815701', 'κ²½μ£Ό??Έ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3836002', '?¬? ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3843601', '??');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3854701', '??κ²½λ??κ΅?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3881001', '?Όμ°?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3881301', '?μ²?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3881702', '?κ³?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3888201', 'κΈνΈ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3888501', '?μ²?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3902701', 'λΆλ‘');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3911701', '? ?°');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3917001', '?₯κ³?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3923301', 'κ΅¬λ??');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3926701', 'κ΅¬λ?Έκ³΅?¨');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3937501', 'κ΅¬λ?Έλ³΅μ§?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3937502', 'κ΅¬λ?Έλ³΅μ§?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3942601', 'κ΅¬λ?ΈμΈ?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3952901', 'κΉ?μ²IC');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3958601', 'κΉ?μ²?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI4002701', '?±μ£?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI4005301', '?©? ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI4006401', '?€?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI4006601', '?¨???');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI4012102', '??2λ¦?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI4013501', 'κ³ λ Ή');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI4014001', 'λ¬μ°');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI4014602', 'κ΄λ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI4014801', '?€?¬');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI4015201', '?μ§?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI4015202', '?©?±');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI4015302', 'λΆ?λ‘?κ΄?κ΄μ?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI4016001', '?λ¦?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI4016002', '?λ¦?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI4016201', '??΄');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI4016301', 'κ·??');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI4016501', '?λ¦?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI4016502', 'μ§?λ¦Ώμ¬');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI4016504', '??΄');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3604501', '?κΈ°IC');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3607801', '?μ£?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3609901', 'κ½λ?°');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3614401', '?₯?(κ²½λΆ)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3617502', '???');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3621401', 'μΆμ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3623801', 'λ΄ν(κ²½λΆ)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3626501', 'κ΄λΉ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3626601', '??');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3627102', '???');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3630101', '?Όκ·?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3630501', 'λΆ?κ΅?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3631601', 'μ£½λ?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3632601', '?Έμ§?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3633601', 'κ΅¬μ°');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3633602', '?±λ₯κ΅΄');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3633901', 'λ§€ν');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3634801', 'κΈ°μ±');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3635201', '?¬?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3635801', '?¨? ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3636401', '??‘');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3636601', '??΄');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3636901', '??¬');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3637001', '?Ό?¨(??¬)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3640501', 'λ³κ³‘(κ²½λΆ)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3641101', '??΄');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3641401', '??λ³μ?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3641901', '?κ³?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3643101', '??');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3644202', '?? ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3645901', 'κ°κ΅¬');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3646301', '?₯?¬');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3653301', '??');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3654601', '??');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3655301', 'λ°©μ ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3656001', '?λ³?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3661401', '?Ήμ²?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3661601', 'κ³Όν??(??)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3661901', '?λ¦¬λ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3662101', '??°');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3663601', '??');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3664602', '???€κ±°λ¦¬');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3668701', '? ?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3669901', '??(?΄?₯)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3672001', '?©?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3672801', '????');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3673201', '??');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3673202', 'μ§??(??)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3673501', 'κΈΈμ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3675601', '?Όμ§?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3675901', 'κ²½λΆ?μ²?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3680201', '?λ¦?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3680901', '? ?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3681101', 'κ°μ²');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3682301', '?μ²μΌκ±°λ¦¬');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3682601', '?μ²?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3682801', '?Όκ±°λ¦¬');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3684101', 'κ°??');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3684102', '? μ²?(κ²½λΆ)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3684202', 'λΆ????λ¬?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3684203', '?°μ²?(κ²½λΆ)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3684403', 'κ°ν¬');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3684901', 'κ²½λΆ?μ²?(? )');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3685801', '?©κΆ?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3685802', '?©κΆμ­');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3686601', '??');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3691701', 'λ¬Έκ²½');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3692601', 'λ§μ±');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3693701', '?°?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3693703', '?©?(κ²½λΆ)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3695102', '? μ΄?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3696701', '? μ΄λΆλΆ?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3699601', 'κ°???');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3710201', '?λΆ?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3711801', '?¨μ°?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3711802', '?¨μ°½μ?΄');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3713201', '?? (κ²½λΆ)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3713601', '?°?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3713901', '?? Ή');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3714101', '??¨');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3714901', '?΄?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3715101', '??');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3718101', '?μ£Όμ?Έ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3718102', '?μ£Όμ?΄');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3722301', '?μ£Όλ?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3722401', 'κ²½λΆ??(?μ£?)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI2614302', '??');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI5243501', '?¬μ΄?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3692501', '?¨?Έ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3693702', '?μ‘?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3758301', '?₯?±');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3815702', 'κ²½μ£Όκ³ μ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3864602', 'λ³μ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3881801', '??μ²IC? λ₯μ₯');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3962602', 'κΉ?μ²λ?κ³‘ν?¨');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3989602', '?κ΄?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI4011237', 'λ²μ?2λ¦?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI4011245', 'λ²μ?1λ¦?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI4011498', '?©?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI4011502', 'λ°κ³‘(??)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI4011539', 'λ¬΄κ³');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI4011674', '??±');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI4011701', '?Ό??1λ¦?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI4012167', '??°');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI5253201', '??±');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI5715382', '???Όκ±°λ¦¬');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI4012365', '?΄?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI4012645', '?Έ1λ¦?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI4012656', 'κ°?λ₯?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI4012944', '?©?₯');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI4013503', '??Ό?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI4013521', '?¨??');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI4013548', '??±?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI4013561', 'μ°½μ²');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI4013566', '?λ₯?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI4013571', '?μ§?(κ³μ )');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI4013576', '?Έ2λ¦?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI4013577', '??¬');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI4013578', '?€?°');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI4013583', '??κ΅?(??)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI4013586', 'λ°±μ΄1λ¦?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI4014388', '?Ό?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI4014701', 'κ°ν¬');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI4015001', 'λΆ?2λ¦?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI4015009', '?Έ?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI4015011', 'λΆ?1λ¦?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI4015103', '?Ό? ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI4015769', 'λ°±μ°');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI4015902', '??κ³‘λ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3640801', '??°λ³μ(??)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3641903', '?κ³?,λ³κ³‘');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3643190', '??λ²μ€');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3744601', 'λΆ??¨');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3745101', '??');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3745601', '??(??)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3746201', '?λͺ?(??)');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3751001', '?₯?΄');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3751002', '?‘?Ό');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3751501', 'μ²??');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3770101', '?λ£¨λ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3776001', '?¬?­');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3789201', 'μ°½ν');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3805601', '??μ²?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3725001', '??');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3725701', 'μ²?λ¦?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3726701', '?₯?°');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3736202', '?λ¦¬μ');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3740901', 'μ§λ³΄');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3742001', '?μ²?');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3743101', 'μ²??‘');

INSERT INTO TERMINALS (CITY_ID, CITY_NAME, TERMINAL_ID, TERMINAL_NAME)
VALUES (37, 'κ²½μλΆλ', 'NAI3743701', 'μ£Όμ?°');

commit;




SELECT TERMINAL_ID, TERMINAL_NAME, CITY_ID, CITY_NAME
	    FROM TERMINALS
	    WHERE TERMINAL_NAME LIKE '΅Ώ' || '%';




