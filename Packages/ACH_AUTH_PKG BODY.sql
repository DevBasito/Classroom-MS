--------------------------------------------------------
--  File created - Saturday-March-08-2025   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package Body ADM_AUTH_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "ACH_AUTH_PKG" 
AS  
   /**  
   * Constants  
   */  

   c_from_email   CONSTANT VARCHAR2 (100) := 'cibs_notification@counterhouseconsultants.com';  
   c_website      CONSTANT VARCHAR2 (100) := 'www.counterhouseconsultants.com';  
   c_hostname     CONSTANT VARCHAR2 (100)  
                              := 'https://g3fb85d70ffb14d-cibstest01.adb.uk-london-1.oraclecloudapps.com/' ;  


   /**  
   */  
   FUNCTION custom_hash (p_username IN VARCHAR2, p_password IN VARCHAR2)  
      RETURN RAW  
   IS  
      l_username           VARCHAR2 (100);  
      l_password           VARCHAR2 (100);  
      l_salt               VARCHAR2 (100) := 'achaia';  
      l_application_id     VARCHAR2 (100);  
      l_application_name   VARCHAR2 (100) := 'ACHAIA';  
   BEGIN  
      apex_debug.MESSAGE (p_message => 'Begin custom_hash', p_level => 3);  
      -- This function should be wrapped, as the hash algorhythm is exposed here.  
      -- You can change the value of l_salt, but you much reset all of your passwords if you choose to do this.  
      l_username := UPPER (p_username);  
      l_password :=  p_password;  
      l_password := sha256.ENCRYPT (l_salt || l_username || l_password);  
      apex_debug.MESSAGE (p_message => 'End custom_hash', p_level => 3);  
      RETURN l_password;  
   END custom_hash;  


   /**  
--    * Reset password email  
--    */  
--    PROCEDURE mail_reset_password (p_email IN VARCHAR2, p_url IN VARCHAR2)  
--    IS  
--       l_body   CLOB;  
--    BEGIN  
--       apex_debug.MESSAGE (p_message => 'Reset password CiBS', p_level => 3);  
--       l_body := '<p>Hi,</p>  
--              <p>We received a request to reset your password in CiBS Application.</p>  
--              <p><a href="' || p_url || '">Reset Now.</a></p>  
--              <p>If you did not request this, Kindly ignore this email.</p>  
--              <p>Kind regards,<br/>  
--              The CiBS Team</p>';  

--       apex_mail.send (p_to          => p_email,  
--                       p_from        => c_from_email,  
--                       p_body        => l_body,  
--                       p_body_html   => l_body,  
--                       p_subj        => 'Reset account password');  

--       apex_mail.push_queue;  
--    EXCEPTION  
--       WHEN OTHERS  
--       THEN  
--          raise_application_error (-20002,  
--                                   'Issue sending reset password email.');  
--    END mail_reset_password;  


--    /**  
--    */  
--    PROCEDURE create_account (p_email        IN VARCHAR2,  
--                              p_password     IN VARCHAR2,  
--                              p_company_id   IN NUMBER)  
--    IS  
--       l_message             VARCHAR2 (4000);  
--       l_password            RAW (64);  
--       l_user_id             NUMBER;  
--       l_user_role_id        NUMBER;  
--       l_application_id      VARCHAR2 (100);  
--       l_verification_code   VARCHAR2 (20);  
--    BEGIN  
--       apex_debug.MESSAGE (p_message => 'Begin Account Creation', p_level => 3);  
--       apex_debug.MESSAGE (p_message => 'Verify if Email exists', p_level => 3);  

--       BEGIN  
--          SELECT password  
--            INTO l_password  
--            FROM adm_users  
--           WHERE UPPER (email_address) = UPPER (p_email);  

--          l_message := l_message || 'Email address already registered.';  
--       EXCEPTION  
--          WHEN NO_DATA_FOUND  
--          THEN  
--             apex_debug.MESSAGE (  
--                p_message   => 'Email doesn''t exist yet - Please Proceed',  
--                p_level     => 3);  
--       END;  

--       IF l_message IS NULL  
--       THEN  
--          apex_debug.MESSAGE (p_message => 'Password OK', p_level => 3);  
--          l_password :=  
--             custom_hash (p_username => p_email, p_password => p_password);  
--          apex_debug.MESSAGE (p_message => 'Insert record', p_level => 3);  

--          BEGIN  
--             SELECT role_id  
--               INTO l_user_role_id  
--               FROM APEX_APPL_ACL_ROLES  
--              WHERE     application_id = v ('APP_ID')                --p_app_id  
--                    AND role_name = 'Contributor'  
--                    AND ROWNUM = 1;  
--          EXCEPTION  
--             WHEN OTHERS  
--             THEN  
--                NULL;  
--          END;  


--          apex_acl.add_user_role (p_application_id   => p_company_id,  
--                                  p_user_name        => p_email,  
--                                  p_role_id          => l_user_role_id);  



--          INSERT INTO adm_users (email_address,  
--                                 password,  
--                                 verification_code,  
--                                 company_id)  
--               VALUES (p_email,  
--                       l_password,  
--                       l_verification_code,  
--                       p_company_id)  
--            RETURNING USER_ID  
--                 INTO l_user_id;  
--       ELSE  
--          raise_application_error (-20001, l_message);  
--       END IF;  

--       ---apex_authentication.post_login(p_username => p_email, p_password => p_password);  

--       -- no activation email  

--       apex_debug.MESSAGE (p_message => 'End create_site_account', p_level => 3);  
--    END create_account;  

--    PROCEDURE create_applicant_account (p_email        IN     VARCHAR2,  
--                                  p_password     IN     VARCHAR2,  
--                                  p_first_name   IN     VARCHAR2,  
--                                  p_last_name   IN     VARCHAR2,  
--                                  p_company_id   IN     NUMBER,  
--                                  p_user_id         OUT NUMBER) is  
--      l_message             VARCHAR2 (4000);  
--       l_password            RAW (64);  
--       l_user_id             NUMBER;  
--       l_user_role_id        NUMBER;  
--       l_application_id      VARCHAR2 (100);  
--       l_verification_code   VARCHAR2 (20);  
--       l_email CLOB;
--       l_email_body          CLOB;        
--       l_email_id            VARCHAR2 (200);
--    BEGIN  
--       apex_debug.MESSAGE (p_message => 'Begin Account Creation', p_level => 3);  
--       apex_debug.MESSAGE (p_message => 'Verify if Email exists', p_level => 3);  

--       BEGIN  
--          SELECT password  
--            INTO l_password  
--            FROM hum_applicant_users  
--           WHERE UPPER (email_address) = UPPER (p_email)  
--           and company_id = p_company_id;  

--          l_message := l_message || 'Email address already registered.';  
--       EXCEPTION  
--          WHEN NO_DATA_FOUND  
--          THEN  
--             apex_debug.MESSAGE (  
--                p_message   => 'Email doesn''t exist yet - Please Proceed',  
--                p_level     => 3);  
--       END;  

--       IF l_message IS NULL  
--       THEN  
--          apex_debug.MESSAGE (p_message => 'Password OK', p_level => 3);  
--          l_password :=  
--             custom_hash (p_username => p_email, p_password => p_password);  
--          apex_debug.MESSAGE (p_message => 'Insert record', p_level => 3);  

--          BEGIN  
--             SELECT role_id  
--               INTO l_user_role_id  
--               FROM APEX_APPL_ACL_ROLES  
--              WHERE     application_id = v ('APP_ID')                --p_app_id  
--                    AND role_name = 'Contributor'  
--                    AND ROWNUM = 1;  
--          EXCEPTION  
--             WHEN OTHERS  
--             THEN  
--                l_user_role_id := 1;  
--          END;  


--          /* apex_acl.add_user_role (p_application_id   => p_company_id,  
--                                    p_user_name        => p_email,  
--                                    p_role_id          => l_user_role_id);*/  



--          INSERT INTO hum_applicant_users (email_address,  
--                                 password,  
--                                 verification_code,  
--                                 company_id,  
--                                 first_name,  
--                                 last_name)  
--               VALUES (p_email,  
--                       p_password,  
--                       l_verification_code,  
--                       p_company_id,  
--                       p_first_name,  
--                       p_last_name)  
--            RETURNING USER_ID  
--                 INTO l_user_id;  
--       ELSE  
--          raise_application_error (-20001, l_message);  
--       END IF;  

--       p_user_id := l_user_id;  

--       ---apex_authentication.post_login(p_username => p_email, p_password => p_password);  

--       -- no activation email  

--       l_email := '<!DOCTYPE html>
-- <html lang="en">
-- <head>
--   <meta charset="UTF-8">
--   <meta name="viewport" content="width=device-width, initial-scale=1.0">
--   <title>Create New Applicant</title>
--   <style>
--     body {
--       font-family: ''Arial'', sans-serif;
--       margin: 0;
--       padding: 0;
--       background-color: #f4f4f4;
--     }

--     .container {
--       max-width: 600px;
--       margin: 20px auto;
--       background-color: #ffffff;
--       padding: 20px;
--       border-radius: 5px;
--       box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
--     }

--     h1 {
--       color: #333333;
--     }

--     p {
--       color: #666666;
--     }


--   </style>
-- </head>
-- <body>
--   <div class="container">
--     <h1>Create New Applicant</h1>
--     <p>Hello #APPLICANT_NAME#,</p>
--     <p>We are pleased to inform you that a new applicant has been added to the system. Below are the details:</p>

--     <!-- Applicant Details Section (Replace with actual details) -->
--     <ul>
--       <li><strong>Name:</strong> #USERNAME#</li>
--       <li><strong>Email:</strong> #PASSWORD#</li>
--       <!-- Add more details as needed -->
--     </ul>



