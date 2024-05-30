-- VIEW: item_features_filter_list

--DROP VIEW item_features_filter_list;

CREATE OR REPLACE VIEW item_features_filter_list AS
	SELECT
		json_build_object(
			'item_feature_groups_ref', json_build_object(
				'keys', json_build_object('id', gr.id),
				'descr', gr.name			
			),
			'item_features_ref', json_build_object(
				'keys', json_build_object('id', f.id),
				'descr', f.name
			),
			'item_features_attrs', json_build_object(
				'value_attrs', f.value_attrs::json,
				'comment_text', f.comment_text
			)
		) AS features
	FROM item_features AS f
	LEFT JOIN item_feature_group_items AS gr_it ON gr_it.item_feature_id = f.id
	LEFT JOIN item_feature_groups AS gr ON gr.id = gr_it.item_feature_group_id
	ORDER BY f.filter_option_type, gr.name, f.name
	;	
	
ALTER VIEW item_features_filter_list OWNER TO ;

