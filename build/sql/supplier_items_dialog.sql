-- VIEW: public.supplier_items_dialog

--DROP VIEW public.supplier_items_dialog;

CREATE OR REPLACE VIEW public.supplier_items_dialog AS
	SELECT
		t.id
		,t.item_id
		,items_ref(items) AS items_ref
		,item_folders_ref(item_folders_ref_t) AS item_folders_ref
		,items_dialog.name AS item_name
		--,items_dialog.features_list AS item_features_list
		,items_dialog.manufacturers_ref AS item_manufacturers_ref
		,suppliers_ref(suppliers_ref_t) AS suppliers_ref
		,t.cost
		,t.sale_price
		
		,(SELECT
			jsonb_agg(
				att.content_info || jsonb_build_object('dataBase64', encode(att.content_preview, 'base64'))
			)
		FROM attachments att
		WHERE att.ref->>'dataType' = 'supplier_items' AND (att.ref->'keys'->>'id')::int = t.id
		) AS pictures
		
		,t.artikul
		,t.comment_text
		,t.comment_note
		,t.supplier_item_id
		
		,(SELECT
			json_agg(f.features)
		FROM supplier_item_feature_vals_list(t.id, items.item_folder_id) AS f
		) AS supplier_features_list
		
	FROM public.supplier_items AS t
	LEFT JOIN items ON items.id = t.item_id
	LEFT JOIN items_dialog ON items_dialog.id = t.item_id
	LEFT JOIN item_folders AS item_folders_ref_t ON item_folders_ref_t.id = items.item_folder_id
	LEFT JOIN suppliers AS suppliers_ref_t ON suppliers_ref_t.id = t.supplier_id
	ORDER BY items.name	
	
	;
	
ALTER VIEW public.supplier_items_dialog OWNER TO ;