--     <p>If you have any questions or concerns, please feel free to contact us. Thank you for your attention.</p>

--     <p>Best regards,<br>[Your Company Name]</p>
--   </div>
-- </body>
-- </html>';

--     l_email := REPLACE(l_email,'#USERNAME#',p_email);
--     l_email := REPLACE(l_email,'#PASSWORD#',p_password);
--     l_email := REPLACE(l_email,'#APPLICANT_NAME#',p_first_name || ' ' || p_last_name || ',');


--       --
--           SELECT    'From: '  
--              || 'No Reply'  
--              || ' <'  
--              || util_email_correspondence_pkg.get_email_sender  
--              || '>   
-- To: '  
--              || p_first_name || ' ' || p_last_name 
--              || ' <'  
--              || p_email  
--              || '>   
-- Bcc: '  
--              || '  
-- Subject: CiBS HR Applicant Account Creation 
-- Content-Type: text/html; charset:utf-8 '  
--              || '    

-- '  
--              || l_email  
--         INTO l_email_body  
--         FROM DUAL;  

--        ----send email  
--       util_email_correspondence_pkg.send_email_p (p_email      => l_email_body,  
--                                                   p_email_id   => l_email_id); 

--       apex_debug.MESSAGE (p_message => 'End create_site_account', p_level => 3);  
--    END create_applicant_account;  

--    PROCEDURE create_account_ret (p_email        IN     VARCHAR2,  
--                                  p_password     IN     VARCHAR2,  
--                                  p_company_id   IN     NUMBER,  
--                                  p_user_id         OUT NUMBER)  
--    IS  
--       l_message             VARCHAR2 (4000);  
--       l_password            RAW (64);  
--       l_user_id             NUMBER;  
--       l_user_role_id        NUMBER;  
--       l_application_id      VARCHAR2 (100);  
--       l_verification_code   VARCHAR2 (20);  
--    BEGIN  
--       apex_debug.MESSAGE (p_message => 'Begin Account Creation', p_level => 3);  
--       apex_debug.MESSAGE (p_message => 'Verify if Email exists', p_level => 3);  

--       BEGIN  
--          SELECT password  
--            INTO l_password  
--            FROM adm_users  
--           WHERE UPPER (email_address) = UPPER (p_email);  

--          l_message := l_message || 'Email address already registered.';  
--       EXCEPTION  
--          WHEN NO_DATA_FOUND  
--          THEN  
--             apex_debug.MESSAGE (  
--                p_message   => 'Email doesn''t exist yet - Please Proceed',  
--                p_level     => 3);  
--       END;  

--       IF l_message IS NULL  
--       THEN  
--          apex_debug.MESSAGE (p_message => 'Password OK', p_level => 3);  
--          l_password :=  
--             custom_hash (p_username => p_email, p_password => p_password);  
--          apex_debug.MESSAGE (p_message => 'Insert record', p_level => 3);  

--          BEGIN  
--             SELECT role_id  
--               INTO l_user_role_id  
--               FROM APEX_APPL_ACL_ROLES  
--              WHERE     application_id = v ('APP_ID')                --p_app_id  
--                    AND role_name = 'Contributor'  
--                    AND ROWNUM = 1;  
--          EXCEPTION  
--             WHEN OTHERS  
--             THEN  
--                l_user_role_id := 1;  
--          END;  


--          /* apex_acl.add_user_role (p_application_id   => p_company_id,  
--                                    p_user_name        => p_email,  
--                                    p_role_id          => l_user_role_id);*/  



--          INSERT INTO adm_users (email_address,  
--                                 password,  
--                                 verification_code,  
--                                 company_id,  
--                                 first_name,  
--                                 last_name)  
--               VALUES (p_email,  
--                       p_password,  
--                       l_verification_code,  
--                       p_company_id,  
--                       ' - ',  
--                       ' - ')  
--            RETURNING USER_ID  
--                 INTO l_user_id;  
--       ELSE  
--          raise_application_error (-20001, l_message);  
--       END IF;  

--       p_user_id := l_user_id;  

--       ---apex_authentication.post_login(p_username => p_email, p_password => p_password);  

--       -- no activation email  

--       apex_debug.MESSAGE (p_message => 'End create_site_account', p_level => 3);  
--    END create_account_ret;  

--    PROCEDURE create_onboarding_account (p_email          IN     VARCHAR2,  
--                                         p_password       IN     VARCHAR2,  
--                                         p_job_offer_id   IN     VARCHAR2,  
--                                         p_notification   IN     CLOB,  
--                                         p_company_id     IN     NUMBER,  
--                                         p_user_id           OUT NUMBER)  
--    IS  
--       l_message             VARCHAR2 (4000);  
--       l_password            RAW (64);  
--       l_user_id             NUMBER;  
--       l_user_role_id        NUMBER;  
--       l_application_id      VARCHAR2 (100);  
--       l_verification_code   VARCHAR2 (20);  
--       l_first_name          VARCHAR2 (100);  
--       l_last_name           VARCHAR2 (100);  
--    BEGIN  
--       apex_debug.MESSAGE (p_message => 'Begin Account Creation', p_level => 3);  
--       apex_debug.MESSAGE (p_message => 'Verify if Email exists', p_level => 3);  

--       BEGIN  
--          SELECT password, user_id, verification_code,first_name,last_name  
--            INTO l_password, l_user_id, l_verification_code,l_first_name,l_last_name  
--            FROM hum_onboarding_users  
--           WHERE UPPER (email_address) = UPPER (p_email);  

--          l_message := l_message || 'Email address already registered.';  
--          p_user_id := l_user_id;  
--       EXCEPTION  
--          WHEN NO_DATA_FOUND  
--          THEN  
--             apex_debug.MESSAGE (  
--                p_message   => 'Email doesn''t exist yet - Please Proceed',  
--                p_level     => 3);  
--       END;  

--       IF l_message IS NULL  
--       THEN  
--          apex_debug.MESSAGE (p_message => 'Password OK', p_level => 3);  
--          l_password :=  
--             custom_hash (p_username => p_email, p_password => p_password);  
--          apex_debug.MESSAGE (p_message => 'Insert record', p_level => 3);  

--          BEGIN  
--             SELECT role_id  
--               INTO l_user_role_id  
--               FROM APEX_APPL_ACL_ROLES  
--              WHERE     application_id = v ('APP_ID')                --p_app_id  
--                    AND role_name = 'Contributor'  
--                    AND ROWNUM = 1;  
--          EXCEPTION  
--             WHEN OTHERS  
--             THEN  
--                l_user_role_id := 1;  
--          END;  

--          BEGIN  
--             SELECT candidate_first_name, candidate_last_name  
--               INTO l_first_name, l_last_name  
--               FROM hum_job_applications a, hum_job_offers b  
--              WHERE     UPPER (application_status) = 'HIRED'  
--                    AND a.job_application_id = b.job_application_id  
--                    AND b.job_offer_id = p_job_offer_id  
--                    AND a.email_address = p_email;  

--             l_verification_code := DBMS_RANDOM.string ('X', 7);  

--             INSERT INTO hum_onboarding_users (email_address,  
--                                               password,  
--                                               verification_code,  
--                                               company_id,  
--                                               first_name,  
--                                               last_name)  
--                  VALUES (p_email,  
--                          p_password,  
--                          l_verification_code,  
--                          p_company_id,  
--                          l_first_name,  
--                          l_last_name)  
--               RETURNING USER_ID  
--                    INTO l_user_id;  
--          EXCEPTION  
--             WHEN OTHERS  
--             THEN  
--                NULL;  
--          END;  
--       ELSE  
--          NULL;                  --raise_application_error (-20001, l_message);  
--       END IF;  





--       -- activation email  
--       send_onboarding_email (  
--          p_company_id          => p_company_id,  
--          p_full_name           => l_first_name || ' ' || l_last_name,  
--          p_notification        => p_notification,  
--          p_verification_code   => l_verification_code,  
--          p_email_address       => p_email);  

--           p_user_id := l_user_id;  

--       apex_debug.MESSAGE (p_message => 'End create_site_account', p_level => 3);  
--    END create_onboarding_account;  


--    FUNCTION custom_authenticate (p_username   IN VARCHAR2,  
--                                  p_password   IN VARCHAR2)  
--       RETURN BOOLEAN  
--    IS  
--       l_password           VARCHAR2 (100);  
--       l_stored_password    VARCHAR2 (100);  
--       l_boolean            BOOLEAN;  
--       l_email_address      VARCHAR2 (100);  
--       v_sqlerrm            VARCHAR2 (2000);  
--       l_user_activity_id   NUMBER;  
--       l_company_id         NUMBER;  
--       l_user_id            NUMBER;  
--       l_employee_id        NUMBER;  
--    BEGIN  
--       -- First, check to see if the user is in the user table and look up their password  
--       BEGIN  
--          SELECT a.password,  
--                 TRIM (a.email_address),  
--                 a.user_id,  
--                 a.company_id  
--            INTO l_stored_password,  
--                 l_email_address,  
--                 l_user_id,  
--                 l_company_id  
--            FROM adm_users a  
--           WHERE TRIM (UPPER (a.email_address)) = TRIM (UPPER (p_username))  
--           and TRIM (UPPER (a.email_address)) in (select TRIM (UPPER (b.email_address)) from adm_companies b);  
--       EXCEPTION  
--          WHEN OTHERS  
--          THEN  
--             v_sqlerrm := SQLERRM;  
--       END;  



--       -- hash the password the person entered  
--       l_password := custom_hash (l_email_address, p_password);  



