-- VIEW: public.item_folder_features_dialog

--DROP VIEW public.item_folder_features_dialog;

CREATE OR REPLACE VIEW public.item_folder_features_dialog AS
	SELECT
		t.id
		,t.item_folder_id
		,item_features_ref(item_features_ref_t) AS item_features_ref
		,item_features_ref_t.value_attrs->>'data_type' AS item_feature_data_type
		--,item_features_ref_t.list_values AS item_feature_list_values
	FROM public.item_folder_features AS t
	LEFT JOIN item_features AS item_features_ref_t ON item_features_ref_t.id = t.item_feature_id
	;
	
ALTER VIEW public.item_folder_features_dialog OWNER TO ;

