--Refrerece type

CREATE OR REPLACE FUNCTION item_priorities_ref(item_priorities)
  RETURNS json AS
$$
	SELECT json_build_object(
		'keys',json_build_object(
			  'id', $1.id  
			),	
		'descr',$1.name,
		'dataType','item_priorities'
	);
$$
  LANGUAGE sql VOLATILE COST 100;
ALTER FUNCTION item_priorities_ref(item_priorities) OWNER TO glab;	
	
