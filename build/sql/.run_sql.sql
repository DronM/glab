-- VIEW: public.cash_flow_out_list

DROP VIEW public.cash_flow_out_list;

CREATE OR REPLACE VIEW public.cash_flow_out_list AS
	SELECT
		t.id
		,t.date_time
		,t.cash_location_id
		,cash_locations_ref(cash_locations_ref_t) AS cash_locations_ref
		,fin_expense_types_ref(exp1) AS fin_expense_types1_ref
		,exp1.name AS fin_expense_types1_descr
		,exp1.id AS fin_expense_types1_id
		,fin_expense_types_ref(exp2) AS fin_expense_types2_ref
		,exp2.name AS fin_expense_types2_descr
		,exp2.id AS fin_expense_types2_id
		,fin_expense_types_ref(exp3) AS fin_expense_types3_ref
		,exp3.name AS fin_expense_types3_descr
		,exp3.id AS fin_expense_types3_id
		,t.comment_text
		,t.comment_text2
		,users_ref(users_ref_t) AS users_ref
		,t.total
	FROM public.cash_flow_out AS t
	LEFT JOIN cash_locations AS cash_locations_ref_t ON cash_locations_ref_t.id = t.cash_location_id
	LEFT JOIN users AS users_ref_t ON users_ref_t.id = t.user_id
	LEFT JOIN fin_expense_types AS exp1 ON exp1.id = t.fin_expense_type1_id
	LEFT JOIN fin_expense_types AS exp2 ON exp2.id = t.fin_expense_type2_id
	LEFT JOIN fin_expense_types AS exp3 ON exp3.id = t.fin_expense_type3_id
	ORDER BY t.date_time DESC
	;
	
-- ALTER VIEW public.cash_flow_out_list OWNER TO glab;
