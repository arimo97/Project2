create or replace PACKAGE PKG_COVIDBOARD AS 

  PROCEDURE  PROC_MEMBER_VIEW   ( 
        IN_ID        IN   VARCHAR2,
        O_ID         OUT  VARCHAR2,
        O_NICKNAME   OUT  VARCHAR2);

  PROCEDURE  PROC_BOARD_LIST    (
        O_CUR    OUT  SYS_REFCURSOR
        );
  
  --추천글---------------------------------      
  PROCEDURE  PROC_BOARDUP_LIST    (
        O_CUR    OUT  SYS_REFCURSOR
        );

  PROCEDURE  PROC_BOARD_INSERT( 
        IN_ID       IN   VARCHAR2,
        IN_BTITLE   IN   VARCHAR2,
        IN_BTEXT    IN   VARCHAR2,
        IN_NICKNAME IN   VARCHAR2
   ); 
        
    -- VIEW
    PROCEDURE  PROC_BOARD_VIEW (
    IN_BNUM   IN  NUMBER,
    O_CUR     OUT SYS_REFCURSOR
    );

    -- DELETE
    PROCEDURE  PROC_BOARD_DELETE(
    IN_BNUM   IN  NUMBER
    );
    
    -- UPDATE
    PROCEDURE  PROC_BOARD_UPDATE(   
    IN_BTITLE IN  VARCHAR2,
    IN_BTEXT  IN  VARCHAR2,
    IN_BNUM   IN  NUMBER,
    IN_ID     IN  VARCHAR2
    );
    
END PKG_COVIDBOARD;