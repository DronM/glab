-- VIEW: public.bank_accounts_list

--DROP VIEW public.bank_accounts_list;

CREATE OR REPLACE VIEW public.bank_accounts_list AS
	SELECT
		t.id
		,t.parent_data_type		
		,t.parent_id
		,CASE
			WHEN t.parent_data_type = 'firms' THEN firms_ref(f)
			ELSE '{"keys": null, "descr":""}'::json
		END AS parents_ref
		,t.name
		,t.bank_acc
		,banks.banks_ref(b) AS banks_ref
	FROM public.bank_accounts AS t
	LEFT JOIN banks.banks as b on b.bik = t.bank_bik
	LEFT JOIN firms as f on t.parent_data_type = 'firms' and f.id = t.parent_id
	ORDER BY t.name
	;
	
ALTER VIEW public.bank_accounts_list OWNER TO ;
