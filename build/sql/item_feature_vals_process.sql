-- Function: item_feature_vals_process()

-- DROP FUNCTION item_feature_vals_process();

CREATE OR REPLACE FUNCTION item_feature_vals_process()
  RETURNS trigger AS
$BODY$
BEGIN
	IF (TG_WHEN='AFTER' AND TG_OP='INSERT' OR TG_OP='UPDATE') THEN
RAISE EXCEPTION '%', item_feature_vals_as_str(NEW.item_id);	
		UPDATE items
		SET feature_vals = item_feature_vals_as_str(NEW.item_id)
		WHERE id = NEW.item_id;
		
		RETURN NEW;
	
	ELSIF (TG_WHEN='AFTER' AND TG_OP='DELETE') THEN
		UPDATE items
		SET feature_vals = item_feature_vals_as_str(NEW.item_id)
		WHERE id = NEW.item_id;
		
		RETURN OLD;
	END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION item_feature_vals_process()
  OWNER TO ;

