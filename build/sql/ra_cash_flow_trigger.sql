-- before trigger
CREATE TRIGGER ra_cash_flow_before
	BEFORE INSERT OR UPDATE OR DELETE ON ra_cash_flow
	FOR EACH ROW EXECUTE PROCEDURE ra_cash_flow_process();
	
-- after trigger
CREATE TRIGGER ra_cash_flow_after
	AFTER INSERT OR UPDATE OR DELETE ON ra_cash_flow
	FOR EACH ROW EXECUTE PROCEDURE ra_cash_flow_process();

