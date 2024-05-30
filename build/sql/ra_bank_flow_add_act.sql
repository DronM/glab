-- ADD
CREATE OR REPLACE FUNCTION ra_bank_flow_add_act(reg_act ra_bank_flow)
RETURNS void AS
$BODY$
	INSERT INTO ra_bank_flow
	(date_time,doc_type,doc_id
	,deb
	,bank_account_id
	,total				
	)
	VALUES (
	$1.date_time,$1.doc_type,$1.doc_id
	,$1.deb
	,$1.bank_account_id
	,$1.total				
	);
$BODY$
LANGUAGE sql VOLATILE STRICT COST 100;

ALTER FUNCTION ra_bank_flow_add_act(reg_act ra_bank_flow) OWNER TO ;

