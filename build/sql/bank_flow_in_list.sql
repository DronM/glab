-- VIEW: public.bank_flow_in_list

DROP VIEW public.bank_flow_in_list;

CREATE OR REPLACE VIEW public.bank_flow_in_list AS
	SELECT
		t.id
		,t.bank_account_id
		,bank_accounts_ref(bank_accounts_ref_t) AS bank_accounts_ref
		,f.id AS firm_id
		,firms_ref(f) AS firms_ref
		,t.date_time
		,t.uploaded_date_time
		,t.client_descr
		,t.pay_comment
		,t.total
		,t.pp_num
	FROM public.bank_flow_in AS t
	LEFT JOIN bank_accounts AS bank_accounts_ref_t ON bank_accounts_ref_t.id = t.bank_account_id
	LEFT JOIN firms AS f ON f.id = bank_accounts_ref_t.parent_id and  bank_accounts_ref_t.parent_data_type = 'firms'
	ORDER BY t.date_time DESC, bank_accounts_ref_t.name
	;
	
-- ALTER VIEW public.bank_flow_in_list OWNER TO ;
