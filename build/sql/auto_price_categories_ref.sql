--Refrerece type
CREATE OR REPLACE FUNCTION auto_price_categories_ref(auto_price_categories)
  RETURNS json AS
$$
	SELECT json_build_object(
		'keys',json_build_object(
			'id',$1.id    
			),	
		'descr', cast($1.price_from as text) || ' - ' || cast($1.price_to  as text),
		'dataType','auto_price_categories'
	);
$$
  LANGUAGE sql VOLATILE COST 100;
ALTER FUNCTION auto_price_categories_ref(auto_price_categories) OWNER TO glab;	
	

