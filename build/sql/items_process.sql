-- Function: items_process()

-- DROP FUNCTION items_process();

CREATE OR REPLACE FUNCTION items_process()
  RETURNS trigger AS
$BODY$
BEGIN
	IF (TG_WHEN='BEFORE' AND TG_OP='UPDATE' OR TG_OP='INSERT') THEN
		
		NEW.name = items_name(NEW);
		
		RETURN NEW;
	END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION items_process()
  OWNER TO ;

