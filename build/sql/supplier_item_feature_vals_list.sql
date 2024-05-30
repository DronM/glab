-- Function: supplier_item_feature_vals_list(in_supplier_item_id int, in_item_folder_id int)

-- DROP FUNCTION supplier_item_feature_vals_list(in_supplier_item_id int, in_item_folder_id int) CASCADE;


CREATE OR REPLACE FUNCTION supplier_item_feature_vals_list(in_supplier_item_id int, in_item_folder_id int)
  RETURNS TABLE (
  	features json
  ) AS
$$
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
		),
		'filter_option_type', gf.filter_option_type,
		'val', (SELECT val FROM supplier_item_feature_vals WHERE supplier_item_id = in_supplier_item_id AND item_feature_id = f.id)
	)
FROM
(
	SELECT
		unnest(uniq(array_agg(sub2.feature_groups))) AS item_feature_group_id
	FROM (	
		SELECT
			unnest(sub.feature_groups) AS feature_groups
		FROM (
			WITH RECURSIVE r AS (
			   SELECT
					id,
					parent_item_folder_id,
					name,
					(SELECT
						array_agg(item_feature_group_id)
					 FROM supplier_item_folder_feature_groups AS gr
					 WHERE gr.item_folder_id = in_item_folder_id
					) AS feature_groups
			   FROM item_folders
			   WHERE id = in_item_folder_id

			   UNION

			   SELECT
					item_folders.id,
					item_folders.parent_item_folder_id,
					item_folders.name,
					(SELECT
						array_agg(item_feature_group_id)
					 FROM supplier_item_folder_feature_groups AS gr
					 WHERE gr.item_folder_id = item_folders.id
					) AS feature_groups
			   FROM item_folders
			   JOIN r ON item_folders.id = r.parent_item_folder_id
			)

			SELECT * FROM r
		) AS sub
	) AS sub2
) AS sub3
LEFT JOIN item_feature_groups AS gr ON gr.id= sub3.item_feature_group_id
LEFT JOIN item_feature_group_items AS gf ON gf.item_feature_group_id = gr.id
LEFT JOIN item_features AS f ON f.id = gf.item_feature_id
ORDER BY gr.name, gf.code
	--f.filter_option_type NULLS LAST,  f.filter_option_type
;


$$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION supplier_item_feature_vals_list(in_supplier_item_id int, in_item_folder_id int) OWNER TO ;

