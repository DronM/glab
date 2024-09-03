-- VIEW: public.fin_expense_types_list

--DROP VIEW public.fin_expense_types_list;

CREATE OR REPLACE VIEW public.fin_expense_types_list AS
	SELECT
		t.id
		,t.parent_id
		,t.name
		,t.deleted
		,t.for_cash
		,t.for_bank
		,t.lev
		
	FROM public.fin_expense_types AS t
	
	ORDER BY name ASC
	;
	
ALTER VIEW public.fin_expense_types_list OWNER TO glab;
