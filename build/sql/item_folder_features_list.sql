-- VIEW: public.item_folder_features_list

DROP VIEW public.item_folder_features_list;

CREATE OR REPLACE VIEW public.item_folder_features_list AS
	SELECT
		t.id
		,t.item_folder_id
		,t.item_feature_id
		,item_features_ref_t.name AS item_feature_name
		,item_features_ref(item_features_ref_t) AS item_features_ref
		,item_features_ref_t.value_attrs->>'data_type' AS item_feature_data_type
	FROM public.item_folder_features AS t
	LEFT JOIN item_features AS item_features_ref_t ON item_features_ref_t.id = t.item_feature_id
	ORDER BY item_feature_name ASC
	;
	
ALTER VIEW public.item_folder_features_list OWNER TO ;

