-- FUNCTION: public.fin_expense_types_ref(fin_expense_types)

-- DROP FUNCTION IF EXISTS public.fin_expense_types_ref(fin_expense_types);

CREATE OR REPLACE FUNCTION public.fin_expense_types_ref(
	fin_expense_types)
    RETURNS json
    LANGUAGE 'sql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
	SELECT json_build_object(
		'keys',json_build_object(
			  'id', $1.id  
			),	
		'descr',$1.name,
		'dataType','fin_expense_types'
	);
$BODY$;

ALTER FUNCTION public.fin_expense_types_ref(fin_expense_types)
    OWNER TO ;

