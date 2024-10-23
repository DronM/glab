-- FUNCTION: public.rg_total_recalc_cash_flow()

-- DROP FUNCTION public.rg_total_recalc_cash_flow();

CREATE OR REPLACE FUNCTION public.rg_total_recalc_cash_flow(
	)
    RETURNS void
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
AS $BODY$
DECLARE
	period_row RECORD;
	v_act_date_time timestamp without time zone;
	v_cur_period timestamp without time zone;
BEGIN	
	v_act_date_time = reg_current_balance_time();
	SELECT date_time INTO v_cur_period FROM rg_calc_periods WHERE reg_type='cash_flow';
--RAISE EXCEPTION 'v_cur_period=%',v_cur_period;	
	FOR period_row IN
		WITH
		periods AS (
			(SELECT
				DISTINCT date_trunc('month', date_time) AS d,
				cash_location_id
			FROM ra_cash_flow)
			UNION		
			(SELECT
				date_time AS d,
				cash_location_id
			FROM rg_cash_flow WHERE date_time<=v_cur_period
			)
			ORDER BY d			
		)
		SELECT sub.d,sub.cash_location_id,sub.balance_fact,sub.balance_paper
		FROM
		(
		SELECT
			periods.d,
			periods.cash_location_id,
			COALESCE((
				SELECT SUM(CASE WHEN deb THEN total ELSE 0 END)-SUM(CASE WHEN NOT deb THEN total ELSE 0 END)
				FROM ra_cash_flow AS ra WHERE ra.date_time <= last_month_day(periods.d::date)+'23:59:59'::interval
				AND ra.cash_location_id=periods.cash_location_id
			),0) AS balance_fact,
			
			(
			SELECT SUM(total) FROM rg_cash_flow WHERE date_time=periods.d
			AND cash_location_id=periods.cash_location_id
			) AS balance_paper
			
		FROM periods
		) AS sub
		WHERE sub.balance_fact<>sub.balance_paper ORDER BY sub.d	
	LOOP
		
		/*UPDATE rg_cash_flow AS rg
		SET total = period_row.balance_fact
		WHERE rg.date_time=period_row.d
		AND rg.cash_location_id=period_row.cash_location_id;
		
		IF NOT FOUND THEN
			INSERT INTO rg_cash_flow (date_time,cash_location_id,total)
			VALUES (period_row.d,period_row.cash_location_id,period_row.balance_fact);
		END IF;		
		*/
		
		DELETE FROM rg_cash_flow
		WHERE date_time=period_row.d
		AND cash_location_id=period_row.cash_location_id;

		INSERT INTO rg_cash_flow (date_time,cash_location_id,total)
		VALUES (period_row.d,period_row.cash_location_id,period_row.balance_fact);
	END LOOP;

	--АКТУАЛЬНЫЕ ИТОГИ
	DELETE FROM rg_cash_flow WHERE date_time>v_cur_period;
	
	INSERT INTO rg_cash_flow (date_time,cash_location_id,total)
	(
	SELECT
		v_act_date_time,
		rg.cash_location_id,
		COALESCE(rg.total,0) +
		COALESCE((
		SELECT sum(ra.total) FROM
		ra_cash_flow AS ra
		WHERE ra.date_time BETWEEN v_cur_period AND last_month_day(v_cur_period::date)+'23:59:59'::interval
			AND ra.cash_location_id=rg.cash_location_id
			AND ra.deb=TRUE
		),0) - 
		COALESCE((
		SELECT sum(ra.total) FROM
		ra_cash_flow AS ra
		WHERE ra.date_time BETWEEN v_cur_period AND last_month_day(v_cur_period::date)+'23:59:59'::interval
			AND ra.cash_location_id=rg.cash_location_id
			AND ra.deb=FALSE
		),0)
		
	FROM rg_cash_flow AS rg
	WHERE date_time=(v_cur_period-'1 month'::interval)
	);	
END;
$BODY$;

ALTER FUNCTION public.rg_total_recalc_cash_flow()
    OWNER TO ;

