-- VIEW: public.items_list

--DROP VIEW public.items_list;

CREATE OR REPLACE VIEW public.items_list AS
	SELECT
		t.id
		,t.name
		,t.item_folder_id
		,item_folders_ref(item_folders_ref_t) AS item_folders_ref
		,t.manufacturer_brand_id
		,manufacturer_brands_ref(mnfb, mnf) AS manufacturer_brands_ref
		
		,(SELECT
			json_agg(
				json_build_object(
					'id', v_f.id,
					'name', v_f.name,
					'val', v.val,
					'val_type', v_f.value_attrs->>'data_type'
				)
			)
		FROM item_feature_vals AS v
		LEFT JOIN item_features AS v_f ON v_f.id = v.item_feature_id
		WHERE v.item_id = t.id
		) AS item_features_list
		
	FROM public.items AS t
	LEFT JOIN item_folders AS item_folders_ref_t ON item_folders_ref_t.id = t.item_folder_id
	LEFT JOIN manufacturer_brands AS mnfb ON mnfb.id = t.manufacturer_brand_id
	LEFT JOIN manufacturers AS mnf ON mnf.id = mnfb.manufacturer_id
	ORDER BY item_folders_ref_t.code
	;
	
ALTER VIEW public.items_list OWNER TO ;
