CREATE OR REPLACE FUNCTION cash_locations_ref(cash_locations)
  RETURNS json AS
$$
	SELECT json_build_object(
		'keys',json_build_object(
			'id',$1.id    
			),	
		'descr',$1.name,
		'dataType','cash_locations'
	);
$$
  LANGUAGE sql VOLATILE COST 100;
ALTER FUNCTION cash_locations_ref(cash_locations) OWNER TO glab;	
	