--       -- Finally, we compare them to see if they are the same and return either TRUE or FALSE  
--       IF l_password = l_stored_password  
--       THEN  
--          -- if v('APP_ID') = 100 then  
--          begin  
--          util_time_management_pkg.generate_attendance (  
--             p_company_id   => l_company_id);  
--          COMMIT;  
--          exception   
--          when others then  
--          null;  
--          end;  

--          --  end if;  
--          -----log activities  
--          BEGIN  
--             ----check if already populated  

--             l_user_activity_id :=  
--                adm_user_activities_api.get_pk_by_unique_cols (  
--                   p_EMAIL_ADDRESS   => p_username);  

--             IF l_user_activity_id IS NULL  
--             THEN  
--                adm_user_activities_api.create_or_update_row (  
--                   p_user_activity_id   => l_user_activity_id,  
--                   p_email_address      => p_username,  
--                   p_login_datetime     => SYSDATE,  
--                   p_logout_datetime    => NULL,  
--                   p_show_sample_data   => 'Y',  
--                   p_user_role          => 'N',  
--                   p_latitude           => NULL,  
--                   p_longitude          => NULL,  
--                   p_company_id         => NULL,  
--                   p_created_by         => v ('APP_USER'),  
--                   p_creation_date      => SYSDATE,  
--                   p_last_updated_by    => v ('APP_USER'),  
--                   p_last_update_date   => SYSDATE);  

--                SELECT company_id  
--                  INTO l_company_id  
--                  FROM adm_users  
--                 WHERE UPPER (email_address) = p_username;  

--               /* hum_data_management_pkg.load_sample_data (  
--                   p_company_id   => l_company_id);  */
--                adm_user_activities_api.set_show_sample_data (  
--                   adm_user_activities_api.get_pk_by_unique_cols (  
--                      p_EMAIL_ADDRESS   => p_username),  
--                   'Y');  
--             ELSE  
--                adm_user_activities_api.set_login_datetime (  
--                   p_user_activity_id   => l_user_activity_id,  
--                   p_login_datetime     => SYSDATE);  
--                adm_user_activities_api.set_latitude (  
--                   p_user_activity_id   => l_user_activity_id,  
--                   p_latitude           => NULL);  
--                adm_user_activities_api.set_longitude (  
--                   p_user_activity_id   => l_user_activity_id,  
--                   p_longitude          => NULL);  
--             END IF;  

--             -------Get Missed Punches for registered employees  
--             BEGIN  
--                SELECT b.employee_id  
--                  INTO l_employee_id  
--                  FROM hum_people a, hum_employees b  
--                 WHERE     a.user_id = l_user_id  
--                       AND a.company_id = l_company_id  
--                       AND a.person_id = b.person_id  
--                       AND b.date_of_resignation IS NULL;  


--                util_time_management_pkg.generate_missed_punches (  
--                   p_employee_id   => l_employee_id,  
--                   p_company_id    => l_company_id);  
--                COMMIT;  
--             EXCEPTION  
--                WHEN OTHERS  
--                THEN  
--                   --------do not process  
--                   NULL;  
--             END;  
--             EXCEPTION  
--                WHEN OTHERS  
--                THEN  
--                   --------do not process  
--                   NULL;  
--          END;  

--          RETURN TRUE;  

--       ELSE  
--          RETURN FALSE;  
--       END IF;  
--    EXCEPTION  
--       WHEN NO_DATA_FOUND  
--       THEN  
--          RETURN FALSE;  
--       WHEN OTHERS  
--       THEN  
--          RETURN FALSE;  
--    END custom_authenticate;  

-- FUNCTION custom_authenticate_ess (p_username   IN VARCHAR2,  
--                                  p_password   IN VARCHAR2)  
--       RETURN BOOLEAN  
--    IS  
--       l_password           VARCHAR2 (100);  
--       l_stored_password    VARCHAR2 (100);  
--       l_boolean            BOOLEAN;  
--       l_email_address      VARCHAR2 (100);  
--       v_sqlerrm            VARCHAR2 (2000);  
--       l_user_activity_id   NUMBER;  
--       l_company_id         NUMBER;  
--       l_user_id            NUMBER;  
--       l_employee_id        NUMBER;  
--    BEGIN  
--       -- First, check to see if the user is in the user table and look up their password  
--       /*BEGIN  
--          SELECT a.password,  
--                 TRIM (a.email_address),  
--                 a.user_id,  
--                 a.company_id  
--            INTO l_stored_password,  
--                 l_email_address,  
--                 l_user_id,  
--                 l_company_id  
--            FROM adm_users a  
--           WHERE TRIM (UPPER (a.email_address)) = TRIM (UPPER (p_username))  
--           and TRIM (UPPER (a.email_address)) in (select TRIM (UPPER (b.employee_email_address)) from hum_employee_list_hv b);  
--       EXCEPTION  
--          WHEN OTHERS  
--          THEN  
--             v_sqlerrm := SQLERRM;  
--       END;*/  

--      --apex_debug.MESSAGE (p_message => 'Inputted Email' || p_username, p_level => 3); 
--      --apex_debug.MESSAGE (p_message => 'Inputted Password' || p_password, p_level => 3); 

--        BEGIN  
--          SELECT a.password,  
--                 TRIM (a.email_address),  
--                 a.user_id,  
--                 a.company_id  
--            INTO l_stored_password,  
--                 l_email_address,  
--                 l_user_id,  
--                 l_company_id  
--            FROM adm_users a  
--           WHERE TRIM (UPPER (a.email_address)) = TRIM (UPPER (p_username))
--          and (TRIM (UPPER (a.email_address)) in (select TRIM (UPPER (b.email_address)) from adm_companies b) 
--          or TRIM (UPPER (a.email_address)) in (select TRIM (UPPER (b.employee_email_address)) from hum_employee_list_hv b) --10/08/2023
--          or a.company_id in (select company_id from adm_companies));
--       --  and TRIM (UPPER (a.email_address)) in (select TRIM (UPPER (b.email_address)) from adm_companies b);  -- to check 16/6/2023
--       EXCEPTION  
--          WHEN OTHERS  
--          THEN  
--             v_sqlerrm := SQLERRM;  
--       END;

--      --apex_debug.MESSAGE (p_message => 'Db Stored Email' || l_email_address, p_level => 3); 
--      --apex_debug.MESSAGE (p_message => 'Db Stored Encrypted Password' || l_stored_password, p_level => 3);
--      logger.log('Stored Password => '||l_stored_password);

--       -- hash the password the person entered  
--       l_password := custom_hash (l_email_address, p_password);  
--       logger.log('Computed Password => '||l_password);
--       --apex_debug.MESSAGE (p_message => 'Newly Encrypted Password At Login' || l_password, p_level => 3);

--       -- Finally, we compare them to see if they are the same and return either TRUE or FALSE  
--       IF l_password = l_stored_password  
--       THEN  
--          -- if v('APP_ID') = 100 then  
--          util_time_management_pkg.generate_attendance (  
--             p_company_id   => l_company_id);  
--          COMMIT;  

--          --  end if;  
--          -----log activities  
--          BEGIN  
--             ----check if already populated  

--             l_user_activity_id :=  
--                adm_user_activities_api.get_pk_by_unique_cols (  
--                   p_EMAIL_ADDRESS   => p_username);  

--             IF l_user_activity_id IS NULL  
--             THEN  
--                adm_user_activities_api.create_or_update_row (  
--                   p_user_activity_id   => l_user_activity_id,  
--                   p_email_address      => p_username,  
--                   p_login_datetime     => SYSDATE,  
--                   p_logout_datetime    => NULL,  
--                   p_show_sample_data   => 'Y',  
--                   p_user_role          => 'N',  
--                   p_latitude           => NULL,  
--                   p_longitude          => NULL,  
--                   p_company_id         => NULL,  
--                   p_created_by         => v ('APP_USER'),  
--                   p_creation_date      => SYSDATE,  
--                   p_last_updated_by    => v ('APP_USER'),  
--                   p_last_update_date   => SYSDATE);  

--                SELECT company_id  
--                  INTO l_company_id  
--                  FROM adm_users  
--                 WHERE UPPER (email_address) = p_username;  

--                /*hum_data_management_pkg.load_sample_data (  
--                   p_company_id   => l_company_id);  */
--                adm_user_activities_api.set_show_sample_data (  
--                   adm_user_activities_api.get_pk_by_unique_cols (  
--                      p_EMAIL_ADDRESS   => p_username),  
--                   'Y');  
--             ELSE  
--                adm_user_activities_api.set_login_datetime (  
--                   p_user_activity_id   => l_user_activity_id,  
--                   p_login_datetime     => SYSDATE);  
--                adm_user_activities_api.set_latitude (  
--                   p_user_activity_id   => l_user_activity_id,  
--                   p_latitude           => NULL);  
--                adm_user_activities_api.set_longitude (  
--                   p_user_activity_id   => l_user_activity_id,  
--                   p_longitude          => NULL);  
--             END IF;  

--             -------Get Missed Punches for registered employees  
--             BEGIN  
--                SELECT b.employee_id  
--                  INTO l_employee_id  
--                  FROM hum_people a, hum_employees b  
--                 WHERE     a.user_id = l_user_id  
--                       AND a.company_id = l_company_id  
--                       AND a.person_id = b.person_id  
--                       AND b.date_of_resignation IS NULL;  


--                util_time_management_pkg.generate_missed_punches (  
--                   p_employee_id   => l_employee_id,  
--                   p_company_id    => l_company_id);  
--                COMMIT;  
--             EXCEPTION  
--                WHEN OTHERS  
--                THEN  
--                   --------do not process  
--                   NULL;  
--             END;  
--          END;  

