-- VIEW: public.supplier_item_folder_feature_groups_list

--DROP VIEW public.supplier_item_folder_feature_groups_list;

CREATE OR REPLACE VIEW public.supplier_item_folder_feature_groups_list AS
	SELECT
		t.id
		,t.item_folder_id
		,t.item_feature_group_id
		,item_feature_groups_ref(item_feature_groups_ref_t) AS item_feature_groups_ref
	FROM public.supplier_item_folder_feature_groups AS t
	LEFT JOIN item_feature_groups AS item_feature_groups_ref_t ON item_feature_groups_ref_t.id = t.item_feature_group_id
	;
	
ALTER VIEW public.supplier_item_folder_feature_groups_list OWNER TO ;
