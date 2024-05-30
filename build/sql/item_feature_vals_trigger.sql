-- Trigger: item_feature_vals_trigger_after on public.item_feature_vals

 DROP TRIGGER item_feature_vals_trigger_after ON public.item_feature_vals;

/*
CREATE TRIGGER item_feature_vals_trigger_after
  AFTER INSERT OR UPDATE OR DELETE
  ON public.item_feature_vals
  FOR EACH ROW
  EXECUTE PROCEDURE public.item_feature_vals_process();
*/
