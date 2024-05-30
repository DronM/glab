-- Trigger: auto_to_glass_match_options_trigger_before on public.auto_to_glass_match_options
/*
 DROP TRIGGER auto_to_glass_match_options_trigger_before ON public.auto_to_glass_match_options;


CREATE TRIGGER auto_to_glass_match_options_trigger_before
  BEFORE INSERT OR UPDATE OR DELETE
  ON public.auto_to_glass_match_options
  FOR EACH ROW
  EXECUTE PROCEDURE public.auto_to_glass_match_options_process();
*/

/*
-- Trigger: auto_to_glass_match_options_trigger_after on public.auto_to_glass_match_options

 DROP TRIGGER auto_to_glass_match_options_trigger_after ON public.auto_to_glass_match_options;


CREATE TRIGGER auto_to_glass_match_options_trigger_after
  AFTER DELETE OR INSERT OR UPDATE
  ON public.auto_to_glass_match_options
  FOR EACH ROW
  EXECUTE PROCEDURE public.auto_to_glass_match_options_process();
*/
