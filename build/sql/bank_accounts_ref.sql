--Refrerece type
CREATE OR REPLACE FUNCTION bank_accounts_ref(bank_accounts)
  RETURNS json AS
$$
	SELECT json_build_object(
		'keys',json_build_object(
			'id',$1.id    
			),	
		'descr',$1.name,
		'dataType','bank_accounts'
	);
$$
  LANGUAGE sql VOLATILE COST 100;
ALTER FUNCTION bank_accounts_ref(bank_accounts) OWNER TO ;	
	
