-- Function: item_feature_vals_as_str(v_item_id int)

-- DROP FUNCTION item_feature_vals_as_str(v_item_id int);

CREATE OR REPLACE FUNCTION item_feature_vals_as_str(v_item_id int)
  RETURNS text AS
$$
	SELECT
		string_agg(s.v, ';')
	FROM (
		SELECT
			f.name_lat||'='||it_f_v.val AS v
		FROM item_feature_vals AS it_f_v
		LEFT JOIN items AS it ON it.id = it_f_v.item_id
		LEFT JOIN item_folder_feature_groups AS gr ON gr.item_folder_id = it.item_folder_id
		LEFT JOIN item_feature_group_items AS gr_it ON gr_it.item_feature_group_id = gr.item_feature_group_id AND gr_it.item_feature_id=it_f_v.item_feature_id
		LEFT JOIN item_features AS f ON f.id = it_f_v.item_feature_id			
		WHERE it_f_v.item_id = v_item_id
		ORDER BY gr_it.code
	) AS s
$$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION item_feature_vals_as_str(v_item_id int) OWNER TO ;
