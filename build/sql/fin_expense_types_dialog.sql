-- VIEW: public.fin_expense_types_dialog

--DROP VIEW public.fin_expense_types_dialog;

CREATE OR REPLACE VIEW public.fin_expense_types_dialog AS
	SELECT
		t.id
		,fin_expense_types_ref(p) AS parents_ref
		,t.name
		,t.for_cash
		,t.for_bank
		,t.bank_match_rule
		,t.deleted
		,t.lev
	FROM public.fin_expense_types AS t
	LEFT JOIN fin_expense_types AS p ON p.id = t.parent_id
	;
	
ALTER VIEW public.fin_expense_types_dialog OWNER TO ;
