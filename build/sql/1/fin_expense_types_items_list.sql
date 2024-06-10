-- VIEW: public.fin_expense_types_items_list

--DROP VIEW public.fin_expense_types_items_list;

CREATE OR REPLACE VIEW public.fin_expense_types_items_list AS
	SELECT
		item.id,
		par1.id AS parent1_id,
		par2.id AS parent2_id,
		fin_expense_types_ref(par1) AS parents1_ref,
		fin_expense_types_ref(par2) AS parents2_ref,
		item.name
	FROM fin_expense_types AS item
	LEFT JOIN fin_expense_types AS par2 ON par2.id = item.parent_id
	LEFT JOIN fin_expense_types AS par1 ON par1.id = par2.parent_id
	WHERE par1.id IS NOT NULL
	ORDER BY item.name
	;
	
ALTER VIEW public.fin_expense_types_items_list OWNER TO glab;
