-- FUNCTION: public.rg_cash_flow_update_periods(timestamp without time zone, integer, numeric)

-- DROP FUNCTION IF EXISTS public.rg_cash_flow_update_periods(timestamp without time zone, integer, numeric);

CREATE OR REPLACE FUNCTION public.rg_cash_flow_update_periods(
	in_date_time timestamp without time zone,
	in_cash_location_id integer,
	in_delta_total numeric)
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
	v_loop_rg_period timestamp;
	v_calc_interval interval;			  			
	CURRENT_BALANCE_DATE_TIME timestamp;
	CALC_DATE_TIME timestamp;
BEGIN
	CALC_DATE_TIME = rg_calc_period('cash_flow'::reg_types);
	v_loop_rg_period = rg_period('cash_flow'::reg_types,in_date_time);
	v_calc_interval = rg_calc_interval('cash_flow'::reg_types);
	--raise exception 'rg_cash_flow_update_periods';
	LOOP
		UPDATE rg_cash_flow
		SET
			total = total + in_delta_total
		WHERE 
			date_time=v_loop_rg_period
			AND cash_location_id = in_cash_location_id;
			
		IF NOT FOUND THEN
			BEGIN
				INSERT INTO rg_cash_flow (date_time
				,cash_location_id
				,total)				
				VALUES (v_loop_rg_period
				,in_cash_location_id
				,in_delta_total);
			EXCEPTION WHEN OTHERS THEN
				UPDATE rg_cash_flow
				SET
					total = total + in_delta_total
				WHERE date_time = v_loop_rg_period
				AND cash_location_id = in_cash_location_id;
			END;
		END IF;
		v_loop_rg_period = v_loop_rg_period + v_calc_interval;
		IF v_loop_rg_period > CALC_DATE_TIME THEN
			EXIT;  -- exit loop
		END IF;
	END LOOP;
	
	--Current balance
	CURRENT_BALANCE_DATE_TIME = reg_current_balance_time();
	UPDATE rg_cash_flow
	SET
		total = total + in_delta_total
	WHERE 
		date_time=CURRENT_BALANCE_DATE_TIME
		AND cash_location_id = in_cash_location_id;
		
	IF NOT FOUND THEN
		BEGIN
			INSERT INTO rg_cash_flow (date_time
			,cash_location_id
			,total)				
			VALUES (CURRENT_BALANCE_DATE_TIME
			,in_cash_location_id
			,in_delta_total);
		EXCEPTION WHEN OTHERS THEN
			UPDATE rg_cash_flow
			SET
				total = total + in_delta_total
			WHERE 
				date_time=CURRENT_BALANCE_DATE_TIME
				AND cash_location_id = in_cash_location_id;
		END;
	END IF;					
	
END;
$BODY$;

ALTER FUNCTION public.rg_cash_flow_update_periods(timestamp without time zone, integer, numeric)
    OWNER TO ;

