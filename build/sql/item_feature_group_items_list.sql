-- VIEW: 

--DROP VIEW item_feature_group_items_list;

CREATE OR REPLACE VIEW item_feature_group_items_list AS
	SELECT
		t.id
		,t.item_feature_group_id
		,t.item_feature_id
		,item_features_ref(item_features_ref_t) AS item_features_ref
		,t.code
		,t.filter_option_type
		,t.for_config
		
	FROM item_feature_group_items AS t
	LEFT JOIN item_features AS item_features_ref_t ON t.item_feature_id = item_features_ref_t.id
	ORDER BY item_features_ref_t.name, t.code
	;
	
ALTER VIEW item_feature_group_items_list OWNER TO ;
