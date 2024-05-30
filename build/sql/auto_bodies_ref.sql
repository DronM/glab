--Refrerece type
CREATE OR REPLACE FUNCTION auto_bodies_ref(auto_bodies)
  RETURNS json AS
$$
	SELECT json_build_object(
		'keys',json_build_object(
			'id',$1.id    
			),	
		'descr',$1.name || coalesce(' ('||$1.model||')', '') || coalesce(' '||$1.year_from::text,'') || coalesce('-'||$1.year_to::text,''),
		'dataType','auto_bodies'
	);
$$
  LANGUAGE sql VOLATILE COST 100;
ALTER FUNCTION auto_bodies_ref(auto_bodies) OWNER TO glab;	
	
