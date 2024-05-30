--process function
CREATE OR REPLACE FUNCTION ra_bank_flow_process()
  RETURNS trigger AS
$BODY$
DECLARE
	v_delta_total  numeric(15,2) DEFAULT 0;
	
	CALC_DATE_TIME timestamp;
	CURRENT_BALANCE_DATE_TIME timestamp;
	v_loop_rg_period timestamp;
	v_calc_interval interval;			  			
BEGIN
	IF (TG_WHEN='BEFORE' AND TG_OP='INSERT') THEN
		RETURN NEW;
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='UPDATE') THEN
		RETURN NEW;
	ELSIF (TG_WHEN='AFTER' AND (TG_OP='UPDATE' OR TG_OP='INSERT')) THEN

		CALC_DATE_TIME = rg_calc_period('bank_flow'::reg_types);

		IF (CALC_DATE_TIME IS NULL) OR (NEW.date_time::date > rg_period_balance('bank_flow'::reg_types, CALC_DATE_TIME)) THEN
			CALC_DATE_TIME = rg_period('bank_flow'::reg_types, NEW.date_time);
			PERFORM rg_bank_flow_set_custom_period(CALC_DATE_TIME);						
		END IF;

		IF TG_OP='UPDATE' THEN
			v_delta_total = OLD.total;
			
		ELSE
			v_delta_total = 0;
								
		END IF;
		v_delta_total = NEW.total - v_delta_total;
		
		IF NOT NEW.deb THEN
			v_delta_total = -1 * v_delta_total;
								
		END IF;
		
		v_loop_rg_period = CALC_DATE_TIME;
		v_calc_interval = rg_calc_interval('bank_flow'::reg_types);
		LOOP
			UPDATE rg_bank_flow
			SET
			total = total + v_delta_total
			WHERE 
				date_time=v_loop_rg_period
				
				AND bank_account_id = NEW.bank_account_id;
			IF NOT FOUND THEN
				BEGIN
					INSERT INTO rg_bank_flow (date_time
					
					,bank_account_id
					,total)				
					VALUES (v_loop_rg_period
					
					,NEW.bank_account_id
					,v_delta_total);
				EXCEPTION WHEN OTHERS THEN
					UPDATE rg_bank_flow
					SET
					total = total + v_delta_total
					WHERE date_time = v_loop_rg_period
					
					AND bank_account_id = NEW.bank_account_id;
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
		total = total + v_delta_total
		WHERE 
			date_time=CURRENT_BALANCE_DATE_TIME
			
			AND bank_account_id = NEW.bank_account_id;
		IF NOT FOUND THEN
			BEGIN
				INSERT INTO rg_bank_flow (date_time
				
				,bank_account_id
				,total)				
				VALUES (CURRENT_BALANCE_DATE_TIME
				
				,NEW.bank_account_id
				,v_delta_total);
			EXCEPTION WHEN OTHERS THEN
				UPDATE rg_bank_flow
				SET
				total = total + v_delta_total
				WHERE 
					date_time=CURRENT_BALANCE_DATE_TIME
					
					AND bank_account_id = NEW.bank_account_id;
			END;
		END IF;
		
		RETURN NEW;					
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='DELETE') THEN
		RETURN OLD;
	ELSIF (TG_WHEN='AFTER' AND TG_OP='DELETE') THEN
		
		CALC_DATE_TIME = rg_calc_period('bank_flow'::reg_types);

		IF (CALC_DATE_TIME IS NULL) OR (OLD.date_time::date > rg_period_balance('bank_flow'::reg_types, CALC_DATE_TIME)) THEN
			CALC_DATE_TIME = rg_period('bank_flow'::reg_types,OLD.date_time);
			PERFORM rg_bank_flow_set_custom_period(CALC_DATE_TIME);						
		END IF;
		
		v_delta_total = OLD.total;
							
		IF OLD.deb THEN
			v_delta_total = -1*v_delta_total;					
			
		END IF;
		
		
		PERFORM rg_bank_flow_update_periods(OLD.date_time
		
		,OLD.bank_account_id
		,v_delta_total);
		
		RETURN OLD;					
	END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;

ALTER FUNCTION ra_bank_flow_process() OWNER TO ;

