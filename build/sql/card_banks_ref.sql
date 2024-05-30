--Refrerece type
CREATE OR REPLACE FUNCTION card_banks_ref(card_banks)
  RETURNS json AS
$$
	SELECT json_build_object(
		'keys',json_build_object(
			    
			),	
		'descr',$1.name,
		'dataType','card_banks'
	);
$$
  LANGUAGE sql VOLATILE COST 100;
ALTER FUNCTION card_banks_ref(card_banks) OWNER TO glab;	

