-- VIEW: public.supplier_stores_list

--DROP VIEW public.supplier_stores_list;

CREATE OR REPLACE VIEW public.supplier_stores_list AS
	SELECT
		t.id
		,t.supplier_id
		,suppliers_ref_t.name AS supplier_name
		,suppliers_ref(suppliers_ref_t) AS suppliers_ref
		,t.name
		,t.name_api
	FROM public.supplier_stores AS t
	LEFT JOIN suppliers AS suppliers_ref_t ON suppliers_ref_t.id = t.supplier_id
	ORDER BY suppliers_ref_t.name, t.name
	;
	
ALTER VIEW public.supplier_stores_list OWNER TO ;
