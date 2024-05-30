--Refrerece type

CREATE OR REPLACE FUNCTION items_ref(items)
  RETURNS json AS
$$
	SELECT json_build_object(
		'keys',json_build_object(
			  'id', $1.id  
			),	
		'descr',$1.name,
		'dataType','items'
	);
$$
  LANGUAGE sql VOLATILE COST 100;
ALTER FUNCTION items_ref(items) OWNER TO glab;	
	
