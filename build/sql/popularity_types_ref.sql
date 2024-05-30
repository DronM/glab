--Refrerece type

CREATE OR REPLACE FUNCTION popularity_types_ref(popularity_types)
  RETURNS json AS
$$
	SELECT json_build_object(
		'keys',json_build_object(
			  'id', $1.id  
			),	
		'descr',$1.name,
		'dataType','popularity_types'
	);
$$
  LANGUAGE sql VOLATILE COST 100;
ALTER FUNCTION popularity_types_ref(popularity_types) OWNER TO glab;	
	
