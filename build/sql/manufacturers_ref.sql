--Refrerece type
CREATE OR REPLACE FUNCTION manufacturers_ref(manufacturers)
  RETURNS json AS
$$
	SELECT json_build_object(
		'keys',json_build_object(
			   'keys', json_build_object('id', $1.id)
			),	
		'descr',$1.name,
		'dataType','manufacturers'
	);
$$
  LANGUAGE sql VOLATILE COST 100;
ALTER FUNCTION manufacturers_ref(manufacturers) OWNER TO glab;	
	
