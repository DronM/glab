-- Function: logins_process()

-- DROP FUNCTION logins_process();

CREATE OR REPLACE FUNCTION logins_process()
  RETURNS trigger AS
$BODY$
BEGIN
	IF (TG_WHEN='AFTER' AND TG_OP='UPDATE') THEN
		IF OLD.date_time_out IS NULL AND NEW.date_time_out IS NOT NULL
		AND coalesce(NEW.session_id,'')<>'' THEN
			PERFORM pg_notify(
				'Login.logout'
				,json_build_object(
					'params',json_build_object(
						'session_id',trim(NEW.session_id)
					)
				)::text
			);
			
		END IF;
		
		RETURN NEW;
	END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION logins_process()
  OWNER TO ;

