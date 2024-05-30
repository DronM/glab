-- VIEW: public.supplier_store_values_list

--DROP VIEW public.supplier_store_values_list;

CREATE OR REPLACE VIEW public.supplier_store_values_list AS
	SELECT
		t.id
		,t.supplier_store_id
		,supplier_stores_ref(supplier_stores_ref_t) AS supplier_stores_ref
		,t.supplier_item_id
		,json_build_object(
			'keys', json_build_object('id', t.supplier_item_id),
			'descr', items_ref_t.name,
			'dataType', 'supplier_items_ref'
		) AS supplier_items_ref
		,t.val
	FROM public.supplier_store_values AS t
	LEFT JOIN supplier_stores AS supplier_stores_ref_t ON supplier_stores_ref_t.id = t.supplier_store_id
	LEFT JOIN supplier_items AS supplier_items_ref_t ON supplier_items_ref_t.id = t.supplier_item_id
	LEFT JOIN items AS items_ref_t ON items_ref_t.id = supplier_items_ref_t.item_id
	ORDER BY supplier_stores_ref_t.name, items_ref_t.name
	
	;
	
ALTER VIEW public.supplier_store_values_list OWNER TO ;
