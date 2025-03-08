CREATE OR REPLACE PACKAGE PK_ACH_MS AS

	PROCEDURE pr_dept_crt(p_rec IN ach_department%rowtype );	

--

	PROCEDURE pr_dept_upd(p_rec IN ach_department%rowtype);

--

	PROCEDURE pr_module_crt(p_rec IN ach_modules%rowtype);
	
--

	PROCEDURE pr_module_upd(p_rec IN ach_modules%rowtype);
	
--

	PROCEDURE pr_student_crt(p_rec IN ach_students%rowtype);

--

	PROCEDURE pr_student_upd(p_rec IN ach_students%rowtype);
	
--

	PROCEDURE pr_mod_dept_crt(p_rec IN ach_mod_dept%rowtype);
	
--

	PROCEDURE pr_mod_dept_upd(p_rec IN ach_mod_dept%rowtype);
	
--

	PROCEDURE pr_videos_crt(p_rec IN ach_videos%rowtype);
	
--

	PROCEDURE pr_videos_upd(p_rec IN ach_videos%rowtype);
	
--

	PROCEDURE pr_faculty_crt(p_rec IN ach_faculty%rowtype);
	
--

	PROCEDURE pr_faculty_upd(p_rec IN ach_faculty%rowtype) ;


END PK_ACH_MS;