
-- Function: public.cash_flow_balance_list(in_date date)

-- DROP FUNCTION public.cash_flow_balance_list(in_date date);

CREATE OR REPLACE FUNCTION public.cash_flow_balance_list(in_date date)
  RETURNS TABLE(
  	d date,
	cash_location_id int,
	cash_location_descr text,
	total_bal_start numeric(15, 2),
	total_kred numeric(15, 2),
	total_kred_out numeric(15, 2),
	fin_expense_types json,
	total_transfer_out numeric(15, 2),

	total_deb numeric(15, 2),
	total_deb_in numeric(15, 2),
	total_transfer_in numeric(15, 2),
	total_bal_end numeric(15, 2)  
  ) AS
$BODY$
	WITH
	per as (select ((in_date::date-'1 day'::interval) + '23:59:59.999999'::time)::timestamp as d1,
		(in_date::date + '23:59:59'::time)::timestamp as d2)
	
	SELECT
			dates.d::date as d,
			loc.id as cash_location_id,
			loc.name as cash_location_descr,
			coalesce(rg_beg.total, 0) as total_bal_start,
			coalesce(ra_kred.total, 0) as total_kred,
			coalesce(ra_kred.total_out, 0) as total_kred_out,
			ra_kred.fin_expense_types,
			coalesce(ra_kred.total_transfer, 0) as total_transfer_out,

			coalesce(ra_deb.total, 0) as total_deb,
			coalesce(ra_deb.total_in, 0) as total_deb_in,
			coalesce(ra_deb.total_transfer, 0) as total_transfer_in,

			coalesce(rg_beg.total, 0) as total_bal_end
			--coalesce(rg_beg.total, 0) + sum(coalesce(ra_deb.total,0) - coalesce(ra_kred.total,0)) OVER (ORDER BY dates.d,loc.name) total_bal_end
		
	FROM
		generate_series((SELECT d1 FROM per), (SELECT d2 FROM per), '24 hours') as dates (d)
	CROSS JOIN (
			SELECT
				id, name
			FROM cash_locations
			ORDER BY name
	) as loc
	LEFT JOIN (
		SELECT
			rg.cash_location_id,
			rg.total
		FROM
			rg_cash_flow_balance((select d1 from per), '{}') as rg
	) AS rg_beg on rg_beg.cash_location_id = loc.id
	LEFT JOIN (
		SELECT
			rg.cash_location_id,
			rg.total
		FROM
			rg_cash_flow_balance((select d2 from per), '{}') as rg
	) AS rg_end on rg_end.cash_location_id = loc.id
		
	LEFT JOIN (
		SELECT
			ra.date_time::date AS d,
			ra.cash_location_id,
			json_agg(
				json_build_object(
					'expense_type', fe.name,
					'total', c_out.total
				)
			) AS fin_expense_types,

			sum(c_out.total) as total_out,
			sum(c_tr.total) as total_transfer,
			sum(ra.total) as total
		FROM
			ra_cash_flow as ra	
		LEFT JOIN cash_flow_out as c_out on ra.doc_type = 'cash_flow_out' and c_out.id = ra.doc_id
		LEFT JOIN cash_flow_transfers as c_tr on ra.doc_type = 'cash_flow_transfers' and c_tr.id = ra.doc_id
		LEFT JOIN fin_expense_types as fe on fe.id = c_out.fin_expense_type1_id
		WHERE
			ra.deb = FALSE
		 	and ra.date_time BETWEEN (SELECT d1 FROM per) AND (SELECT d2 FROM per)
		GROUP BY
			ra.cash_location_id,
			ra.date_time::date,
			fe.name
		ORDER BY ra.date_time::date, fe.name
	) AS ra_kred on ra_kred.cash_location_id = loc.id AND ra_kred.d = dates.d::date
	LEFT JOIN (
		SELECT
			ra.date_time::date AS d,
			ra.cash_location_id,
			sum(c_in.total) as total_in,
			sum(c_tr.total) as total_transfer,
			sum(ra.total) as total
		FROM
			ra_cash_flow as ra	
		LEFT JOIN cash_flow_in as c_in on ra.doc_type = 'cash_flow_in' and c_in.id = ra.doc_id
		LEFT JOIN cash_flow_transfers as c_tr on ra.doc_type = 'cash_flow_transfers' and c_tr.id = ra.doc_id
		WHERE
			ra.deb = TRUE
			and ra.date_time BETWEEN (SELECT d1 FROM per) AND (SELECT d2 FROM per)
		GROUP BY
			ra.cash_location_id,
			ra.date_time::date
			
	) AS ra_deb on ra_deb.cash_location_id = loc.id AND ra_deb.d = dates.d::date
	;

$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION public.cash_flow_balance_list(in_date date)
  OWNER TO ;

