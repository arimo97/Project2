



CREATE TABLE COVIDBOARD (
       BNUM         NUMBER(10)      PRIMARY KEY,
        BTITLE      VARCHAR2(100)   NOT NULL,
        BTEXT       VARCHAR2(4000)  NOT NULL,
        ID          VARCHAR2(20)    NOT NULL,
        READCOUNT   NUMBER(6),
        BREGDATE    DATE,
        BUPDATE     DATE,
        BDELETE     DATE,
        NICKNAME    VARCHAR2(80)

);
DROP TABLE COVIDCOMMENT;
CREATE TABLE COVIDCOMMENT (
    CNUM    NUMBER  PRIMARY KEY,
    BNUM    NUMBER(10)  NOT NULL,
    CTEXT   VARCHAR2(100) NOT NULL,
    ID      VARCHAR2(10)    NOT NULL,
    CREGDATE    DATE,
    CUPDATE     DATE,
    CDELETE     DATE,
    NICKNAME    VARCHAR2(80)
);

INSERT INTO COVIDBOARD (
        BNUM,
        BTITLE,
        BTEXT,
        ID,
        READCOUNT,
        BREGDATE,
        BUPDATE,
        BDELETE,
        NICKNAME
    ) VALUES (
        1,
        '제목',
        '내용~~~~~~~~~~~',
        '1234',
        0,
        SYSDATE,
        SYSDATE,
        SYSDATE,
        '1234'
    );
    
    INSERT INTO COVIDBOARD (
        BNUM,
        BTITLE,
        BTEXT,
        ID,
        READCOUNT,
        BREGDATE,
        BUPDATE,
        BDELETE,
        NICKNAME
    ) VALUES (
        2,
        '제목2',
        '내용2~~~~~~~~~~~',
        '1234',
        0,
        SYSDATE,
        SYSDATE,
        SYSDATE,
        '1234'
    );
    
    COMMIT;
    
    UPDATE COVIDBOARD
    SET    BTITLE = '수정됨',
           BTEXT  = '수정된 내용'
    WHERE  BNUM   = 6;
    COMMIT;
    
INSERT INTO covidcomment (
    cnum,
    bnum,
    ctext,
    id,
    cregdate,
    cupdate,
    cdelete,
    NICKNAME
) VALUES (
    1,
    1,
    '댓글1',
    '1234',
    SYSDATE,
    SYSDATE,
    SYSDATE,
    '1234'
);

INSERT INTO covidcomment (
    cnum,
    bnum,
    ctext,
    id,
    cregdate,
    cupdate,
    cdelete,
    NICKNAME
) VALUES (
    2,
    1,
    '댓글2',
    '1234',
    SYSDATE,
    SYSDATE,
    SYSDATE,
    '1234'
);

COMMIT;

SELECT CNUM, BNUM, CTEXT, ID,
               TO_CHAR(CREGDATE, 'YYYY-MM-DD hh24:mi:ss')   CREGDATE,
               TO_CHAR(CUPDATE,  'YYYY-MM-DD hh24:mi:ss')    CUPDATE,
               TO_CHAR(CDELETE,  'YYYY-MM-DD hh24:mi:ss')    CDELETE,
               NICKNAME

    FROM  COVIDCOMMENT
    WHERE BNUM = 1;

INSERT INTO covidcomment (
    cnum,
    bnum,
    ctext,
    id,
    cregdate,
    cupdate,
    cdelete,
    NICKNAME
) VALUES (
    3,
    2,
    '댓글 내용1 입니다.',
    '1',
    SYSDATE,
    SYSDATE,
    SYSDATE,
    '테스트용'
);

INSERT INTO covidcomment (
    cnum,
    bnum,
    ctext,
    id,
    cregdate,
    cupdate,
    cdelete,
    NICKNAME
) VALUES (
    4,
    2,
    '댓글 내용2 다모아가 쓴 글입니다.',
    'damoa',
    SYSDATE,
    SYSDATE,
    SYSDATE,
    '다모아'
);

COMMIT;

INSERT  INTO  COVIDCOMMENT (
        CNUM,
        BNUM,
        CTEXT,
        ID,
        CREGDATE,
        CUPDATE,
        CDELETE,
        NICKNAME
    ) VALUES (
        V_CNUM,
        IN_BNUM,
        IN_CTEXT,
        IN_ID,
        0,
        SYSDATE,
        SYSDATE,
        SYSDATE,
        IN_NICKNAME
    );
    COMMIT;