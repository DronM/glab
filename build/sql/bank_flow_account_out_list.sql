-- Function: bank_flow_account_out_list(in_firm_id int, in_bank_account_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ)

-- DROP FUNCTION bank_flow_account_out_list(in_firm_id int, in_bank_account_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ);

CREATE OR REPLACE FUNCTION bank_flow_account_out_list(in_firm_id int, in_bank_account_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ)
  RETURNS TABLE(
	bank_account_id int,
	fin_expense_type1_id int,
	fin_expense_type1_descr text,
	total_out numeric(15,2)
  )
   AS
$$
	SELECT
		bnk.bank_account_id,
		coalesce(bnk.fin_expense_type1_id, 0),
		coalesce(exp_tp.name, ''),
		bnk.total
	FROM bank_flow_out AS bnk
	LEFT JOIN fin_expense_types AS exp_tp ON exp_tp.id = bnk.fin_expense_type1_id
	LEFT JOIN bank_accounts AS acc ON acc.id = bnk.bank_account_id
	WHERE
		bnk.date_time BETWEEN in_date_time_from AND in_date_time_to
		AND (coalesce(in_bank_account_id, 0) = 0 OR in_bank_account_id = bnk.bank_account_id)
		AND (coalesce(in_firm_id, 0) = 0 OR (in_firm_id = acc.parent_id AND acc.parent_data_type = 'firms'))
	ORDER BY
		bnk.bank_account_id,
		exp_tp.name
	;
$$
  LANGUAGE sql VOLATILE called on null input
  COST 100;
ALTER FUNCTION bank_flow_account_out_list(in_firm_id int, in_bank_account_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ) OWNER TO ;
