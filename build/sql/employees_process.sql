-- Function: employees_process()

-- DROP FUNCTION employees_process();

CREATE OR REPLACE FUNCTION employees_process()
  RETURNS trigger AS
$BODY$
BEGIN
	IF (TG_WHEN='BEFORE' AND TG_OP='INSERT') THEN
		
		NEW.sort_index = coalesce((SELECT max(sort_index) FROM employees), 0) + 100;
		
		RETURN NEW;
	END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION employees_process()
  OWNER TO ;

