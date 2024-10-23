-- Function: cash_flow_location_balance_list(in_cash_location_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ)

-- DROP FUNCTION cash_flow_location_balance_list(in_cash_location_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ);

CREATE OR REPLACE FUNCTION cash_flow_location_balance_list(in_cash_location_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ)
  RETURNS TABLE(
  	cash_location_id int,
  	cash_location_name text,
  	balance_start numeric(15,2),
  	total_in numeric(15,2),
  	total_transfer_in numeric(15,2),
  	total_out numeric(15,2),
  	total_transfer_out numeric(15,2),
  	balance_end numeric(15,2)
  ) AS
$$
	SELECT
		sub.cash_location_id,
		cash_locations.name AS cash_location_name,	
		SUM(coalesce(sub.b_start, 0)),
		SUM(coalesce(sub.total_in, 0)),
		SUM(coalesce(sub.total_transfer_in, 0)),
		SUM(coalesce(sub.total_out, 0)),
		SUM(coalesce(sub.total_transfer_out, 0)),
		SUM(coalesce(sub.b_start, 0)) + SUM(coalesce(sub.total_in, 0)) - SUM(coalesce(sub.total_out, 0))
	FROM (
		--start
		(SELECT
			rg.cash_location_id,
			coalesce(rg.total,0) AS b_start,
			0 AS total_in,
			0 AS total_transfer_in,
			0 AS total_out,
			0 AS total_transfer_out,
			0 AS b_end
		FROM rg_cash_flow_balance(			
			in_date_time_from::timestamp,
			CASE
				WHEN coalesce(in_cash_location_id, 0) = 0 THEN '{}'
				ELSE ARRAY[in_cash_location_id]
			END		
		) AS rg
		)
		
		UNION ALL
		--total in/out
		(SELECT
			ra.cash_location_id,
			0 AS b_start,
			CASE
				WHEN ra.deb THEN ra.total
				ELSE 0
			END AS total_in,
			CASE
				WHEN ra.deb AND ra.doc_type = 'cash_flow_transfers' THEN ra.total
				ELSE 0
			END AS total_transfer_in,
			
			CASE
				WHEN ra.deb = FALSE THEN ra.total
				ELSE 0
			END AS total_out,
			CASE
				WHEN ra.deb = FALSE AND ra.doc_type = 'cash_flow_transfers' THEN ra.total				
				ELSE 0
			END AS total_transfer_out,
			
			0 AS b_end
		FROM ra_cash_flow AS ra
		WHERE (coalesce(in_cash_location_id, 0) = 0 OR in_cash_location_id = ra.cash_location_id)
			AND ra.date_time BETWEEN in_date_time_from AND in_date_time_to
		)
		
	) AS sub
	LEFT JOIN cash_locations ON cash_locations.id = sub.cash_location_id
	GROUP BY
		sub.cash_location_id,
		cash_locations.name
	;
$$
  LANGUAGE sql VOLATILE called on null input
  COST 100;
ALTER FUNCTION cash_flow_location_balance_list(in_cash_location_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ) OWNER TO ;