--          RETURN TRUE;  
--       ELSE  
--          RETURN FALSE;  
--       END IF;  
--    EXCEPTION  
--       WHEN NO_DATA_FOUND  
--       THEN  
--          RETURN FALSE;  
--       WHEN OTHERS  
--       THEN  
--          RETURN FALSE;  
--    END custom_authenticate_ess;  

-- FUNCTION custom_onboarding_authenticate (p_username   IN VARCHAR2,  
--                                  p_password   IN VARCHAR2)  
--       RETURN BOOLEAN  
--    IS  
--       l_password           VARCHAR2 (100);  
--       l_stored_password    VARCHAR2 (100);  
--       l_boolean            BOOLEAN;  
--       l_email_address      VARCHAR2 (100);  
--       v_sqlerrm            VARCHAR2 (2000);  
--       l_user_activity_id   NUMBER;  
--       l_company_id         NUMBER;  
--       l_user_id            NUMBER;  
--       l_employee_id        NUMBER;  
--    BEGIN  
--       -- First, check to see if the user is in the user table and look up their password  
--       BEGIN  
--          SELECT password,  
--                 TRIM (email_address),  
--                 user_id,  
--                 company_id  
--            INTO l_stored_password,  
--                 l_email_address,  
--                 l_user_id,  
--                 l_company_id  
--            FROM hum_onboarding_users  
--           WHERE TRIM (UPPER (email_address)) = TRIM (UPPER (p_username));  
--       EXCEPTION  
--          WHEN OTHERS  
--          THEN  
--             v_sqlerrm := SQLERRM;  
--       END;  



--       -- hash the password the person entered  
--       l_password := custom_hash (l_email_address, p_password);  



--       -- Finally, we compare them to see if they are the same and return either TRUE or FALSE  
--       IF l_password = l_stored_password  
--       THEN  
--          RETURN TRUE;  
--       ELSE  
--          RETURN FALSE;  
--       END IF;  
--    EXCEPTION  
--       WHEN NO_DATA_FOUND  
--       THEN  
--          RETURN FALSE;  
--       WHEN OTHERS  
--       THEN  
--          RETURN FALSE;  
--    END custom_onboarding_authenticate;  

--    FUNCTION custom_applicant_authenticate (p_username   IN VARCHAR2,  
--                                  p_password   IN VARCHAR2)  
--       RETURN BOOLEAN  
--       IS  
--       l_password           VARCHAR2 (100);  
--       l_stored_password    VARCHAR2 (100);  
--       l_boolean            BOOLEAN;  
--       l_email_address      VARCHAR2 (100);  
--       v_sqlerrm            VARCHAR2 (2000);  
--       l_user_activity_id   NUMBER;  
--       l_company_id         NUMBER;  
--       l_user_id            NUMBER;  
--       l_employee_id        NUMBER;  
--    BEGIN  
--       -- First, check to see if the user is in the user table and look up their password  
--       BEGIN  
--          SELECT password,  
--                 TRIM (email_address),  
--                 user_id,  
--                 company_id  
--            INTO l_stored_password,  
--                 l_email_address,  
--                 l_user_id,  
--                 l_company_id  
--            FROM hum_applicant_users  
--           WHERE TRIM (UPPER (email_address)) = TRIM (UPPER (p_username))  
--           AND rownum=1;  
--       EXCEPTION  
--          WHEN OTHERS  
--          THEN  
--             v_sqlerrm := SQLERRM;  
--       END;  



--       -- hash the password the person entered  
--       l_password := custom_hash (l_email_address, p_password);  



--       -- Finally, we compare them to see if they are the same and return either TRUE or FALSE  
--       IF l_password = l_stored_password  
--       THEN  
--          RETURN TRUE;  
--       ELSE  
--          RETURN FALSE;  
--       END IF;  
--    EXCEPTION  
--       WHEN NO_DATA_FOUND  
--       THEN  
--          RETURN FALSE;  
--       WHEN OTHERS  
--       THEN  
--          RETURN FALSE;  
--    END custom_applicant_authenticate;  
--    /**  
--       */  

--    PROCEDURE post_authenticate (p_username    IN     VARCHAR2,  
--                                 out_page_id      OUT NUMBER)  
--    IS  
--       l_id                      NUMBER;  
--       l_first_name              VARCHAR2 (100);  
--       l_password                VARCHAR2 (200);  
--       l_verification_password   VARCHAR2 (200);  
--    BEGIN  
--       SELECT USER_ID,  
--              password,  
--              adm_auth_pkg.custom_hash (email_address, verification_code)  
--         INTO l_id, l_password, l_verification_password  
--         FROM adm_users  
--        WHERE UPPER (email_address) = UPPER (p_username);  



--       IF l_password = l_verification_password  
--       THEN  
--          out_page_id := 1;  
--       ELSE  
--          out_page_id := 0;  
--       END IF;  
--    EXCEPTION  
--       WHEN OTHERS  
--       THEN  
--          out_page_id := 1;  
--    END post_authenticate;  


--    /**  
--       */  

--    PROCEDURE request_reset_password (p_email IN VARCHAR2)  
--    IS  
--       l_id                  NUMBER;  
--       l_verification_code   VARCHAR2 (100);  
--       l_url                 VARCHAR2 (200);  
--       l_company_id          NUMBER;  
--       l_company_name        VARCHAR2 (200);  
--       l_email               CLOB;  
--       l_email_body          CLOB;  
--       l_full_name           VARCHAR2 (200);  
--       l_email_id            VARCHAR2 (200);  
--    BEGIN  
--       -- First, check to see if the user is in the user table  
--       SELECT USER_ID, company_id, first_name || ' ' || last_name  
--         INTO l_id, l_company_id, l_full_name  
--         FROM adm_users  
--        WHERE UPPER (email_address) = UPPER (p_email);  

--       DBMS_RANDOM.initialize (TO_CHAR (SYSDATE, 'YYMMDDDSS'));  
--       l_verification_code := DBMS_RANDOM.string ('A', 7);  

--       /*  l_url :=  
--            APEX_UTIL.prepare_url (  
--               p_url             =>    c_hostname  
--                                    || 'f?p='  
--                                    || v ('APP_ID')  
--                                    || ':RESET_PWD:0::::P9999_ID,P9999_VC:'  
--                                    || l_id  
--                                    || ','  
--                                    || l_verification_code,  
--               p_checksum_type   => 1);*/  

--       UPDATE adm_users  
--          SET verification_code = l_verification_code,  
--              password =  
--                 custom_hash (p_username   => p_email,  
--                              p_password   => l_verification_code)  
--        WHERE USER_ID = l_id;  

--       COMMIT;  

--       ---   mail_reset_password (p_email => p_email, p_url => l_url);  


--       BEGIN  
--          SELECT company_name  
--            INTO l_company_name  
--            FROM adm_companies  
--           WHERE company_id = l_company_id;  
--       EXCEPTION  
--          WHEN OTHERS  
--          THEN  
--             l_company_name := 'Unregistered Company';  
--       END;  

--       l_email :=  
--             '  
-- <head>  
--    <script src="https://code.iconify.design/1/1.0.7/iconify.min.js"></script>  
--    <title></title>  
--    <meta http-equiv="X-UA-Compatible" content="IE=edge">  
--    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">  
--    <style type="text/css">  
--   *{  
-- /*transition*/  
-- -webkit-transition:.25s ease-in-out;  
--    -moz-transition:.25s ease-in-out;  
--      -o-transition:.25s ease-in-out;  
--         transition:.25s ease-in-out;  
-- font-family:helvetica neue,helvetica,arial,sans-serif;  
-- font-size:18px;  
-- line-height:25px;  
-- box-sizing:border-box;  
-- margin:0;  
-- }  


-- #card {  
--   position: relative;  
--   top: 10px;  
--   width: 620px;  
--   display: block;  
--   margin: auto;  
--   text-align: left;  
--   font-family: Segoe UI,Frutiger,Frutiger Linotype,Dejavu Sans,Helvetica Neue,Arial,sans-serif;  
-- }  
-- #cardlower {  
--   position: relative;  
--   top: 20px;  
--   width: 320px;  
--   display: block;  
--   margin: auto;  
--   text-align: center;  
--   font-family: '' Source Sans Pro '', sans-serif;  
-- }  

-- #upper-side {  
--   padding: 1em;  
--   /***background-color: #8BC34A;**/  
--   background-color: #ffa500;  
--   display: block;  
--   color: #ffffff;/*#dee8e7;*//*#fff;*/  
--   border-top-right-radius: 8px;  
--   border-top-left-radius: 8px;  
-- }  

-- #checkmark {  
--   font-weight: lighter;  
--   fill: #fff;  
--   margin: -3.5em auto auto 20px;  
-- }  

-- #status {  
--   font-weight: lighter;  
--   text-transform: uppercase;  
--   letter-spacing: 2px;  
--   font-size: 1em;  
--   margin-top: -.2em;  
--   margin-bottom: 0;  
-- }  

-- #lower-side {  
--   padding: 2em 2em 5em 2em;  
--   background: #fff;  
--   display: block;  
--   border-bottom-right-radius: 8px;  
--   border-bottom-left-radius: 8px;  
-- }  

-- #message {  
--   margin-top: -.5em;  
--   color: #757575;  
--   letter-spacing: 1px;  
-- }  

-- @import url("https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css");  
-- ul {  
--   width: 100%;  
--   text-align: center;  
--   margin: 0;  
--   padding: 0;  
--   position: absolute;  
--   top: 50%;  
--   transform: translateY(-50%);  
-- }  

