-- Trigger: cash_flow_out_before

-- DROP TRIGGER cash_flow_out_before ON public.cash_flow_out;

CREATE TRIGGER cash_flow_out_before
    BEFORE INSERT OR DELETE OR UPDATE 
    ON public.cash_flow_out
    FOR EACH ROW
    EXECUTE PROCEDURE public.cash_flow_out_process();
    
-- Trigger: cash_flow_out_after

--DROP TRIGGER cash_flow_out_after ON public.cash_flow_out;

CREATE TRIGGER cash_flow_out_after
    AFTER INSERT OR DELETE OR UPDATE 
    ON public.cash_flow_out
    FOR EACH ROW
    EXECUTE PROCEDURE public.cash_flow_out_process();    

