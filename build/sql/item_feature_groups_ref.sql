--Refrerece type

CREATE OR REPLACE FUNCTION item_feature_groups_ref(item_feature_groups)
  RETURNS json AS
$$
	SELECT json_build_object(
		'keys',json_build_object(
			  'id', $1.id  
			),	
		'descr',$1.name,
		'dataType','item_feature_groups'
	);
$$
  LANGUAGE sql VOLATILE COST 100;
ALTER FUNCTION item_feature_groups_ref(item_feature_groups) OWNER TO glab;	
	
