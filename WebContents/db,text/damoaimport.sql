명령어 예시입니다
cmd에서 아래 입력
테이블 스페이스 늘리기
cmd
   c:>sqlplus /nolog
  sql> connect  / as sysdba
         에러나면 -> sql> conn sys/1234 as sysdba
		sql> conn sys/didtjsdn1564! as sysdba
ALTER DATABASE DATAFILE 'C:\ORACLEXE\APP\ORACLE\ORADATA\XE\SYSTEM.DBF' RESIZE 5000M; 
ALTER DATABASE DATAFILE 'C:\ORACLEXE\APP\ORACLE\ORADATA\XE\SYSTEM.DBF' RESIZE 10000M; 
ALTER DATABASE DATAFILE 'C:\ORACLEXE\APP\ORACLE\ORADATA\XE\SYSTEM.DBF' RESIZE 5000M;



1. cd C:\oraclexe\app\oracle\product\11.2.0\server\bin 

2. imp userid=jsp/1234@XE FILE="경로\파일" TABLES = (BUILD_ADDRESS, MEMBERS, COVIDINFO, SCREENING_CLINIC)
	예시) imp userid=jsp/1234@XE FILE="C:\daoma.dump" TABLES = (BUILD_ADDRESS, MEMBERS, COVIDINFO, SCREENING_CLINIC)
	*       파일 경로 입력시 한글이름 없게 할 것


imp userid=jsp/1234@XE FILE="C:\daoma.dump" TABLES = (BUILD_ADDRESS, MEMBERS, COVIDINFO, SCREENING_CLINIC)


"C:\daoma.dump"
C:\Users\양선우>cd C:\oraclexe\app\oracle\product\11.2.0\server\bin

C:\oraclexe\app\oracle\product\11.2.0\server\bin>imp userid=jsp/1234@XE FILE="C:\daoma.dump" TABLES = (BUILD_ADDRESS, MEMBERS, COVIDINFO, SCREENING_CLINIC)

Import: Release 11.2.0.2.0 - Production on 일 11월 14 20:53:44 2021

Copyright (c) 1982, 2009, Oracle and/or its affiliates.  All rights reserved.


Connected to: Oracle Database 11g Express Edition Release 11.2.0.2.0 - 64bit Production

Export file created by EXPORT:V11.02.00 via conventional path

Warning: the objects were exported by TEST, not by you

import done in KO16MSWIN949 character set and AL16UTF16 NCHAR character set
import server uses AL32UTF8 character set (possible charset conversion)
. importing TEST's objects into JSP
. importing TEST's objects into JSP
. . importing table                "BUILD_ADDRESS"   10744872 rows imported
. . importing table                    "COVIDINFO"          4 rows imported
. . importing table                      "MEMBERS"          4 rows imported
. . importing table             "SCREENING_CLINIC"        839 rows imported
Import terminated successfully without warnings.

C:\oraclexe\app\oracle\product\11.2.0\server\bin>