--------------------------------------------------------
--  File created - Saturday-March-08-2025   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table ACH_USERS
--------------------------------------------------------

  CREATE TABLE "ACH_USERS"
   (	"USER_ID" NUMBER , 
	"EMAIL_ADDRESS" VARCHAR2(80 BYTE) , 
	"PASSWORD" VARCHAR2(100 BYTE) , 
	"FIRST_NAME" VARCHAR2(50 BYTE) , 
	"LAST_NAME" VARCHAR2(50 BYTE) , 
	"EMPLOYEE_ID" NUMBER, 
	"VERIFICATION_CODE" VARCHAR2(100 BYTE) , 
	"COMPANY_ID" NUMBER, 
	"START_DATE_ACTIVE" DATE DEFAULT SYSDATE, 
	"END_DATE_ACTIVE" DATE, 
	"ACTIVE_FLAG" VARCHAR2(1 BYTE) , 
	"CREATED_BY" VARCHAR2(100 BYTE) , 
	"CREATION_DATE" DATE, 
	"LAST_UPDATED_BY" VARCHAR2(100 BYTE) , 
	"LAST_UPDATE_DATE" DATE
   )  ;
--------------------------------------------------------
--  DDL for Index ACH_USERS_EMAIL_UK
--------------------------------------------------------

  CREATE UNIQUE INDEX "ACH_USERS_EMAIL_UK" ON "ACH_USERS"("EMAIL_ADDRESS") 
;
--------------------------------------------------------
--  DDL for Index ACH_USERS_EMAIL_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "ACH_USERS_EMAIL_PK" ON "ACH_USERS"("USER_ID")  ;
--------------------------------------------------------
--  DDL for Trigger BIU_ACH_USERS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_ACH_USERS" 
   BEFORE INSERT OR UPDATE  
   ON ACH_USERS  
   FOR EACH ROW  
DECLARE  
--  
BEGIN  
   IF INSERTING  
   THEN  
      IF :new.user_id IS NULL  
      THEN  
         SELECT NVL (MAX (user_id), 0) + 1  
           INTO :new.user_id  
           FROM ACH_USERS;  
      END IF;  

      :new.verification_code := DBMS_RANDOM.string ('X', 7);  

      IF ach_auth_pkg.custom_hash (:new.email_address, :new.password) =  
            ach_auth_pkg.custom_hash (:new.email_address, NULL)  
      THEN 
         :new.password :=  
            ach_auth_pkg.custom_hash (:new.email_address,  
                                      :new.verification_code);  
      ELSE
         :new.password :=  
            ach_auth_pkg.custom_hash (:new.email_address, :new.password);  
      END IF;  



      :new.creation_date := SYSDATE;  
      :new.created_by := NVL (v ('APP_USER'), USER);  
      :new.last_update_date := SYSDATE;  
      :new.last_updated_by := NVL (v ('APP_USER'), USER);  

      --  

      IF UPDATING  
      THEN  
         :new.last_update_date := LOCALTIMESTAMP;  
         :new.last_updated_by := NVL (v ('APP_USER'), USER);  

         --  
         IF :new.email_address <> :old.email_address  
         THEN  
            :new.verification_code := DBMS_RANDOM.string ('X', 7);  

            IF ach_auth_pkg.custom_hash (:new.email_address, :new.password) =  
                  ach_auth_pkg.custom_hash (:new.email_address, NULL)  
            THEN  
               :new.password :=  
                  ach_auth_pkg.custom_hash (:new.email_address,  
                                            :new.verification_code);  
            ELSE  
               :new.password :=  
                  ach_auth_pkg.custom_hash (:new.email_address,  
                                            :new.password);  
            END IF;  
         END IF;  
      END IF;  
   END IF;  
END;




/
ALTER TRIGGER "TRG_ACH_USERS" ENABLE;
--------------------------------------------------------
--  Constraints for Table ACH_USERS
--------------------------------------------------------

  ALTER TABLE "ACH_USERS"MODIFY ("USER_ID" NOT NULL ENABLE);
  ALTER TABLE "ACH_USERS"MODIFY ("EMAIL_ADDRESS" NOT NULL ENABLE);
  ALTER TABLE "ACH_USERS"MODIFY ("PASSWORD" NOT NULL ENABLE);
  ALTER TABLE "ACH_USERS"MODIFY ("FIRST_NAME" NOT NULL ENABLE);
  ALTER TABLE "ACH_USERS"MODIFY ("LAST_NAME" NOT NULL ENABLE);
  ALTER TABLE "ACH_USERS"MODIFY ("COMPANY_ID" NOT NULL ENABLE);
  ALTER TABLE "ACH_USERS"ADD CONSTRAINT "ACH_USERS_EMAIL_UK" UNIQUE ("EMAIL_ADDRESS")
  USING INDEX "ACH_USERS_EMAIL_UK"  ENABLE;
  ALTER TABLE "ACH_USERS"ADD CONSTRAINT "ACH_USERS_EMAIL_PK" PRIMARY KEY ("USER_ID")
  USING INDEX "ACH_USERS_EMAIL_PK"  ENABLE;
