--balance on doc

CREATE OR REPLACE FUNCTION rg_bank_flow_balance(in_doc_type doc_types, in_doc_id int,
	
	IN in_bank_account_id_ar int[]
					
	)

  RETURNS TABLE(
	bank_account_id int
	,
	total  numeric(15,2)				
	) AS
$BODY$
	SELECT * FROM rg_bank_flow_balance(
		(SELECT doc_log.date_time FROM doc_log WHERE doc_log.doc_type=in_doc_type AND doc_log.doc_id=in_doc_id),
		in_bank_account_id_ar 				
		);

$BODY$
  LANGUAGE sql VOLATILE CALLED ON NULL INPUT
  COST 100;

ALTER FUNCTION rg_bank_flow_balance(in_doc_type doc_types, in_doc_id int,
	
	IN in_bank_account_id_ar int[]
					
	)
 OWNER TO ;


