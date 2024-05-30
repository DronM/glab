-- Function: auto_to_glass_match_eurocodes_process()

-- DROP FUNCTION auto_to_glass_match_eurocodes_process();

CREATE OR REPLACE FUNCTION auto_to_glass_match_eurocodes_process()
  RETURNS trigger AS
$BODY$
BEGIN
	IF TG_WHEN='BEFORE' AND (TG_OP='INSERT' OR TG_OP='UPDATE') THEN
		
		/**
		 * по user_code надо заполнить:
		 * auto_body_id
		 * eurocode
		 * local_id
		 */
		IF TG_OP='INSERT' OR (TG_OP='UPDATE' AND NEW.user_code <> OLD.user_code) THEN
			SELECT
				array_agg(b.id)
			INTO
				NEW.auto_bodies_list
			FROM auto_model_generations AS gn
			LEFT JOIN auto_bodies AS b ON b.auto_model_generation_id = gn.id
			WHERE
				CASE
					WHEN position('-' IN NEW.user_code) > 0 THEN gn.eurocode || '-' || gn.local_id = NEW.user_code
					ELSE gn.eurocode || '-' || gn.local_id like NEW.user_code || '-%'
				END;
			
			IF NEW.auto_bodies_list IS NULL OR array_length(NEW.auto_bodies_list, 1) = 0 THEN
				RAISE EXCEPTION 'Не найден кузов по коду %', NEW.user_code;
			END IF;
		END IF;
		
		RETURN NEW;
		
	ELSIF TG_WHEN='BEFORE' AND TG_OP='DELETE' THEN
		RETURN OLD;
		
	END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION auto_to_glass_match_eurocodes_process()
  OWNER TO ;

