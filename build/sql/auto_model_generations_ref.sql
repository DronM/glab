--Refrerece type
CREATE OR REPLACE FUNCTION auto_model_generations_ref(auto_model_generations)
  RETURNS json AS
$$
	SELECT json_build_object(
		'keys',json_build_object(
			'id',$1.id    
			),	
		'descr',auto_model_generations_name($1),
		'dataType','auto_model_generations'
	);
$$
  LANGUAGE sql VOLATILE COST 100;
ALTER FUNCTION auto_model_generations_ref(auto_model_generations) OWNER TO glab;	
	

