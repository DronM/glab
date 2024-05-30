--Refrerece type
-- DROP FUNCTION manufacturer_brands_ref(manufacturer_brands, manufacturers);
CREATE OR REPLACE FUNCTION manufacturer_brands_ref(manufacturer_brands, manufacturers)
  RETURNS json AS
$$
	SELECT json_build_object(
		'keys',json_build_object(
			   'keys', json_build_object('id', $1.id)
			),	
		'descr',coalesce($1.name,'') || ' (' || coalesce($2.name,'') ||')',
		'dataType','manufacturer_brands'
	);
$$
  LANGUAGE sql VOLATILE COST 100;
ALTER FUNCTION manufacturer_brands_ref(manufacturer_brands, manufacturers) OWNER TO glab;	
	
