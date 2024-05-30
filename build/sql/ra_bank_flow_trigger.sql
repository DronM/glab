-- before trigger
CREATE TRIGGER ra_bank_flow_before
	BEFORE INSERT OR UPDATE OR DELETE ON ra_bank_flow
	FOR EACH ROW EXECUTE PROCEDURE ra_bank_flow_process();
	
-- after trigger
CREATE TRIGGER ra_bank_flow_after
	AFTER INSERT OR UPDATE OR DELETE ON ra_bank_flow
	FOR EACH ROW EXECUTE PROCEDURE ra_bank_flow_process();

