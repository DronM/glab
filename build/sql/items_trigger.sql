-- Trigger: items_trigger_before on public.items

-- DROP TRIGGER items_trigger_before ON public.items;


CREATE TRIGGER items_trigger_before
  BEFORE INSERT OR UPDATE
  ON public.items
  FOR EACH ROW
  EXECUTE PROCEDURE public.items_process();

