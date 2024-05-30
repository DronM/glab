-- ADD
CREATE OR REPLACE FUNCTION ra_cash_flow_add_act(reg_act ra_cash_flow)
RETURNS void AS
$BODY$
	INSERT INTO ra_cash_flow
	(date_time,doc_type,doc_id
	,deb
	,cash_location_id
	,total				
	)
	VALUES (
	$1.date_time,$1.doc_type,$1.doc_id
	,$1.deb
	,$1.cash_location_id				
	,$1.total
	);
$BODY$
LANGUAGE sql VOLATILE STRICT COST 100;

ALTER FUNCTION ra_cash_flow_add_act(reg_act ra_cash_flow) OWNER TO glab;

