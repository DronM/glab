-- Trigger: employees_trigger_before on public.employees

-- DROP TRIGGER employees_trigger_before ON public.employees;


CREATE TRIGGER employees_trigger_before
  BEFORE INSERT
  ON public.employees
  FOR EACH ROW
  EXECUTE PROCEDURE public.employees_process();

