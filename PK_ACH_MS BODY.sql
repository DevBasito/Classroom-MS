CREATE OR REPLACE PACKAGE BODY PK_ACH_MS AS

	PROCEDURE pr_dept_crt(p_rec IN ach_department%rowtype ) IS
		v_rec ach_department%rowtype;
	BEGIN 
		
		v_rec := p_rec;
		v_rec.row_key := ach_seq.nextval;
		v_rec.isactiveyn := 1;
		
		insert into ach_department values v_rec;
	 
	END pr_dept_crt;	

--

	PROCEDURE pr_dept_upd(p_rec IN ach_department%rowtype) IS
	BEGIN
		Update ach_department
		set dept_id    = p_rec.dept_id,
			dept_name  = p_rec.dept_name,
			isactiveyn = p_rec.isactiveyn
		where row_key = p_rec.row_key;
	END pr_dept_upd;

--

	PROCEDURE pr_module_crt(p_rec IN ach_modules%rowtype) IS
		v_rec ach_modules%rowtype;
	BEGIN
		
		v_rec := p_rec;
		v_rec.row_key := ach_seq.nextval;
		v_rec.isactiveyn := 1;
		
		insert into ach_modules values v_rec;
		
	END pr_module_crt;
	
--

	PROCEDURE pr_module_upd(p_rec IN ach_modules%rowtype) IS
	BEGIN
		Update ach_modules
		set module_id    		= p_rec.module_id,
			module_name  		= p_rec.module_name,
			module_description  = p_rec.module_description,
		    isactiveyn   		= p_rec.isactiveyn
		where row_key = p_rec.row_key;
		
	END pr_module_upd; 
	
--

	PROCEDURE pr_student_crt(p_rec IN ach_students%rowtype) IS
		v_rec ach_students%rowtype;
	BEGIN
	
		v_rec := p_rec;
		v_rec.row_key := ach_seq.nextval;
		v_rec.isactiveyn := 1;
		
		insert into ach_students values v_rec;
		
	END pr_student_crt;

--

	PROCEDURE pr_student_upd(p_rec IN ach_students%rowtype) IS
	BEGIN
		Update ach_students
		set student_id  = p_rec.student_id,
			firstname  	= p_rec.firstname,
			lastname  	= p_rec.lastname,
			username  	= p_rec.username,
			email		= p_rec.email,
			level 		= p_rec.level,
			dept_id		= p_rec.dept_id,
		    isactiveyn  = p_rec.isactiveyn
		where row_key = p_rec.row_key;
		
	END pr_student_upd; 
	
--

	PROCEDURE pr_mod_dept_crt(p_rec IN ach_mod_dept%rowtype) IS
		v_rec ach_mod_dept%rowtype;
		v_idm varchar2(100) := NULL;
		v_idd varchar2(100) := NULL;
	BEGIN
	
		select module_id, dept_id into v_idm, v_idd 
		from ach_mod_dept
		where module_id = p_rec.module_id
		and dept_id = p_rec.dept_id;
		
		IF v_idm IS NULL AND v_idd IS NULL THEN
		
			v_rec := p_rec;
			v_rec.row_key := ach_seq.nextval;
			v_rec.isactiveyn := 1;
			
			insert into ach_mod_dept values v_rec;
			
		ELSE	
			RAISE_APPLICATION_ERROR (-20111,'Module Already Assigned To This Department');
			
		END IF;
		
	END pr_mod_dept_crt;
	
--

	PROCEDURE pr_mod_dept_upd(p_rec IN ach_mod_dept%rowtype) IS
	BEGIN
		Update ach_mod_dept
		set dept_id    = p_rec.dept_id,
			module_id  = p_rec.module_id,
		    isactiveyn = p_rec.isactiveyn
		where row_key = p_rec.row_key;
		
	END pr_mod_dept_upd; 
	
--

	PROCEDURE pr_videos_crt(p_rec IN ach_videos%rowtype) IS
		v_rec ach_videos%rowtype;
	BEGIN
		
		v_rec := p_rec;
		v_rec.row_key := ach_seq.nextval;
		v_rec.isactiveyn := 1;
		
		insert into ach_videos values v_rec;
		
	END pr_videos_crt;
	
--

	PROCEDURE pr_videos_upd(p_rec IN ach_videos%rowtype) IS
	BEGIN
		Update ach_videos
		set video_id       = p_rec.video_id,
			video_name     = p_rec.video_name,
			duration  	   = p_rec.duration,
			video_url	   = p_rec.video_url,
			video_thumbnail = p_rec.video_thumbnail,
			module_id	   = p_rec.module_id,
		    isactiveyn     = p_rec.isactiveyn
		where row_key = p_rec.row_key;
		
	END pr_videos_upd; 
	
--

	PROCEDURE pr_faculty_crt(p_rec IN ach_faculty%rowtype) IS
		v_rec ach_faculty%rowtype;
	BEGIN
		
		v_rec := p_rec;
		v_rec.row_key := ach_seq.nextval;
		v_rec.isactiveyn := 1;
		
		insert into ach_faculty values v_rec;
		
	END pr_faculty_crt;
	
--

	PROCEDURE pr_faculty_upd(p_rec IN ach_faculty%rowtype) IS
	BEGIN
		Update ach_faculty
		set fac_id       = p_rec.fac_id,
			fac_name     = p_rec.fac_name,
		    isactiveyn     = p_rec.isactiveyn
		where row_key = p_rec.row_key;
		
	END pr_faculty_upd;


END PK_ACH_MS;