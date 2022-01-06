DROP TABLE COVIDINFO;

CREATE TABLE COVIDINFO(
     ID             VARCHAR2(20),
    INFONUM         NUMBER PRIMARY KEY,
    VACCINEORTEST   VARCHAR2(20),
    VACCINE         VARCHAR2(20),
    TEST_DATE       VARCHAR2(20),
    TEST_HOSPITAL   VARCHAR2(50),
    TEST_RESULT     VARCHAR2(20),
    SYMPTOM         VARCHAR2(4000)

);

