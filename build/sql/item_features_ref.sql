--Refrerece type

CREATE OR REPLACE FUNCTION item_features_ref(item_features)
  RETURNS json AS
$$
	SELECT json_build_object(
		'keys',json_build_object(
			  'id', $1.id  
			),	
		'descr',$1.name,
		'dataType','item_features'
	);
$$
  LANGUAGE sql VOLATILE COST 100;
ALTER FUNCTION item_features_ref(item_features) OWNER TO glab;	
	
