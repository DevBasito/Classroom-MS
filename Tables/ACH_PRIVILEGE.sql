--------------------------------------------------------
--  DDL for Table ACH_PRIVILEGE
--------------------------------------------------------

  CREATE TABLE "ACH_PRIVILEGE" 
   (	"PRIVILEGE_ID" VARCHAR2(200) DEFAULT TO_CHAR("PRIV_SEQ"."NEXTVAL"), 
	"CLASS" VARCHAR2(200), 
	"WATCH_LIMIT" NUMBER, 
	"VALIDITY_PERIOD" VARCHAR2(200), 
	"ACCESS_PRIV" DATE, 
	"INITIAL_WATCH_LIMIT" NUMBER
   ) ;
