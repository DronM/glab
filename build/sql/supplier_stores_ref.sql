--Refrerece type

--DROP FUNCTION supplier_stores_ref(supplier_stores);

CREATE OR REPLACE FUNCTION supplier_stores_ref(supplier_stores)
  RETURNS json AS
$$
	SELECT json_build_object(
		'keys',json_build_object(
			  'id', $1.id  
			),	
		'descr', $1.name,
		'dataType', 'supplier_stores'
	);
$$
  LANGUAGE sql VOLATILE COST 100;
ALTER FUNCTION supplier_stores_ref(supplier_stores) OWNER TO ;	
	
