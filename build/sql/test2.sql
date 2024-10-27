
with
	in_date_time as (select '2024-08-02T00:00:00'::timestamp as d),
	cur_per AS (SELECT rg_period('cash_flow'::reg_types, (select d from in_date_time)) AS v ),
	act_forward AS (
		SELECT
			-- rg_period_balance('cash_flow'::reg_types,(select d from in_date_time)) - (select d from in_date_time) >
			-- (SELECT t.v FROM cur_per t) - (select d from in_date_time)
			true AS v
	),
	act_sg AS (SELECT CASE WHEN t.v THEN 1 ELSE -1 END AS v FROM act_forward t)

		SELECT
		
		act.cash_location_id
		,CASE act.deb
			WHEN TRUE THEN act.total * (SELECT t.v FROM act_sg t)
			ELSE -act.total * (SELECT t.v FROM act_sg t)
		END AS total
										
		FROM doc_log
		LEFT JOIN ra_cash_flow AS act ON act.doc_type=doc_log.doc_type AND act.doc_id=doc_log.doc_id
		WHERE
		(
			--forward from previous period
			( (SELECT t.v FROM act_forward t) AND
					act.date_time >= (SELECT t.v FROM cur_per t)
					AND act.date_time <= 
						(SELECT l.date_time FROM doc_log l
						WHERE date_trunc('second',l.date_time)<=date_trunc('second',(select d from in_date_time))
						ORDER BY l.date_time DESC LIMIT 1
						)
					
			)
			--backward from current
			OR			
			( NOT (SELECT t.v FROM act_forward t) AND
					act.date_time >= 
						(SELECT l.date_time FROM doc_log l
						WHERE date_trunc('second',l.date_time)>=date_trunc('second',(select d from in_date_time))
						ORDER BY l.date_time ASC LIMIT 1
						)			
					AND act.date_time <= (SELECT t.v FROM cur_per t)
			)
		)
		AND (
		
		act.total<>0
		)
		ORDER BY doc_log.date_time,doc_log.id
