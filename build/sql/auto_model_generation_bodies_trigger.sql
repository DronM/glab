-- Trigger: auto_model_generation_bodies_trigger_before on public.auto_model_generation_bodies

-- DROP TRIGGER auto_model_generation_bodies_trigger_before ON public.auto_model_generation_bodies;


CREATE TRIGGER auto_model_generation_bodies_trigger_before
  BEFORE INSERT OR UPDATE
  ON public.auto_model_generation_bodies
  FOR EACH ROW
  EXECUTE PROCEDURE public.auto_model_generation_bodies_process();

