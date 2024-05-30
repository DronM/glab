-- Function: user_operations_process()

-- DROP FUNCTION user_operations_process();

CREATE OR REPLACE FUNCTION user_operations_process()
  RETURNS trigger AS
$BODY$
BEGIN

	IF TG_OP='UPDATE' AND (
		 (coalesce(OLD.status,'')<>'end' AND coalesce(NEW.status,'')='end')
		 OR NEW.status='progress'
	)
	THEN		
		--md5(NEW.user_id::text||
		PERFORM pg_notify(
			'UserOperation.'||NEW.operation_id
			,json_build_object(
				'params',json_build_object(
					'status', NEW.status,
					'res', coalesce(NEW.error_text,'')='',
					'operation_id', NEW.operation_id
				)
			)::text
		);
	END IF;
	
	RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION user_operations_process()
  OWNER TO ;

