--Refrerece type
CREATE OR REPLACE FUNCTION item_folders_ref(item_folders)
  RETURNS json AS
$$
	SELECT json_build_object(
		'keys',json_build_object(
			'id',$1.id    
			),	
		'descr',$1.code || ' ' || coalesce($1.name, ''),
		'dataType','item_folders'
	);
$$
  LANGUAGE sql VOLATILE COST 100;
ALTER FUNCTION item_folders_ref(item_folders) OWNER TO glab;	
	
