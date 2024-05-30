CREATE OR REPLACE FUNCTION fin_expense_types_ref(fin_expense_types)
  RETURNS json AS
$$
	SELECT json_build_object(
		'keys',json_build_object(
			    
			),	
		'descr',$1.name,
		'dataType','fin_expense_types'
	);
$$
  LANGUAGE sql VOLATILE COST 100;
ALTER FUNCTION fin_expense_types_ref(fin_expense_types) OWNER TO glab;	

