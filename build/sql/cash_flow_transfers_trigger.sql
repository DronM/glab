-- Trigger: cash_flow_transfers_before

-- DROP TRIGGER cash_flow_transfers_before ON public.cash_flow_transfers;

CREATE TRIGGER cash_flow_transfers_before
    BEFORE INSERT OR DELETE OR UPDATE 
    ON public.cash_flow_transfers
    FOR EACH ROW
    EXECUTE PROCEDURE public.cash_flow_transfers_process();
    
-- Trigger: cash_flow_transfers_after

--DROP TRIGGER cash_flow_transfers_after ON public.cash_flow_transfers;

CREATE TRIGGER cash_flow_transfers_after
    AFTER INSERT OR DELETE OR UPDATE 
    ON public.cash_flow_transfers
    FOR EACH ROW
    EXECUTE PROCEDURE public.cash_flow_transfers_process();    

