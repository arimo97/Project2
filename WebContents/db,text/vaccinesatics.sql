CREATE TABLE VaccineStatics(
            seq number(32) PRIMARY KEY,
            sido VARCHAR2(30),
            firstCnt NUMBER(10),
            secondCnt NUMBER(10),
            thirdCnt NUMBER(10),
            totalFirstCnt NUMBER(10),
            totalSecondCnt NUMBER(10),
            totalThirdCnt NUMBER(10),
            baseDate DATE NOT NULL
);

DROP TABLE VaccineStatics;

SELECT SYSDATE - 1 FROM DUAL;
SELECT *
FROM VaccineStatics
WHERE BASEDATE = TO_CHAR(SYSDATE - 5 ,'yy/mm/dd');
(SELECT (SYSDATE - 0) FROM DUAL);
--(SELECT (SYSDATE - 0) FROM DUAL)

SELECT SYSDATE FROM DUAL;

SELECT NVL(TO_CHAR((SELECT MAX(BASEDATE) FROM VACCINESTATICS), 'yyyyMMdd'), TO_CHAR(SYSDATE - 15, 'yyyyMMdd')) FROM DUAL