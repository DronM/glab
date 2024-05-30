-- Trigger: auto_to_glass_match_eurocodes_trigger_before on public.auto_to_glass_match_eurocodes

-- DROP TRIGGER auto_to_glass_match_eurocodes_trigger_before ON public.auto_to_glass_match_eurocodes;


CREATE TRIGGER auto_to_glass_match_eurocodes_trigger_before
  BEFORE INSERT OR UPDATE OR DELETE
  ON public.auto_to_glass_match_eurocodes
  FOR EACH ROW
  EXECUTE PROCEDURE public.auto_to_glass_match_eurocodes_process();