-- li {  
--   display: inline-block;  
--   margin: 10px;  
-- }  

-- .download {  
--   width: 200px;  
--   height: 75px;  
--   background: black;  
--   float: left;  
--   border-radius: 5px;  
--   position: relative;  
--   color: #fff;  
--   cursor: pointer;  
--   border: 1px solid #fff;  
-- }  

-- .download > .fa {  
--   color: #fff;  
--   position: absolute;  
--   top: 50%;  
--   left: 15px;  
--   transform: translateY(-50%);  
-- }  

-- .df,  
-- .dfn {  
--   position: absolute;  
--   left: 70px;  
-- }  

-- .df {  
--   top: 20px;  
--   font-size: .68em;  
-- }  

-- .dfn {  
--   top: 33px;  
--   font-size: 1.08em;  
-- }  

-- .download:hover {  
--   -webkit-filter: invert(100%);  
--   filter: invert(100%);  
-- }  

-- .t-Alert--wizard,  
-- .t-Alert--horizontal {  
--   border-radius: 2px;  
--   border-color: rgba(0, 0, 0, 0.1);  
-- }  
-- .t-Alert--wizard .t-Alert-icon,  
-- .t-Alert--horizontal .t-Alert-icon {  
--   border-top-left-radius: 2px;  
--   border-bottom-left-radius: 2px;  
-- }  
-- .t-Alert--colorBG.t-Alert--warning,  
-- .t-Alert--colorBG.t-Alert--yellow {  
--   background-color: #fef7e0;  
--   color: #000000;  
-- }  
-- .t-Alert--colorBG.t-Alert--success {  
--   background-color: #f4fcf3;  
--   color: #000000;  
-- }  
-- .t-Alert--colorBG.t-Alert--danger,  
-- .t-Alert--colorBG.t-Alert--red {  
--   background-color: #fff8f7;  
--   color: #000000;  
-- }  
-- .t-Alert--colorBG.t-Alert--info {  
--   background-color: #f9fcff;  
--   color: #000000;  
-- }  
-- .t-Alert-icon .t-Icon {  
--   color: #FFF;  
-- }  
-- .t-Alert--warning .t-Alert-icon .t-Icon,  
-- .t-Alert--yellow .t-Alert-icon .t-Icon {  
--   color: #FBCE4A;  
-- }  
-- .t-Alert--warning.t-Alert--horizontal .t-Alert-icon,  
-- .t-Alert--yellow.t-Alert--horizontal .t-Alert-icon {  
--   background-color: rgba(251, 206, 74, 0.15);  
-- }  
-- .t-Alert--success .t-Alert-icon .t-Icon {  
--   color: #3BAA2C;  
-- }  
-- .t-Alert--success.t-Alert--horizontal .t-Alert-icon {  
--   background-color: rgba(59, 170, 44, 0.15);  
-- }  
-- .t-Alert--info .t-Alert-icon .t-Icon {  
--   color: #0076df;  
-- }  
-- .t-Alert--info.t-Alert--horizontal .t-Alert-icon {  
--   background-color: rgba(0, 118, 223, 0.15);  
-- }  
-- .t-Alert--danger .t-Alert-icon .t-Icon,  
-- .t-Alert--red .t-Alert-icon .t-Icon {  
--   color: #f44336;  
-- }  
-- .t-Alert--danger.t-Alert--horizontal .t-Alert-icon,  
-- .t-Alert--red.t-Alert--horizontal .t-Alert-icon {  
--   background-color: rgba(244, 67, 54, 0.15);  
-- }  
-- .t-Alert--wizard .t-Alert-inset {  
--   border-radius: 2px;  
-- }  
-- .t-Alert--horizontal,  
-- .t-Alert--wizard {  
--   background-color: #ffffff;  
--   color: #262626;  
-- }  
-- .t-Alert--page {  
--   box-shadow: 0 0 0 0.1rem rgba(0, 0, 0, 0.1) inset, 0 3px 9px -2px rgba(0, 0, 0, 0.1);  
-- }  
-- .t-Alert--page .a-Notification-item:before {  
--   background-color: rgba(0, 0, 0, 0.5);  
-- }  
-- .t-Alert--page.t-Alert--success {  
--   background-color: rgba(59, 170, 44, 0.9);  
--   color: #FFF;  
-- }  
-- .t-Alert--page.t-Alert--success .t-Alert-icon {  
--   background-color: transparent;  
--   color: #FFF;  
-- }  
-- .t-Alert--page.t-Alert--success .t-Alert-icon .t-Icon {  
--   color: inherit;  
-- }  
-- .t-Alert--page.t-Alert--success .t-Button--closeAlert {  
--   color: #FFF !important;  
-- }  
-- .t-Alert--page.t-Alert--warning {  
--   background-color: #FBCE4A;  
--   color: #443302;  
-- }  
-- .t-Alert--page.t-Alert--warning .t-Alert-icon .t-Icon {  
--   color: inherit;  
-- }  
-- .t-Alert--page.t-Alert--warning a {  
--   color: inherit;  
--   text-decoration: underline;  
-- }  
-- .t-Alert--page.t-Alert--warning .a-Notification-item:before {  
--   background-color: currentColor;  
-- }  
--  </style>                
--               <div id="card" class="animated fadeIn">  
--   <div id="upper-side">  
--       <h3 id="status"><center>PASSWORD RESET</center>  
--     </h3>  
--   </div>  
-- <div class="t-Alert t-Alert--horizontal t-Alert--colorBG t-Alert--defaultIcons t-Alert--#ALERT_TYPE#" role="alert" style="background-color:#ffffff;">  
--   <div class="t-Alert-wrap">  
--     <div class="t-Alert-icon">  
--       <span class="t-Icon"></span>  
--     </div>  
--     <div class="t-Alert-content">  
--       <div class="t-Alert-header">  
--        <h4 class="t-Alert-title"><br/>Dear '  
--          || INITCAP (l_full_name)  
--          || ',</h4><br/>  
--         <h3 class="t-Alert-title">'  
--          || '<p>You have requested a password reset.  
--           <br/><br/>  
--              Please find details below:'  
--          || '</h3>  
--       </div>  
--       <div class="t-Alert-body">  
--       </div>  
--     </div>  
--   </div>  
-- </div>  
--         <table>  
--   <tr>  
--     <td><left>Email Address:</left></td>  
--     <td>'  
--          || p_email  
--          || '</td>  
--   </tr>  
--   <tr>  
--     <td><left><b>Temporary Password:</b></left></td>  
--     <td><b>'  
--          || l_verification_code  
--          || '</b></td>  
--   </tr>  
-- </table>  
--     <div>  
--         </div>  
--         <br/>  
-- <p><center><img src="shorturl.at/nKL15" width="32px" height="32px" style="vertical-align:middle"><span style="display:inline-block;font-family:Segoe UI,Frutiger,Frutiger Linotype,Dejavu Sans,Helvetica Neue,Arial,sans-serif;  font-size: 14px; letter-spacing: 1.2px; color: #1e948a;">umbreHR</span>ed;|ed;<a style="font-size:10px">&#169;'  
--          || TO_CHAR (SYSDATE, 'RRRR')  
--          || '</a></center></p>  
-- </html>';  

--       /*  
--        <a href="#" target="_blank"><img src="https://drive.google.com/uc?export=viewer=1SCs2y3GGkHA0BluJEXEsAVKDtxki-7Ne" width="100px" height="30px"></a>  
--           <img src="https://drive.google.com/uc?export=viewer=1KinEj-hh8otGwgCMpXiq_G61dLH3AK0t" width="100px" height="30px">  
--           <a href="https://apex5.revion.com/ords/HUMBRE/r/ess/login_desktop?session=10865818616309" target="_blank"><img src="https://drive.google.com/uc?export=viewer=1lC-ZfxrXd81dN5s_kTIXo8r2pFoOs3tm" width="100px" height="30px"></a>  
--         */  

--       SELECT    'From: '  
--              || 'No Reply'  
--              || ' <'  
--              || util_email_correspondence_pkg.get_email_sender  
--              || '>   
-- To: '  
--              || l_full_name  
--              || ' <'  
--              || p_email  
--              || '>   
-- Bcc: '  
--              || '  
-- Subject: CiBS HR password reset  
-- Content-Type: text/html; charset:utf-8 '  
--              || '    

-- '  
--              || l_email  
--         INTO l_email_body  
--         FROM DUAL;  

--       ----send email  
--       util_email_correspondence_pkg.send_email_p (p_email      => l_email_body,  
--                                                   p_email_id   => l_email_id);  
--       DBMS_OUTPUT.put_line (l_email_id);  
--    EXCEPTION  
--       WHEN OTHERS  
--       THEN  
--          DBMS_OUTPUT.put_line (SQLERRM);  
--    END request_reset_password;  


--    /**  
--       */  

--    FUNCTION verify_reset_password (p_id                  IN NUMBER,  
--                                    p_verification_code   IN VARCHAR2)  
--       RETURN NUMBER  
--    IS  
--       l_id   NUMBER;  
--    BEGIN  
--       SELECT u.USER_ID  
--         INTO l_id  
--         FROM adm_users u  
--        WHERE     u.verification_code = 'RESET_' || p_verification_code  
--              AND u.USER_ID = p_id;  

--       RETURN l_id;  
--    EXCEPTION  
--       WHEN NO_DATA_FOUND  
--       THEN  
--          raise_application_error (-20001, 'Invalid password request url.');  
--          RETURN NULL;  
--    END verify_reset_password;  


--    /**  
--       */  

