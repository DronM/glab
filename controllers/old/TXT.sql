	query := fmt.Sprintf(`SELECT
		it.id AS id,
		coalesce(it.name, '') AS name,		
		auto_makes_ref(a_mk) AS auto_makes_ref,
		auto_models_ref(a_md) AS auto_models_ref,
		auto_model_generations_ref(a_gen) AS auto_model_generations_ref,
		auto_bodies_ref(a_bd) AS auto_bodies_ref,
		item_folders_ref(fld) AS item_folders_ref,
		item_priorities_ref(pr) AS item_priorities_ref,
		(SELECT
			json_agg(
				json_build_object(
						'item_feature_id', gf.item_feature_id,
						'filter_option_type', gf.filter_option_type,
						'item_feature_name', f.name,
						'item_feature_name_lat', f.name_lat
				)		
			)
		FROM (
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
							 FROM item_folder_feature_groups AS gr
							 WHERE gr.item_folder_id = it.item_folder_id
							) AS feature_groups
					   FROM item_folders
					   WHERE id = it.item_folder_id

					   UNION

					   SELECT
							item_folders.id,
							item_folders.parent_item_folder_id,
							item_folders.name,
							(SELECT
								array_agg(item_feature_group_id)
							 FROM item_folder_feature_groups AS gr
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
		WHERE gf.filter_option_type = 'main' OR gf.filter_option_type = 'additional'				
		) AS features_list,
		
		suppliers_ref(sp) AS suppliers_ref,
		s_it.supplier_item_id,
		s_it.cost,
		s_it.sale_price,
		s_it.artikul,
		s_it.comment_text,
		s_it.comment_note,
		(SELECT
			json_agg(
				json_build_object(
					'store_id', st_v.supplier_store_id,
					'store_name', sp_st.name,
					'val', st_v.val
				)
			)
		FROM supplier_store_values AS st_v
		LEFT JOIN supplier_stores AS sp_st ON sp_st.id = st_v.supplier_store_id
		WHERE st_v.supplier_store_id IN (SELECT t.id FROM supplier_stores AS t WHERE t.supplier_id = sp.id)
			AND st_v.supplier_item_id = s_it.id
		) AS stores_list
	FROM supplier_items AS s_it
	LEFT JOIN suppliers AS sp ON sp.id = s_it.supplier_id
	LEFT JOIN items AS it ON it.id = s_it.item_id
	LEFT JOIN auto_makes AS a_mk ON a_mk.id = it.auto_make_id
	LEFT JOIN auto_models AS a_md ON a_md.id = it.auto_model_id
	LEFT JOIN auto_bodies AS a_bd ON a_bd.id = it.auto_body_id
	LEFT JOIN auto_model_generations AS a_gen ON a_gen.id = it.auto_model_generation_id
	LEFT JOIN item_folders AS fld ON fld.id = it.item_folder_id	
	LEFT JOIN item_priorities AS pr ON pr.id = fld.item_priority_id
	LEFT JOIN manufacturer_brands AS mnf_b ON mnf_b.id = it.manufacturer_brand_id
	%s
	%s
	ORDER BY pr.code, it.name
	OFFSET %d LIMIT %d`, opt_join, cond_s, args.From.GetValue(), args.Count.GetValue())

