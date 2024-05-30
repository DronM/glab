--Refrerece type

CREATE OR REPLACE FUNCTION firms_ref(firms)
  RETURNS json AS
$$
	SELECT json_build_object(
		'keys',json_build_object(
			  'id', $1.id  
			),	
		'descr',$1.name,
		'dataType','firms'
	);
$$
  LANGUAGE sql VOLATILE COST 100;
ALTER FUNCTION firms_ref(firms) OWNER TO glab;	
	
