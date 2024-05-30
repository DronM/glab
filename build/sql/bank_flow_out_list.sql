
-- VIEW: public.bank_flow_out_list

DROP VIEW public.bank_flow_out_list;

CREATE OR REPLACE VIEW public.bank_flow_out_list AS
	SELECT
		t.id
		,t.bank_account_id
		,bank_accounts_ref(bank_accounts_ref_t) AS bank_accounts_ref
		,fin_expense_types_ref(exp1) AS fin_expense_types1_ref
		,fin_expense_types_ref(exp2) AS fin_expense_types2_ref
		,fin_expense_types_ref(exp3) AS fin_expense_types3_ref
		,t.fin_expense_type1_id
		,t.fin_expense_type2_id
		,t.fin_expense_type3_id
		,t.date_time
		,t.uploaded_date_time
		,t.client_descr
		,t.pay_comment
		,t.total
		,t.pp_num
	FROM public.bank_flow_out AS t
	LEFT JOIN bank_accounts AS bank_accounts_ref_t ON bank_accounts_ref_t.id = t.bank_account_id
	LEFT JOIN fin_expense_types AS exp1 ON exp1.id = t.fin_expense_type1_id
	LEFT JOIN fin_expense_types AS exp2 ON exp2.id = t.fin_expense_type2_id
	LEFT JOIN fin_expense_types AS exp3 ON exp3.id = t.fin_expense_type3_id
	ORDER BY t.date_time DESC, bank_accounts_ref_t.name
	;
	
-- ALTER VIEW public.bank_flow_out_list OWNER TO ;
