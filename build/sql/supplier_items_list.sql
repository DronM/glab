-- VIEW: public.supplier_items_list

--DROP VIEW public.supplier_items_list;

CREATE OR REPLACE VIEW public.supplier_items_list AS
	SELECT
		t.id
		,t.item_id
		,items_ref(items_ref_t) AS items_ref
		,item_folders_ref(item_folders_ref_t) AS item_folders_ref
		,t.supplier_id
		,suppliers_ref(suppliers_ref_t) AS suppliers_ref
		,t.supplier_item_id
		,t.cost
		,t.sale_price
		,t.artikul
		
	FROM public.supplier_items AS t
	LEFT JOIN items AS items_ref_t ON items_ref_t.id = t.item_id
	LEFT JOIN item_folders AS item_folders_ref_t ON item_folders_ref_t.id = items_ref_t.item_folder_id
	LEFT JOIN suppliers AS suppliers_ref_t ON suppliers_ref_t.id = t.supplier_id
	ORDER BY items_ref_t.name	
	
	;
	
ALTER VIEW public.supplier_items_list OWNER TO ;
