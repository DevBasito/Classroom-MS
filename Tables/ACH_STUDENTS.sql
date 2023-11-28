--------------------------------------------------------
--  DDL for Table ACH_STUDENTS
--------------------------------------------------------

  CREATE TABLE "ACH_STUDENTS" 
   (	"STDNT_ID" VARCHAR2(20), 
	"USERNAME" VARCHAR2(200), 
	"FIRSTNAME" VARCHAR2(200), 
	"LASTNAME" VARCHAR2(200), 
	"DEPT_ID" VARCHAR2(200), 
	"ISACTIVEYN" NUMBER DEFAULT 1, 
	"EMAIL" VARCHAR2(200),
	"LEVEL" VARCHAR2(200)
   );
