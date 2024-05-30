--Refrerece type
CREATE OR REPLACE FUNCTION time_zone_locales_ref(time_zone_locales)
  RETURNS json AS
$$
	SELECT json_build_object(
		'keys',json_build_object(
			'id',$1.id    
			),	
		'descr',$1.descr,
		'dataType','time_zone_locales'
	);
$$
  LANGUAGE sql VOLATILE COST 100;
ALTER FUNCTION time_zone_locales_ref(time_zone_locales) OWNER TO glab;	

