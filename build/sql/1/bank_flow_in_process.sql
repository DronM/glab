-- Function: public.bank_flow_in_process()

-- DROP FUNCTION public.bank_flow_in_process();

CREATE OR REPLACE FUNCTION public.bank_flow_in_process()
  RETURNS trigger AS
$BODY$
DECLARE
	reg_act ra_bank_flow%ROWTYPE;
BEGIN
	IF (TG_WHEN='BEFORE' AND TG_OP='INSERT') THEN
		--IF NEW.date_time < '2024-01-01T00:00:00'::timestamp THEN
		--	RAISE EXCEPTION 'Дата запрета редактирования: %', '2024-01-01T00:00:00'::timestamp;
		--END IF;
		
		RETURN NEW;
		
	ELSIF (TG_WHEN='AFTER') AND (TG_OP='INSERT' OR TG_OP='UPDATE') THEN					
--RAISE EXCEPTION 'NEW.bank_account_id=%', NEW.bank_account_id;	
		IF (TG_OP='INSERT') THEN						
			--log
			PERFORM doc_log_insert('bank_flow_in'::doc_types,NEW.id,NEW.date_time);
		END IF;

		--register actions ra_bank_flow
		reg_act.date_time		= NEW.date_time;
		reg_act.deb			= true;
		reg_act.doc_type  		= 'bank_flow_in'::doc_types;
		reg_act.doc_id  		= NEW.id;
		reg_act.bank_account_id		= NEW.bank_account_id;
		reg_act.total			= NEW.total;
		PERFORM ra_bank_flow_add_act(reg_act);	
		
		RETURN NEW;
		
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='UPDATE') THEN
		--IF NEW.date_time < '2024-01-01T00:00:00'::timestamp THEN
		--	RAISE EXCEPTION 'Дата запрета редактирования: %', '2024-01-01T00:00:00'::timestamp;
		--END IF;
	
		PERFORM ra_bank_flow_remove_acts('bank_flow_in'::doc_types,OLD.id);

		-- Временно!
		IF NEW.date_time<>OLD.date_time THEN
			PERFORM doc_log_update('bank_flow_in'::doc_types,NEW.id,NEW.date_time);
		END IF;
						
		RETURN NEW;
		
	ELSIF (TG_WHEN='AFTER' AND TG_OP='DELETE') THEN
	
		RETURN OLD;
		
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='DELETE') THEN
		--IF OLD.date_time < '2024-01-01T00:00:00'::timestamp THEN
		--	RAISE EXCEPTION 'Дата запрета редактирования: %', '2024-01-01T00:00:00'::timestamp;
		--END IF;
	
		--detail tables
		
		--register actions										
		PERFORM ra_bank_flow_remove_acts('bank_flow_in'::doc_types,OLD.id);
		
		--log
		PERFORM doc_log_delete('bank_flow_in'::doc_types,OLD.id);
		
		RETURN OLD;
	END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.bank_flow_in_process()
  OWNER TO ;