--    PROCEDURE reset_password (p_id IN NUMBER, p_password IN VARCHAR2)  
--    IS  
--       l_username          VARCHAR2 (100);  
--       l_hashed_password   VARCHAR2 (100);  
--    BEGIN  
--       SELECT email_address  
--         INTO l_username  
--         FROM adm_users  
--        WHERE USER_ID = p_id;  

--       l_hashed_password := custom_hash (l_username, p_password);  

--       UPDATE adm_users  
--          SET password = l_hashed_password, verification_code = NULL  
--        WHERE USER_ID = p_id;  
--    END reset_password;  


--    FUNCTION get_user_id (p_username IN VARCHAR2)  
--       RETURN NUMBER  
--    IS  
--       l_user_id   NUMBER;  
--    BEGIN  
--       SELECT user_id  
--         INTO l_user_id  
--         FROM adm_users a  
--        WHERE UPPER (a.email_address) = UPPER (p_username);  

--       --  
--       RETURN l_user_id;  
--    EXCEPTION  
--       WHEN NO_DATA_FOUND  
--       THEN  
--          RETURN -1;  
--    END get_user_id;  

--    PROCEDURE send_welcome_email (p_company_code     IN VARCHAR2,  
--                                  p_full_name        IN VARCHAR2,  
--                                  p_email_address    IN VARCHAR2,  
--                                  p_trial_end_date   IN DATE)  
--    IS  
--       l_email              CLOB;  
--       l_email_id           VARCHAR2 (100);  
--       l_template_content   CLOB;  
--    BEGIN  
--       SELECT    'From: CiBS HR <'  
--              || util_email_correspondence_pkg.get_email_sender  
--              || '>   
-- To: '  
--              || p_full_name  
--              || ' <'  
--              || p_email_address  
--              || '>   
-- Subject: Welcome to CiBS HR  
-- Content-Type: text/html; charset:utf-8 '  
--              || '    

-- '  
--              || REPLACE (  
--                    REPLACE (  
--                       template_content,  
--                       '[TRIAL_PERIOD_END]',  
--                       TO_CHAR (p_trial_end_date, 'Day Ddth Month, RRRR')),  
--                    '[COMPANY_CODE]',  
--                    p_company_code)  
--         INTO l_email  
--         FROM hum_templates  
--        WHERE     template_name = 'Standard Welcome Email'  
--              AND template_category = 'User Registration'  
--              AND NVL (active_flag, 'Y') = 'Y'  
--              AND ROWNUM = 1  
--              AND company_id = 0;  



--       util_email_correspondence_pkg.send_welcome_email (  
--          p_email      => l_email,  
--          p_email_id   => l_email_id);  
--    EXCEPTION  
--       WHEN OTHERS  
--       THEN  
--          DBMS_OUTPUT.put_line (SQLERRM);  
--    END;  

--    PROCEDURE send_ess_creation_email (p_company_id          IN NUMBER,  
--                                       p_full_name           IN VARCHAR2,  
--                                       p_verification_code   IN VARCHAR2,  
--                                       p_email_address       IN VARCHAR2)  
--    IS  
--       l_email              CLOB;  
--       l_email_body         CLOB;  
--       l_email_id           VARCHAR2 (100);  
--       l_template_content   CLOB;  
--       l_company_name       VARCHAR2 (200);  
--    BEGIN  
--       BEGIN  
--          SELECT company_name  
--            INTO l_company_name  
--            FROM adm_companies  
--           WHERE company_id = p_company_id;  
--       EXCEPTION  
--          WHEN OTHERS  
--          THEN  
--             l_company_name := 'Unregistered Company';  
--       END;  

--       l_email :=  
--             '  
-- <head>  
--    <script src="https://code.iconify.design/1/1.0.7/iconify.min.js"></script>  
--    <title></title>  
--    <meta http-equiv="X-UA-Compatible" content="IE=edge">  
--    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">  
--    <style type="text/css">  
--   *{  
-- /*transition*/  
-- -webkit-transition:.25s ease-in-out;  
--    -moz-transition:.25s ease-in-out;  
--      -o-transition:.25s ease-in-out;  
--         transition:.25s ease-in-out;  
-- font-family:helvetica neue,helvetica,arial,sans-serif;  
-- font-size:18px;  
-- line-height:25px;  
-- box-sizing:border-box;  
-- margin:0;  
-- }  


-- #card {  
--   position: relative;  
--   top: 10px;  
--   width: 620px;  
--   display: block;  
--   margin: auto;  
--   text-align: left;  
--   font-family: Segoe UI,Frutiger,Frutiger Linotype,Dejavu Sans,Helvetica Neue,Arial,sans-serif;  
-- }  
-- #cardlower {  
--   position: relative;  
--   top: 20px;  
--   width: 320px;  
--   display: block;  
--   margin: auto;  
--   text-align: center;  
--   font-family: '' Source Sans Pro '', sans-serif;  
-- }  

-- #upper-side {  
--   padding: 1em;  
--   /***background-color: #8BC34A;**/  
--   background-color: #1e948a;  
--   display: block;  
--   color: #ffffff;/*#dee8e7;*//*#fff;*/  
--   border-top-right-radius: 8px;  
--   border-top-left-radius: 8px;  
-- }  

-- #checkmark {  
--   font-weight: lighter;  
--   fill: #fff;  
--   margin: -3.5em auto auto 20px;  
-- }  

-- #status {  
--   font-weight: lighter;  
--   text-transform: uppercase;  
--   letter-spacing: 2px;  
--   font-size: 1em;  
--   margin-top: -.2em;  
--   margin-bottom: 0;  
-- }  

-- #lower-side {  
--   padding: 2em 2em 5em 2em;  
--   background: #fff;  
--   display: block;  
--   border-bottom-right-radius: 8px;  
--   border-bottom-left-radius: 8px;  
-- }  

-- #message {  
--   margin-top: -.5em;  
--   color: #757575;  
--   letter-spacing: 1px;  
-- }  

-- @import url("https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css");  
-- ul {  
--   width: 100%;  
--   text-align: center;  
--   margin: 0;  
--   padding: 0;  
--   position: absolute;  
--   top: 50%;  
--   transform: translateY(-50%);  
-- }  

-- li {  
--   display: inline-block;  
--   margin: 10px;  
-- }  

-- .download {  
--   width: 200px;  
--   height: 75px;  
--   background: black;  
--   float: left;  
--   border-radius: 5px;  
--   position: relative;  
--   color: #fff;  
--   cursor: pointer;  
--   border: 1px solid #fff;  
-- }  

-- .download > .fa {  
--   color: #fff;  
--   position: absolute;  
--   top: 50%;  
--   left: 15px;  
--   transform: translateY(-50%);  
-- }  

-- .df,  
-- .dfn {  
--   position: absolute;  
--   left: 70px;  
-- }  

-- .df {  
--   top: 20px;  
--   font-size: .68em;  
-- }  

-- .dfn {  
--   top: 33px;  
--   font-size: 1.08em;  
-- }  

-- .download:hover {  
--   -webkit-filter: invert(100%);  
--   filter: invert(100%);  
-- }  

