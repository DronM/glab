-- VIEW: public.bank_flow_out_dialog

--DROP VIEW public.bank_flow_out_dialog;

CREATE OR REPLACE VIEW public.bank_flow_out_dialog AS
	SELECT
		t.id
		,bank_accounts_ref(bank_accounts_ref_t) AS bank_accounts_ref
		,fin_expense_types_ref(fin1) as fin_expense_types1_ref
		,fin_expense_types_ref(fin2) as fin_expense_types2_ref
		,fin_expense_types_ref(fin3) as fin_expense_types3_ref
		,t.date_time
		,t.uploaded_date_time
		,t.client_descr
		,t.pay_comment
		,t.total
		,t.pp_num
	FROM public.bank_flow_out AS t
	LEFT JOIN bank_accounts AS bank_accounts_ref_t ON bank_accounts_ref_t.id = t.bank_account_id
	LEFT JOIN fin_expense_types AS fin1 ON fin1.id = t.fin_expense_type1_id
	LEFT JOIN fin_expense_types AS fin2 ON fin2.id = t.fin_expense_type2_id
	LEFT JOIN fin_expense_types AS fin3 ON fin3.id = t.fin_expense_type3_id
	;
	
-- ALTER VIEW public.bank_flow_out_dialog OWNER TO ;
