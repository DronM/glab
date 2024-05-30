-- Function: auto_to_glass_match_features(in_item_priority_id int)

-- DROP FUNCTION auto_to_glass_match_features(in_item_priority_id int);

CREATE OR REPLACE FUNCTION auto_to_glass_match_features(in_item_priority_id int)
  RETURNS TABLE (
  	id int,
  	name text,
  	name_lat text,
  	comment_text text,
  	value_attrs jsonb  	
  ) AS
$$
	SELECT
		ft.id,
		ft.name,
		ft.name_lat,
		ft.comment_text,
		ft.value_attrs		
	FROM (
		SELECT
			item_feature_id,
			filter_option_type,
			code
		FROM item_feature_group_items
		WHERE item_feature_group_id IN
			(SELECT id FROM item_feature_groups
			WHERE id IN
				(SELECT item_feature_group_id
				FROM item_folder_feature_groups
				WHERE item_folder_id IN (SELECT id FROM item_folders WHERE item_priority_id = in_item_priority_id)
				)
			)
			AND for_config
		
		UNION ALL
		SELECT
			item_feature_id,
			filter_option_type,
			code
		FROM item_feature_group_items
		WHERE item_feature_group_id IN
			(SELECT id FROM item_feature_groups WHERE id IN
				(SELECT item_feature_group_id
				 FROM supplier_item_folder_feature_groups
				 WHERE item_folder_id IN (SELECT id FROM item_folders WHERE item_priority_id = in_item_priority_id)
				)
			)
			AND for_config
	) AS sub
	LEFT JOIN item_features AS ft ON ft.id = sub.item_feature_id
	ORDER BY
		sub.filter_option_type,
		sub.code
	;	
$$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION auto_to_glass_match_features(in_item_priority_id int) OWNER TO ;