-- .t-Alert--wizard,  
-- .t-Alert--horizontal {  
--   border-radius: 2px;  
--   border-color: rgba(0, 0, 0, 0.1);  
-- }  
-- .t-Alert--wizard .t-Alert-icon,  
-- .t-Alert--horizontal .t-Alert-icon {  
--   border-top-left-radius: 2px;  
--   border-bottom-left-radius: 2px;  
-- }  
-- .t-Alert--colorBG.t-Alert--warning,  
-- .t-Alert--colorBG.t-Alert--yellow {  
--   background-color: #fef7e0;  
--   color: #000000;  
-- }  
-- .t-Alert--colorBG.t-Alert--success {  
--   background-color: #f4fcf3;  
--   color: #000000;  
-- }  
-- .t-Alert--colorBG.t-Alert--danger,  
-- .t-Alert--colorBG.t-Alert--red {  
--   background-color: #fff8f7;  
--   color: #000000;  
-- }  
-- .t-Alert--colorBG.t-Alert--info {  
--   background-color: #f9fcff;  
--   color: #000000;  
-- }  
-- .t-Alert-icon .t-Icon {  
--   color: #FFF;  
-- }  
-- .t-Alert--warning .t-Alert-icon .t-Icon,  
-- .t-Alert--yellow .t-Alert-icon .t-Icon {  
--   color: #FBCE4A;  
-- }  
-- .t-Alert--warning.t-Alert--horizontal .t-Alert-icon,  
-- .t-Alert--yellow.t-Alert--horizontal .t-Alert-icon {  
--   background-color: rgba(251, 206, 74, 0.15);  
-- }  
-- .t-Alert--success .t-Alert-icon .t-Icon {  
--   color: #3BAA2C;  
-- }  
-- .t-Alert--success.t-Alert--horizontal .t-Alert-icon {  
--   background-color: rgba(59, 170, 44, 0.15);  
-- }  
-- .t-Alert--info .t-Alert-icon .t-Icon {  
--   color: #0076df;  
-- }  
-- .t-Alert--info.t-Alert--horizontal .t-Alert-icon {  
--   background-color: rgba(0, 118, 223, 0.15);  
-- }  
-- .t-Alert--danger .t-Alert-icon .t-Icon,  
-- .t-Alert--red .t-Alert-icon .t-Icon {  
--   color: #f44336;  
-- }  
-- .t-Alert--danger.t-Alert--horizontal .t-Alert-icon,  
-- .t-Alert--red.t-Alert--horizontal .t-Alert-icon {  
--   background-color: rgba(244, 67, 54, 0.15);  
-- }  
-- .t-Alert--wizard .t-Alert-inset {  
--   border-radius: 2px;  
-- }  
-- .t-Alert--horizontal,  
-- .t-Alert--wizard {  
--   background-color: #ffffff;  
--   color: #262626;  
-- }  
-- .t-Alert--page {  
--   box-shadow: 0 0 0 0.1rem rgba(0, 0, 0, 0.1) inset, 0 3px 9px -2px rgba(0, 0, 0, 0.1);  
-- }  
-- .t-Alert--page .a-Notification-item:before {  
--   background-color: rgba(0, 0, 0, 0.5);  
-- }  
-- .t-Alert--page.t-Alert--success {  
--   background-color: rgba(59, 170, 44, 0.9);  
--   color: #FFF;  
-- }  
-- .t-Alert--page.t-Alert--success .t-Alert-icon {  
--   background-color: transparent;  
--   color: #FFF;  
-- }  
-- .t-Alert--page.t-Alert--success .t-Alert-icon .t-Icon {  
--   color: inherit;  
-- }  
-- .t-Alert--page.t-Alert--success .t-Button--closeAlert {  
--   color: #FFF !important;  
-- }  
-- .t-Alert--page.t-Alert--warning {  
--   background-color: #FBCE4A;  
--   color: #443302;  
-- }  
-- .t-Alert--page.t-Alert--warning .t-Alert-icon .t-Icon {  
--   color: inherit;  
-- }  
-- .t-Alert--page.t-Alert--warning a {  
--   color: inherit;  
--   text-decoration: underline;  
-- }  
-- .t-Alert--page.t-Alert--warning .a-Notification-item:before {  
--   background-color: currentColor;  
-- }  
--  </style>                
--               <div id="card" class="animated fadeIn">  
--   <div id="upper-side">  
--       <h3 id="status"><center>CONGRATULATIONS</center>  
--     </h3>  
--   </div>  
-- <div class="t-Alert t-Alert--horizontal t-Alert--colorBG t-Alert--defaultIcons t-Alert--#ALERT_TYPE#" role="alert" style="background-color:#ffffff;">  
--   <div class="t-Alert-wrap">  
--     <div class="t-Alert-icon">  
--       <span class="t-Icon"></span>  
--     </div>  
--     <div class="t-Alert-content">  
--       <div class="t-Alert-header">  
--        <h4 class="t-Alert-title"><br/>Dear '  
--          || INITCAP (p_full_name)  
--          || ',</h4><br/>  
--         <h3 class="t-Alert-title">'  
--          || '<p>Kindly note that you have been registered as an employee self service account user on   
--          <span style="font-family: Segoe UI,Frutiger,Frutiger Linotype,Dejavu Sans,Helvetica Neue,Arial,sans-serif;  font-size: 18px; letter-spacing: 1.2px; color: #1e948a;">HumbreHR</span></p>  
--              <br/>  
--              Please find details below:'  
--          || '</h3>  
--       </div>  
--       <div class="t-Alert-body">  
--       </div>  
--     </div>  
--   </div>  
-- </div>  
--         <table>  
--   <tr>  
--     <th><left>Company:</left></th>  
--     <th>'  
--          || l_company_name  
--          || '</th>  
--   </tr>  
--   <tr>  
--     <td><left>Email Address:</left></td>  
--     <td>'  
--          || p_email_address  
--          || '</td>  
--   </tr>  
--   <tr>  
--     <td><left>Temporary Password:</left></td>  
--     <td>'  
--          || p_verification_code  
--          || '</td>  
--   </tr>  
-- </table>  
--     <div>  
--         </div>  
--   <a href="#" target="_blank"><img src="shorturl.at/npqQZ" width="100px" height="30px"></a>  
--   <img src="shorturl.at/ayKOU" width="100px" height="30px">    
--   <a href="https://apex5.revion.com/ords/HUMBRE/r/ess/login_desktop?session=10865818616309" target="_blank"><img src="shorturl.at/ghOT5" width="100px" height="30px"></a>  
--   <br/><br/>  
--   <p><center><img src="shorturl.at/nKL15" width="32px" height="32px" style="vertical-align:middle"><span style="display:inline-block;font-family:Segoe UI,Frutiger,Frutiger Linotype,Dejavu Sans,Helvetica Neue,Arial,sans-serif;  font-size: 14px; letter-spacing: 1.2px; color: #1e948a;">umbreHR</span>ed;|ed;<a style="font-size:10px">&#169;'  
--          || TO_CHAR (SYSDATE, 'RRRR')  
--          || '</a></center></p>  
--    </html>';  

--       /*  
--        <a href="#" target="_blank"><img src="https://drive.google.com/uc?export=viewer=1SCs2y3GGkHA0BluJEXEsAVKDtxki-7Ne" width="100px" height="30px"></a>  
--           <img src="https://drive.google.com/uc?export=viewer=1KinEj-hh8otGwgCMpXiq_G61dLH3AK0t" width="100px" height="30px">  
--           <a href="https://apex5.revion.com/ords/HUMBRE/r/ess/login_desktop?session=10865818616309" target="_blank"><img src="https://drive.google.com/uc?export=viewer=1lC-ZfxrXd81dN5s_kTIXo8r2pFoOs3tm" width="100px" height="30px"></a>  
--         */  

--       SELECT    'From: '  
--              || 'No Reply'  
--              || ' <'  
--              || util_email_correspondence_pkg.get_email_sender  
--              || '>   
-- To: '  
--              || p_full_name  
--              || ' <'  
--              || p_email_address  
--              || '>   
-- Bcc: '  
--              || '  
-- Subject: CiBS HR ESS user account creation  
-- Content-Type: text/html; charset:utf-8 '  
--              || '    

-- '  
--              || l_email  
--         INTO l_email_body  
--         FROM DUAL;  

--       ----send email  
--       util_email_correspondence_pkg.send_email_p (p_email      => l_email_body,  
--                                                   p_email_id   => l_email_id);  
--    EXCEPTION  
--       WHEN OTHERS  
--       THEN  
--          DBMS_OUTPUT.put_line (SQLERRM);  
--    END;  

--    PROCEDURE send_onboarding_email (p_company_id          IN NUMBER,  
--                                     p_full_name           IN VARCHAR2,  
--                                     p_notification        IN CLOB,  
--                                     p_verification_code   IN VARCHAR2,  
--                                     p_email_address       IN VARCHAR2)  
--    IS  
--       l_email                     CLOB;  
--       l_email_body                CLOB;  
--       l_email_id                  VARCHAR2 (100);  
--       l_template_content          CLOB;  
--       l_company_name              VARCHAR2 (200);  
--       l_existing_employee_email   VARCHAR2 (100);  
--       l_addition                  VARCHAR2 (32000);  
--       l_active_emp_count          NUMBER;  
--    BEGIN  
--       BEGIN  
--          SELECT company_name  
--            INTO l_company_name  
--            FROM adm_companies  
--           WHERE company_id = p_company_id;  
--       EXCEPTION  
--          WHEN OTHERS  
--          THEN  
--             l_company_name := 'Unregistered Company';  
--       END;  

--       BEGIN  
--          SELECT email_address  
--            INTO l_existing_employee_email  
--            FROM adm_users  
--           WHERE UPPER(email_address) = UPPER(p_email_address);  
--       EXCEPTION  
--          WHEN OTHERS  
--          THEN  
--             l_existing_employee_email := p_email_address;  
--       END;  

--       BEGIN  
--          SELECT count(*)  
--            INTO l_active_emp_count  
--            FROM hum_employee_list_hv  
--           WHERE UPPER(employee_email_address) = UPPER(p_email_address)  
--           and (date_of_resignation is null or date_of_resignation>trunc(sysdate));  
--       EXCEPTION  
--          WHEN OTHERS  
--          THEN  
--             l_active_emp_count := 0;  
--       END;  

--       IF l_existing_employee_email != p_email_address --and l_active_emp_count> 0   
--       THEN  
--          l_addition := '';  
--       ELSIF p_verification_code IS NULL THEN  
--       l_addition := '';  
--       ELSE  
--          l_addition :=  
--             '<br/><br/> <b>Please find your login details below</b>  
--         <table>  
--   <tr>  
--     <td><left>Email Address:</left></td>  
--     <td>'     || p_email_address || '</td>  
--   </tr>  
--   <tr>  
--     <td><left>Password:</left></td>  
--     <td>'     || p_verification_code || '</td>  
--   </tr>  
-- </table>  
--     <div>  
--         </div>';  
--       END IF;  

--       l_email :=  
--             '  
-- <head>  
--    <script src="https://code.iconify.design/1/1.0.7/iconify.min.js"></script>  
--    <title></title>  
--    <meta http-equiv="X-UA-Compatible" content="IE=edge">  
--    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">  
--    <style type="text/css">  
--   *{  
-- /*transition*/  
-- -webkit-transition:.25s ease-in-out;  
--    -moz-transition:.25s ease-in-out;  
--      -o-transition:.25s ease-in-out;  
--         transition:.25s ease-in-out;  
-- font-family:helvetica neue,helvetica,arial,sans-serif;  
-- font-size:18px;  
-- line-height:25px;  
-- box-sizing:border-box;  
-- margin:0;  
-- }  


-- #card {  
--   position: relative;  
--   top: 10px;  
--   width: 620px;  
--   display: block;  
--   margin: auto;  
--   text-align: left;  
--   font-family: Segoe UI,Frutiger,Frutiger Linotype,Dejavu Sans,Helvetica Neue,Arial,sans-serif;  
-- }  
-- #cardlower {  
--   position: relative;  
--   top: 20px;  
--   width: 320px;  
--   display: block;  
--   margin: auto;  
--   text-align: center;  
--   font-family: '' Source Sans Pro '', sans-serif;  
-- }  

