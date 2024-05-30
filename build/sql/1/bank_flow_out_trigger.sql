-- Trigger: bank_flow_out_before

-- DROP TRIGGER bank_flow_out_before ON public.bank_flow_out;

CREATE TRIGGER bank_flow_out_before
    BEFORE INSERT OR DELETE OR UPDATE 
    ON public.bank_flow_out
    FOR EACH ROW
    EXECUTE PROCEDURE public.bank_flow_out_process();
    
-- Trigger: bank_flow_out_after

--DROP TRIGGER bank_flow_out_after ON public.bank_flow_out;

CREATE TRIGGER bank_flow_out_after
    AFTER INSERT OR DELETE OR UPDATE 
    ON public.bank_flow_out
    FOR EACH ROW
    EXECUTE PROCEDURE public.bank_flow_out_process();    

