
SELECT
	ft.id,
	ft.name,
	ft.value_attrs,
	ft.name_lat
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
			WHERE item_folder_id IN (SELECT id FROM item_folders WHERE item_priority_id=1)
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
			 WHERE item_folder_id IN (SELECT id FROM item_folders WHERE item_priority_id=1)
			)
		)
		AND for_config
) AS sub
LEFT JOIN item_features AS ft ON ft.id = sub.item_feature_id
ORDER BY
	sub.filter_option_type,
	sub.code
