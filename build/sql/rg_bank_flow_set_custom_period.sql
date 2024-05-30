CREATE OR REPLACE FUNCTION rg_bank_flow_set_custom_period(IN in_new_period timestamp without time zone)
  RETURNS void AS
$BODY$
DECLARE
	NEW_PERIOD timestamp without time zone;
	v_prev_current_period timestamp without time zone;
	v_current_period timestamp without time zone;
	CURRENT_PERIOD timestamp without time zone;
	TA_PERIOD timestamp without time zone;
	REG_INTERVAL interval;
BEGIN
	NEW_PERIOD = rg_calc_period_start('bank_flow'::reg_types, in_new_period);
	SELECT date_time INTO CURRENT_PERIOD FROM rg_calc_periods WHERE reg_type = 'bank_flow'::reg_types;
	TA_PERIOD = reg_current_balance_time();
	--iterate through all periods between CURRENT_PERIOD and NEW_PERIOD
	REG_INTERVAL = rg_calc_interval('bank_flow'::reg_types);
	v_prev_current_period = CURRENT_PERIOD;		
	LOOP
		v_current_period = v_prev_current_period + REG_INTERVAL;
		IF v_current_period > NEW_PERIOD THEN
			EXIT;  -- exit loop
		END IF;
		
		--clear period
		DELETE FROM rg_bank_flow
		WHERE date_time = v_current_period;
		
		--new data
		INSERT INTO rg_bank_flow
		(date_time
		
		,bank_account_id
		,total						
		)
		(SELECT
				v_current_period
				
				,rg.bank_account_id
				,rg.total				
			FROM rg_bank_flow As rg
			WHERE (
			
			rg.total<>0
										
			)
			AND (rg.date_time=v_prev_current_period)
		);

		v_prev_current_period = v_current_period;
	END LOOP;

	--new TA data
	DELETE FROM rg_bank_flow
	WHERE date_time=TA_PERIOD;
	INSERT INTO rg_bank_flow
	(date_time
	
	,bank_account_id
	,total	
	)
	(SELECT
		TA_PERIOD
		
		,rg.bank_account_id
		,rg.total
		FROM rg_bank_flow AS rg
		WHERE (
		
		rg.total<>0
											
		)
		AND (rg.date_time=NEW_PERIOD-REG_INTERVAL)
	);

	DELETE FROM rg_bank_flow WHERE (date_time>NEW_PERIOD)
	AND (date_time<>TA_PERIOD);

	--set new period
	UPDATE rg_calc_periods SET date_time = NEW_PERIOD
	WHERE reg_type='bank_flow'::reg_types;		
END
$BODY$
LANGUAGE plpgsql VOLATILE COST 100;

ALTER FUNCTION rg_bank_flow_set_custom_period(IN in_new_period timestamp without time zone) OWNER TO ;


