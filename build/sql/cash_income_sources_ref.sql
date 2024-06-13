CREATE OR REPLACE FUNCTION cash_income_sources_ref(cash_income_sources)
  RETURNS json AS
$$
	SELECT json_build_object(
		'keys',json_build_object(
			'id',$1.id    
			),	
		'descr',$1.name,
		'dataType','cash_income_sources'
	);
$$
  LANGUAGE sql VOLATILE COST 100;
ALTER FUNCTION cash_income_sources_ref(cash_income_sources) OWNER TO glab;	
	

