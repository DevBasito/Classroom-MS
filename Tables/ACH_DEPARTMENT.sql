--------------------------------------------------------
--  DDL for Table ACHAIA DEPARTMENTS
--------------------------------------------------------

  CREATE TABLE "ACH_DEPARTMENT" 
   (	"DEPT_ID" VARCHAR2(200),  -- Department ID (Unique)
	"DEPT_NAME" VARCHAR2(200), 	  -- Department Name
	"NO_OF_STAFF" NUMBER, 		  -- Number of Staff
	"PRIVILEGE_ID" VARCHAR2(200), -- Privilege ID ( Foreign Key From Privilege Table)
	"ISACTIVEYN" NUMBER DEFAULT 1 -- Is Active 
   ) ;
