-- FUNCTION: public.rg_bank_flow_update_periods(timestamp without time zone, integer, numeric)

-- DROP FUNCTION IF EXISTS public.rg_bank_flow_update_periods(timestamp without time zone, integer, numeric);

CREATE OR REPLACE FUNCTION public.rg_bank_flow_update_periods(
	in_date_time timestamp without time zone,
	in_bank_account_id integer,
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
	CALC_DATE_TIME = rg_calc_period('bank_flow'::reg_types);
	v_loop_rg_period = rg_period('bank_flow'::reg_types,in_date_time);
	v_calc_interval = rg_calc_interval('bank_flow'::reg_types);
	LOOP
		UPDATE rg_bank_flow
		SET
			total = coalesce(total, 0) + in_delta_total
		WHERE 
			date_time=v_loop_rg_period
			AND bank_account_id = in_bank_account_id;
			
		IF NOT FOUND THEN
			BEGIN
				INSERT INTO rg_bank_flow (date_time
				,bank_account_id
				,total)				
				VALUES (v_loop_rg_period
				,in_bank_account_id
				,in_delta_total);
			EXCEPTION WHEN OTHERS THEN
				UPDATE rg_bank_flow
				SET
					total = coalesce(total, 0) + in_delta_total
				WHERE date_time = v_loop_rg_period
				AND bank_account_id = in_bank_account_id;
			END;
		END IF;
		v_loop_rg_period = v_loop_rg_period + v_calc_interval;
		IF v_loop_rg_period > CALC_DATE_TIME THEN
			EXIT;  -- exit loop
		END IF;
	END LOOP;
	
	--Current balance
	CURRENT_BALANCE_DATE_TIME = reg_current_balance_time();
	UPDATE rg_bank_flow
	SET
		total = coalesce(total, 0) + in_delta_total
	WHERE 
		date_time=CURRENT_BALANCE_DATE_TIME
		AND bank_account_id = in_bank_account_id;
		
	IF NOT FOUND THEN
		BEGIN
			INSERT INTO rg_bank_flow (date_time
			,bank_account_id
			,total)				
			VALUES (CURRENT_BALANCE_DATE_TIME
			,in_bank_account_id
			,in_delta_total);
		EXCEPTION WHEN OTHERS THEN
			UPDATE rg_bank_flow
			SET
				total = coalesce(total, 0) + in_delta_total
			WHERE 
				date_time=CURRENT_BALANCE_DATE_TIME
				AND bank_account_id = in_bank_account_id;
		END;
	END IF;					
	
END;
$BODY$;

ALTER FUNCTION public.rg_bank_flow_update_periods(timestamp without time zone, integer, numeric)
    OWNER TO ;

