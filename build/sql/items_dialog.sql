-- VIEW: public.items_dialog

--DROP VIEW public.items_dialog CASCADE;

CREATE OR REPLACE VIEW public.items_dialog AS
	SELECT
		t.id
		,t.name
		,item_folders_ref(item_folders_ref_t) AS item_folders_ref
		,manufacturer_brands_ref(mnfb, mnf) AS manufacturer_brands_ref
		,manufacturers_ref(mnf) AS manufacturers_ref
		,(SELECT
			json_agg(f.features)
		FROM item_feature_vals_list(t.id, t.item_folder_id) AS f
		) AS features_list
		
		,(SELECT
			jsonb_agg(
				att.content_info || jsonb_build_object('dataBase64',encode(att.content_preview, 'base64'))
			)
		FROM attachments att
		WHERE att.ref->>'dataType' = 'items' AND (att.ref->'keys'->>'id')::int = t.id
		) AS pictures
		
	FROM public.items AS t
	LEFT JOIN item_folders AS item_folders_ref_t ON item_folders_ref_t.id = t.item_folder_id
	LEFT JOIN manufacturers AS mnf ON mnf.id = t.manufacturer_id
	LEFT JOIN manufacturer_brands AS mnfb ON mnfb.id = t.manufacturer_brand_id
	;
	
ALTER VIEW public.items_dialog OWNER TO ;
