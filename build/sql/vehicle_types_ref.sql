--Refrerece type

CREATE OR REPLACE FUNCTION vehicle_types_ref(vehicle_types)
  RETURNS json AS
$$
	SELECT json_build_object(
		'keys',json_build_object(
			  'id', $1.id  
			),	
		'descr',$1.name,
		'dataType','vehicle_types'
	);
$$
  LANGUAGE sql VOLATILE COST 100;
ALTER FUNCTION vehicle_types_ref(vehicle_types) OWNER TO glab;	
	
