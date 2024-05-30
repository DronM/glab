-- Function: bank_flow_account_balance_list(in_firm_id int, in_bank_account_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ)

-- DROP FUNCTION bank_flow_account_balance_list(in_firm_id int, in_bank_account_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ);

CREATE OR REPLACE FUNCTION bank_flow_account_balance_list(in_firm_id int, in_bank_account_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ)
  RETURNS TABLE(
  	firm_id int,
  	firm_name text,
  	bank_account_id int,
  	bank_account_num text,
  	bank_account_name text,
  	bank_name text,
  	balance_start numeric(15,2),
  	total_in numeric(15,2),
  	total_out numeric(15,2),
  	balance_end numeric(15,2)
  ) AS
$$
	SELECT
		sub.firm_id,
		firms.name,	
		sub.bank_account_id,		
		acc.bank_acc,
		acc.name,
		bank.name,
		SUM(coalesce(sub.b_start, 0)),
		SUM(coalesce(sub.total_in, 0)),
		SUM(coalesce(sub.total_out, 0)),
		SUM(coalesce(sub.b_start, 0)) + SUM(coalesce(sub.total_in, 0)) - SUM(coalesce(sub.total_out, 0))
	FROM (
		--start
		(SELECT
			rg.bank_account_id,
			firms.id AS firm_id,
			rg.total AS b_start,
			0 AS total_in,
			0 AS total_out,
			0 AS b_end
		FROM rg_bank_flow_balance(			
			in_date_time_from::timestamp,
			CASE
				WHEN coalesce(in_bank_account_id, 0) = 0 THEN '{}'
				ELSE ARRAY[in_bank_account_id]
			END		
		) AS rg
		LEFT JOIN bank_accounts AS bnk ON bnk.id = rg.bank_account_id
		LEFT JOIN firms ON firms.id = bnk.parent_id AND bnk.parent_data_type = 'firms'
		WHERE (coalesce(in_firm_id, 0) = 0) OR in_firm_id = firms.id)
		
		UNION ALL
		--total in/out
		(SELECT
			ra.bank_account_id,
			firms.id AS firm_id,
			0 AS b_start,
			CASE
				WHEN ra.deb THEN ra.total
				ELSE 0
			END AS total_in,
			CASE
				WHEN ra.deb = FALSE THEN ra.total
				ELSE 0
			END AS total_out,
			0 AS b_end
		FROM ra_bank_flow AS ra
		LEFT JOIN bank_accounts AS bnk ON bnk.id = ra.bank_account_id
		LEFT JOIN firms ON firms.id = bnk.parent_id AND bnk.parent_data_type = 'firms'
		WHERE (coalesce(in_firm_id, 0) = 0 OR in_firm_id = firms.id)
			AND ra.date_time BETWEEN in_date_time_from AND in_date_time_to
		)
	) AS sub
	LEFT JOIN firms ON firms.id = sub.firm_id
	LEFT JOIN bank_accounts AS acc ON acc.id = sub.bank_account_id
	LEFT JOIN banks.banks AS bank ON bank.bik = acc.bank_bik
	GROUP BY
		sub.firm_id,
		sub.bank_account_id,
		acc.bank_acc,
		bank.name,
		acc.name,
		firms.name
	;
$$
  LANGUAGE sql VOLATILE called on null input
  COST 100;
ALTER FUNCTION bank_flow_account_balance_list(in_firm_id int, in_bank_account_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ) OWNER TO ;
