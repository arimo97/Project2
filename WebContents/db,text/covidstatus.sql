drop table  covidstatus;

CREATE TABLE COVIDSTATUS (
    STATUSNUM       NUMBER(6) PRIMARY KEY,
    GUBUN           VARCHAR2(30),
    DEFCNT          NUMBER(15),
    DEATHCNT        NUMBER(15),
    INCDEC          NUMBER(15),
    LOCALOCCCNT     NUMBER(15),
    ISOLCLEARCNT    NUMBER(15),
    QURRATE         NUMBER(30),
    STDDAY          DATE
);