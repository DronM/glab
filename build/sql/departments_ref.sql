--Refrerece type
CREATE OR REPLACE FUNCTION departments_ref(departments)
  RETURNS json AS
$$
	SELECT json_build_object(
		'keys',json_build_object(
			'id',$1.id    
			),	
		'descr',$1.name,
		'dataType','departments'
	);
$$
  LANGUAGE sql VOLATILE COST 100;
ALTER FUNCTION departments_ref(departments) OWNER TO ;	
	
