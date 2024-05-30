-- VIEW: public.employees_dialog

--DROP VIEW public.employees_dialog;

CREATE OR REPLACE VIEW public.employees_dialog AS
	SELECT
		t.id
		,t.name
		,t.birth_date
		,departments_ref(departments_ref_t) AS departments_ref
		,t.qualification
		,t.driving_lic_cat
		,t.expirience
		,t.staff
		,card_banks_ref(card_banks_ref_t) AS card_banks_ref
		,t.children
		,t.alimony
		,t.cloth
		,contacts_ref(contacts_ref_t) AS contacts_ref
		,t.comment_text
		
		,posts_ref(posts_ref_t) AS posts_ref
		
	FROM public.employees AS t
	LEFT JOIN departments AS departments_ref_t ON departments_ref_t.id = t.department_id
	LEFT JOIN card_banks AS card_banks_ref_t ON card_banks_ref_t.id = t.card_bank_id
	LEFT JOIN contacts AS contacts_ref_t ON contacts_ref_t.id = t.contact_id
	LEFT JOIN posts AS posts_ref_t ON posts_ref_t.id = contacts_ref_t.post_id
	;
	
ALTER VIEW public.employees_dialog OWNER TO ;
