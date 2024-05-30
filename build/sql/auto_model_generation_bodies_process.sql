-- Function: auto_model_generation_bodies_process()

-- DROP FUNCTION auto_model_generation_bodies_process();

CREATE OR REPLACE FUNCTION auto_model_generation_bodies_process()
  RETURNS trigger AS
$BODY$
BEGIN
	IF (TG_WHEN='BEFORE' AND TG_OP='UPDATE' OR TG_OP='INSERT') THEN
		
		IF coalesce(NEW.eurocode,'') = '' THEN
			-- assign temp eurocode
			SELECT
				'$' ||
				substring('0000', 1, 4 - length((coalesce(max((substring(b.eurocode, 2))::int), 0) + 1)::text)) ||
				(coalesce(max((substring(b.eurocode, 2))::int), 0) + 1)::text
			INTO 
				NEW.eurocode
			FROM auto_model_generation_bodies AS b
			WHERE substring(b.eurocode, 1, 1) = '$'
				AND (TG_OP='INSERT' OR b.id <> OLD.id)
			;
		END IF;
		
		IF coalesce(NEW.local_id,'') = '' THEN
			SELECT
				substring('0', 1, 2 - length( (coalesce((b.local_id)::int, 0) + 1)::text ))||
				coalesce((b.local_id)::int, 0) + 1
			INTO
				NEW.local_id
			FROM auto_model_generation_bodies AS b
			WHERE b.eurocode = NEW.eurocode
				AND (TG_OP='INSERT' OR b.id <> OLD.id)
			;
			IF NEW.local_id IS NULL THEN
				NEW.local_id = '01';
			END IF;
		
		END IF;

		RETURN NEW;
	END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION auto_model_generation_bodies_process()
  OWNER TO ;

