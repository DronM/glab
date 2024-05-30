--Refrerece type
CREATE OR REPLACE FUNCTION auto_body_types_ref(auto_body_types)
  RETURNS json AS
$$
	SELECT json_build_object(
		'keys',json_build_object(
			'id',$1.id    
			),	
		'descr', coalesce($1.name, $1.name_full),
		'dataType','auto_body_types'
	);
$$
  LANGUAGE sql VOLATILE COST 100;
ALTER FUNCTION auto_body_types_ref(auto_body_types) OWNER TO glab;	
	
