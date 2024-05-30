-- Trigger: bank_flow_in_before

-- DROP TRIGGER bank_flow_in_before ON public.bank_flow_in;

CREATE TRIGGER bank_flow_in_before
    BEFORE INSERT OR DELETE OR UPDATE 
    ON public.bank_flow_in
    FOR EACH ROW
    EXECUTE PROCEDURE public.bank_flow_in_process();
    
-- Trigger: bank_flow_in_after

--DROP TRIGGER bank_flow_in_after ON public.bank_flow_in;

CREATE TRIGGER bank_flow_in_after
    AFTER INSERT OR DELETE OR UPDATE 
    ON public.bank_flow_in
    FOR EACH ROW
    EXECUTE PROCEDURE public.bank_flow_in_process();    

