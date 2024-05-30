-- Trigger: cash_flow_in_before

-- DROP TRIGGER cash_flow_in_before ON public.cash_flow_in;

CREATE TRIGGER cash_flow_in_before
    BEFORE INSERT OR DELETE OR UPDATE 
    ON public.cash_flow_in
    FOR EACH ROW
    EXECUTE PROCEDURE public.cash_flow_in_process();
    
-- Trigger: cash_flow_in_after

--DROP TRIGGER cash_flow_in_after ON public.cash_flow_in;

CREATE TRIGGER cash_flow_in_after
    AFTER INSERT OR DELETE OR UPDATE 
    ON public.cash_flow_in
    FOR EACH ROW
    EXECUTE PROCEDURE public.cash_flow_in_process();    

