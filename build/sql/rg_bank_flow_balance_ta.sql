--TA balance

CREATE OR REPLACE FUNCTION rg_bank_flow_balance(
	
	IN in_bank_account_id_ar int[]
					
	)

  RETURNS TABLE(
	bank_account_id int
	,
	total  numeric(15,2)				
	) AS
$BODY$
	SELECT
		
		b.bank_account_id
		,b.total AS total				
	FROM rg_bank_flow AS b
	WHERE b.date_time=reg_current_balance_time()
		
		AND (in_bank_account_id_ar IS NULL OR ARRAY_LENGTH(in_bank_account_id_ar,1) IS NULL OR (b.bank_account_id=ANY(in_bank_account_id_ar)))
		
		AND(
		b.total<>0
		)
	ORDER BY
		
		b.bank_account_id;
$BODY$
  LANGUAGE sql VOLATILE CALLED ON NULL INPUT
  COST 100;

ALTER FUNCTION rg_bank_flow_balance(
	
	IN in_bank_account_id_ar int[]
					
	)
 OWNER TO ;

