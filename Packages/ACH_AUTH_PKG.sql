--------------------------------------------------------
--  File created - Saturday-March-08-2025   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package ADM_AUTH_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "ACH_AUTH_PKG" 
AS  
   FUNCTION custom_hash (p_username IN VARCHAR2, p_password IN VARCHAR2)  
      RETURN RAW;  

--    /**  
--    * Create account return ID  
--    *  
--    * @param p_username  username  
--    * @param p_password  password  
--    */  
--    PROCEDURE create_account_ret (p_email        IN     VARCHAR2,  
--                                  p_password     IN     VARCHAR2,  
--                                  p_company_id   IN     NUMBER,  
--                                  p_user_id         OUT NUMBER);  

--    /**  
--  * Create account  
--  *  
--  * @param p_username  username  
--  * @param p_password  password  
--  */  
--    PROCEDURE create_onboarding_account (p_email          IN     VARCHAR2,  
--                                         p_password       IN     VARCHAR2,  
--                                         p_job_offer_id   IN     VARCHAR2,  
--                                         p_notification   IN     CLOB,  
--                                         p_company_id     IN     NUMBER,  
--                                         p_user_id           OUT NUMBER);  
--     PROCEDURE create_applicant_account (p_email        IN     VARCHAR2,  
--                                  p_password     IN     VARCHAR2,  
--                                  p_first_name   IN     VARCHAR2,  
--                                  p_last_name   IN     VARCHAR2,  
--                                  p_company_id   IN     NUMBER,  
--                                  p_user_id         OUT NUMBER);  

--    PROCEDURE create_account (p_email        IN VARCHAR2,  
--                              p_password     IN VARCHAR2,  
--                              p_company_id   IN NUMBER);  

--    /**  
--    * Custom authenticate  
--    *  
--    * @param p_username  username  
--    * @param p_password  password  
--    */  
--    FUNCTION custom_authenticate (p_username   IN VARCHAR2,  
--                                  p_password   IN VARCHAR2)  
--       RETURN BOOLEAN;  


--    /**  
--    * Post authenticate  
--    *  
--    * @param p_username  
--    * @param out_user_id  
--    * @param out_first_name  
--    */  
--  FUNCTION custom_authenticate_ess (p_username   IN VARCHAR2,  
--                                  p_password   IN VARCHAR2)  
--       RETURN BOOLEAN;  


--    /**  
--    * Post authenticate  
--    *  
--    * @param p_username  
--    * @param out_user_id  
--    * @param out_first_name  
--    */  

--    FUNCTION custom_onboarding_authenticate (p_username   IN VARCHAR2,  
--                                  p_password   IN VARCHAR2)  
--       RETURN BOOLEAN;  

--     FUNCTION custom_applicant_authenticate (p_username   IN VARCHAR2,  
--                                  p_password   IN VARCHAR2)  
--       RETURN BOOLEAN;  
--    PROCEDURE post_authenticate (p_username    IN     VARCHAR2,  
--                                 out_page_id      OUT NUMBER);  


--    /**  
--    * Request reset password  
--    *  
--    * @param p_email  
--    */  
--    PROCEDURE request_reset_password (p_email IN VARCHAR2);  


--    /**  
--    * Verify reeset password  
--    *  
--    * verify the token of the password request and retun the id of the user  
--    *  
--    * @param p_token  
--    */  
--    FUNCTION verify_reset_password (p_id                  IN NUMBER,  
--                                    p_verification_code   IN VARCHAR2)  
--       RETURN NUMBER;  


--    /**  
--    * Reset password  
--    *  
--    * @param p_id  
--    * @param p_password  
--    */  
--    PROCEDURE reset_password (p_id IN NUMBER, p_password IN VARCHAR2);  

--    PROCEDURE send_ess_creation_email (p_company_id          IN NUMBER,  
--                                       p_full_name           IN VARCHAR2,  
--                                       p_verification_code   IN VARCHAR2,  
--                                       p_email_address       IN VARCHAR2);  

--    PROCEDURE send_onboarding_email (p_company_id          IN NUMBER,  
--                                     p_full_name           IN VARCHAR2,  
--                                     p_notification        IN CLOB,  
--                                     p_verification_code   IN VARCHAR2,  
--                                     p_email_address       IN VARCHAR2);  

--    PROCEDURE send_welcome_email (p_company_code     IN VARCHAR2,  
--                                  p_full_name        IN VARCHAR2,  
--                                  p_email_address    IN VARCHAR2,  
--                                  p_trial_end_date   IN DATE);  
END ach_auth_pkg;

