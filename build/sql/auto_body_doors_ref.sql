--Refrerece type
CREATE OR REPLACE FUNCTION auto_body_doors_ref(auto_body_doors)
  RETURNS json AS
$$
	SELECT json_build_object(
		'keys',json_build_object(
			'id',$1.id    
			),	
		'descr', coalesce($1.name, $1.name_full),
		'dataType','auto_body_doors'
	);
$$
  LANGUAGE sql VOLATILE COST 100;
ALTER FUNCTION auto_body_doors_ref(auto_body_doors) OWNER TO glab;	
	
