create or replace PACKAGE PKG_COVIDCOMMENT AS 

--해당 게시물 댓글 LIST-------------------------------

    PROCEDURE  PROC_COMMENT_ALL_LIST    (
        O_CUR    OUT  SYS_REFCURSOR);


  PROCEDURE  PROC_COMMENT_LIST    (
        IN_BNUM  IN   NUMBER,
        O_CUR    OUT  SYS_REFCURSOR);
        
-- INSERT-------------------------------------

PROCEDURE  PROC_COMMENT_INSERT( 
        IN_BNUM     IN   NUMBER,
        IN_CTEXT    IN   VARCHAR2,
        IN_ID       IN   VARCHAR2,
        IN_NICKNAME IN   VARCHAR2
   ); 

--댓글 수정을 위한 cnum으로 댓글 조회--------------

PROCEDURE  PROC_COMMENT_GET    (
        IN_CNUM  IN   NUMBER,
        O_CUR    OUT  SYS_REFCURSOR);



 -- UPDATE
    PROCEDURE  PROC_COMMENT_UPDATE(   
    IN_CTEXT  IN  VARCHAR2,
    IN_CNUM   IN  NUMBER
    );

-- DELETE
    PROCEDURE  PROC_COMMENT_DELETE(
    IN_CNUM   IN  NUMBER
    );

END PKG_COVIDCOMMENT;