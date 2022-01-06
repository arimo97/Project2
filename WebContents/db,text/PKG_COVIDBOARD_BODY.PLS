create or replace PACKAGE BODY PKG_COVIDBOARD AS

--MEMBERVIEW-----------------------------------------------------------

  PROCEDURE  PROC_MEMBER_VIEW   ( 
        IN_ID        IN   VARCHAR2,
        O_ID         OUT  VARCHAR2,
        O_NICKNAME   OUT  VARCHAR2) AS
  BEGIN
    SELECT  ID, NICKNAME 
      INTO    O_ID, O_NICKNAME
      FROM    MEMBERS
      WHERE   ID = IN_ID;
           
  END PROC_MEMBER_VIEW;


--LIST---------------------------------------------------------

  PROCEDURE  PROC_BOARD_LIST    (
        O_CUR    OUT  SYS_REFCURSOR) AS
  BEGIN
    OPEN   O_CUR  FOR
    SELECT BNUM,  BTITLE, BTEXT, ID, READCOUNT,
               TO_CHAR(BREGDATE, 'YYYY-MM-DD')   BREGDATE,
               TO_CHAR(BUPDATE,  'YYYY-MM-DD')    BUPDATE,
               NICKNAME, BDELETE

    FROM  COVIDBOARD
    WHERE BDELETE = 'N'
    ORDER BY   BNUM DESC;
  END PROC_BOARD_LIST;
  
--UPLIST 추천글--------------------------------------------------------
  PROCEDURE  PROC_BOARDUP_LIST    (
        O_CUR    OUT  SYS_REFCURSOR
        ) AS
  BEGIN
     OPEN   O_CUR  FOR
    SELECT BNUM,  BTITLE, BTEXT, ID, READCOUNT,
               TO_CHAR(BREGDATE, 'YYYY-MM-DD')   BREGDATE,
               TO_CHAR(BUPDATE,  'YYYY-MM-DD')    BUPDATE,
               NICKNAME, BDELETE

    FROM  COVIDBOARD
    WHERE BDELETE = 'N'
    ORDER BY   READCOUNT DESC;
  END PROC_BOARDUP_LIST;
  
  
  
  
  
--INSERT----------------------------------------------------

  PROCEDURE  PROC_BOARD_INSERT( 
        IN_ID       IN   VARCHAR2,
        IN_BTITLE   IN   VARCHAR2,
        IN_BTEXT    IN   VARCHAR2,
        IN_NICKNAME IN   VARCHAR2
   ) AS
    V_BNUM   NUMBER(10, 0);
  BEGIN
     -- 전체글의 글번호
     SELECT   NVL( MAX(BNUM), 0 ) + 1
      INTO    V_BNUM
      FROM    COVIDBOARD;
      
    INSERT INTO COVIDBOARD (
        BNUM,
        BTITLE,
        BTEXT,
        ID,
        READCOUNT,
        BREGDATE,
        BUPDATE,
        NICKNAME,
        BDELETE
        
    ) VALUES (
        V_BNUM,
        IN_BTITLE,
        IN_BTEXT,
        IN_ID,
        0,
        SYSDATE,
        SYSDATE,
        IN_NICKNAME,
        DEFAULT
    );
    COMMIT;
  END PROC_BOARD_INSERT;
  

--VIEW------------------------------------------------------
  PROCEDURE  PROC_BOARD_VIEW (
    IN_BNUM   IN  NUMBER,
    O_CUR     OUT SYS_REFCURSOR
    ) AS
  BEGIN
    -- 조회수 증가
  UPDATE COVIDBOARD
  SET  READCOUNT = READCOUNT + 1
  WHERE BNUM = IN_BNUM;
  COMMIT;
  
  -- BNUM로 조회

  
    OPEN O_CUR FOR
    SELECT
    BNUM,
    BTITLE,
    BTEXT,
    ID,
    READCOUNT,
    TO_CHAR(BREGDATE, 'YYYY-MM-DD')BREGDATE,
    TO_CHAR(BUPDATE, 'YYYY-MM-DD')BUPDATE,
    NICKNAME,
    BDELETE
    FROM
    COVIDBOARD
    WHERE
    BNUM = IN_BNUM
    AND BDELETE = 'N';
  END PROC_BOARD_VIEW;

  -- DELETE

  PROCEDURE  PROC_BOARD_DELETE(
    IN_BNUM   IN  NUMBER
    ) AS
  BEGIN
     UPDATE COVIDBOARD
     SET    BDELETE = 'Y'
     WHERE  BNUM  =  IN_BNUM;
    COMMIT;
  END PROC_BOARD_DELETE;

-- update


  PROCEDURE  PROC_BOARD_UPDATE(  
    IN_BTITLE IN  VARCHAR2,
    IN_BTEXT  IN  VARCHAR2,
    IN_BNUM   IN  NUMBER,
    IN_ID     IN  VARCHAR2
    ) AS
  BEGIN

    UPDATE COVIDBOARD
    SET    BTITLE = IN_BTITLE,
           BTEXT  = IN_BTEXT
    WHERE  BNUM   = IN_BNUM
    AND    ID     = IN_ID;
    COMMIT;

  END PROC_BOARD_UPDATE;



END PKG_COVIDBOARD;