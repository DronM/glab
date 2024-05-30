-- REMOVE
CREATE OR REPLACE FUNCTION ra_cash_flow_remove_acts(in_doc_type doc_types,in_doc_id int)
RETURNS void AS
$BODY$
	DELETE FROM ra_cash_flow
	WHERE doc_type=$1 AND doc_id=$2;
$BODY$
LANGUAGE sql VOLATILE STRICT COST 100;

ALTER FUNCTION ra_cash_flow_remove_acts(in_doc_type doc_types,in_doc_id int) OWNER TO glab;