-- #upper-side {  
--   padding: 1em;  
--   /***background-color: #8BC34A;**/  
--   background-color: #90ee90;  
--   display: block;  
--   color: #ffffff;/*#dee8e7;*//*#fff;*/  
--   border-top-right-radius: 8px;  
--   border-top-left-radius: 8px;  
-- }  

-- #checkmark {  
--   font-weight: lighter;  
--   fill: #fff;  
--   margin: -3.5em auto auto 20px;  
-- }  

-- #status {  
--   font-weight: lighter;  
--   text-transform: uppercase;  
--   letter-spacing: 2px;  
--   font-size: 1em;  
--   margin-top: -.2em;  
--   margin-bottom: 0;  
-- }  

-- #lower-side {  
--   padding: 2em 2em 5em 2em;  
--   background: #fff;  
--   display: block;  
--   border-bottom-right-radius: 8px;  
--   border-bottom-left-radius: 8px;  
-- }  

-- #message {  
--   margin-top: -.5em;  
--   color: #757575;  
--   letter-spacing: 1px;  
-- }  

-- @import url("https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css");  
-- ul {  
--   width: 100%;  
--   text-align: center;  
--   margin: 0;  
--   padding: 0;  
--   position: absolute;  
--   top: 50%;  
--   transform: translateY(-50%);  
-- }  

-- li {  
--   display: inline-block;  
--   margin: 10px;  
-- }  

-- .download {  
--   width: 200px;  
--   height: 75px;  
--   background: black;  
--   float: left;  
--   border-radius: 5px;  
--   position: relative;  
--   color: #fff;  
--   cursor: pointer;  
--   border: 1px solid #fff;  
-- }  

-- .download > .fa {  
--   color: #fff;  
--   position: absolute;  
--   top: 50%;  
--   left: 15px;  
--   transform: translateY(-50%);  
-- }  

-- .df,  
-- .dfn {  
--   position: absolute;  
--   left: 70px;  
-- }  

-- .df {  
--   top: 20px;  
--   font-size: .68em;  
-- }  

-- .dfn {  
--   top: 33px;  
--   font-size: 1.08em;  
-- }  

-- .download:hover {  
--   -webkit-filter: invert(100%);  
--   filter: invert(100%);  
-- }  

-- .t-Alert--wizard,  
-- .t-Alert--horizontal {  
--   border-radius: 2px;  
--   border-color: rgba(0, 0, 0, 0.1);  
-- }  
-- .t-Alert--wizard .t-Alert-icon,  
-- .t-Alert--horizontal .t-Alert-icon {  
--   border-top-left-radius: 2px;  
--   border-bottom-left-radius: 2px;  
-- }  
-- .t-Alert--colorBG.t-Alert--warning,  
-- .t-Alert--colorBG.t-Alert--yellow {  
--   background-color: #fef7e0;  
--   color: #000000;  
-- }  
-- .t-Alert--colorBG.t-Alert--success {  
--   background-color: #f4fcf3;  
--   color: #000000;  
-- }  
-- .t-Alert--colorBG.t-Alert--danger,  
-- .t-Alert--colorBG.t-Alert--red {  
--   background-color: #fff8f7;  
--   color: #000000;  
-- }  
-- .t-Alert--colorBG.t-Alert--info {  
--   background-color: #f9fcff;  
--   color: #000000;  
-- }  
-- .t-Alert-icon .t-Icon {  
--   color: #FFF;  
-- }  
-- .t-Alert--warning .t-Alert-icon .t-Icon,  
-- .t-Alert--yellow .t-Alert-icon .t-Icon {  
--   color: #FBCE4A;  
-- }  
-- .t-Alert--warning.t-Alert--horizontal .t-Alert-icon,  
-- .t-Alert--yellow.t-Alert--horizontal .t-Alert-icon {  
--   background-color: rgba(251, 206, 74, 0.15);  
-- }  
-- .t-Alert--success .t-Alert-icon .t-Icon {  
--   color: #3BAA2C;  
-- }  
-- .t-Alert--success.t-Alert--horizontal .t-Alert-icon {  
--   background-color: rgba(59, 170, 44, 0.15);  
-- }  
-- .t-Alert--info .t-Alert-icon .t-Icon {  
--   color: #0076df;  
-- }  
-- .t-Alert--info.t-Alert--horizontal .t-Alert-icon {  
--   background-color: rgba(0, 118, 223, 0.15);  
-- }  
-- .t-Alert--danger .t-Alert-icon .t-Icon,  
-- .t-Alert--red .t-Alert-icon .t-Icon {  
--   color: #f44336;  
-- }  
-- .t-Alert--danger.t-Alert--horizontal .t-Alert-icon,  
-- .t-Alert--red.t-Alert--horizontal .t-Alert-icon {  
--   background-color: rgba(244, 67, 54, 0.15);  
-- }  
-- .t-Alert--wizard .t-Alert-inset {  
--   border-radius: 2px;  
-- }  
-- .t-Alert--horizontal,  
-- .t-Alert--wizard {  
--   background-color: #ffffff;  
--   color: #262626;  
-- }  
-- .t-Alert--page {  
--   box-shadow: 0 0 0 0.1rem rgba(0, 0, 0, 0.1) inset, 0 3px 9px -2px rgba(0, 0, 0, 0.1);  
-- }  
-- .t-Alert--page .a-Notification-item:before {  
--   background-color: rgba(0, 0, 0, 0.5);  
-- }  
-- .t-Alert--page.t-Alert--success {  
--   background-color: rgba(59, 170, 44, 0.9);  
--   color: #FFF;  
-- }  
-- .t-Alert--page.t-Alert--success .t-Alert-icon {  
--   background-color: transparent;  
--   color: #FFF;  
-- }  
-- .t-Alert--page.t-Alert--success .t-Alert-icon .t-Icon {  
--   color: inherit;  
-- }  
-- .t-Alert--page.t-Alert--success .t-Button--closeAlert {  
--   color: #FFF !important;  
-- }  
-- .t-Alert--page.t-Alert--warning {  
--   background-color: #FBCE4A;  
--   color: #443302;  
-- }  
-- .t-Alert--page.t-Alert--warning .t-Alert-icon .t-Icon {  
--   color: inherit;  
-- }  
-- .t-Alert--page.t-Alert--warning a {  
--   color: inherit;  
--   text-decoration: underline;  
-- }  
-- .t-Alert--page.t-Alert--warning .a-Notification-item:before {  
--   background-color: currentColor;  
-- }  
--  </style>                
--               <div id="card" class="animated fadeIn">  
--   <div id="upper-side">  
--       <h3 id="status"><center>EMPLOYEE ONBOARDING</center>  
--     </h3>  
--   </div>  
-- <div class="t-Alert t-Alert--horizontal t-Alert--colorBG t-Alert--defaultIcons t-Alert--#ALERT_TYPE#" role="alert" style="background-color:#ffffff;">  
--   <div class="t-Alert-wrap">  
--     <div class="t-Alert-icon">  
--       <span class="t-Icon"></span>  
--     </div>  
--     <div class="t-Alert-content">  
--       <div class="t-Alert-header">  
--        <h4 class="t-Alert-title"><br/><h3 class="t-Alert-title">'  
--          || p_notification  
--          || '</h3>  
--       </div>  
--       <div class="t-Alert-body">  
--       </div>  
--     </div>  
--   </div>  
-- </div>'  
--          || l_addition  
--          || '<br/><br/>  
--   <p><center><img src="shorturl.at/nKL15" width="32px" height="32px" style="vertical-align:middle"><span style="display:inline-block;font-family:Segoe UI,Frutiger,Frutiger Linotype,Dejavu Sans,Helvetica Neue,Arial,sans-serif;  font-size: 14px; letter-spacing: 1.2px; color: #1e948a;">umbreHR</span>ed;|ed;<a style="font-size:10px">&#169;'  
--          || TO_CHAR (SYSDATE, 'RRRR')  
--          || '</a></center></p>  
--    </html>';  

--       /*  
--                       <a href="#" target="_blank"><img src="https://drive.google.com/uc?export=viewer=1SCs2y3GGkHA0BluJEXEsAVKDtxki-7Ne" width="100px" height="30px"></a>  
--                          <img src="https://drive.google.com/uc?export=viewer=1KinEj-hh8otGwgCMpXiq_G61dLH3AK0t" width="100px" height="30px">  
--                          <a href="https://apex5.revion.com/ords/HUMBRE/r/ess/login_desktop?session=10865818616309" target="_blank"><img src="https://drive.google.com/uc?export=viewer=1lC-ZfxrXd81dN5s_kTIXo8r2pFoOs3tm" width="100px" height="30px"></a>  
--                        */  

--       SELECT    'From: '  
--              || 'No Reply'  
--              || ' <'  
--              || util_email_correspondence_pkg.get_email_sender  
--              || '>   
-- To: '  
--              || p_full_name  
--              || ' <'  
--              || p_email_address  
--              || '>   
-- Bcc: '  
--              || '  
-- Subject: Employee Onboarding - '  
--              || p_full_name  
--              || '  
-- Content-Type: text/html; charset:utf-8 '  
--              || '    

-- '  
--              || l_email  
--         INTO l_email_body  
--         FROM DUAL;  

--       ----send email  
--       util_email_correspondence_pkg.send_email_p (p_email      => l_email_body,  
--                                                   p_email_id   => l_email_id);  

--    EXCEPTION  
--       WHEN OTHERS  
--       THEN  
--          DBMS_OUTPUT.put_line (SQLERRM);  
--    END;  
END ACH_AUTH_PKG;

