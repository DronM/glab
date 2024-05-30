--Refrerece type
CREATE OR REPLACE FUNCTION suppliers_ref(suppliers)
  RETURNS json AS
$$
	SELECT json_build_object(
		'keys',json_build_object(
			'id',$1.id    
			),	
		'descr',$1.name,
		'dataType','suppliers'
	);
$$
  LANGUAGE sql VOLATILE COST 100;
ALTER FUNCTION suppliers_ref(suppliers) OWNER TO glab;	
	

