--select * from supplier_item_feature_vals
SELECT
	s.supplier_item_id,
	s.feature_list
FROM (
	SELECT
		f_vals.supplier_item_id,
		jsonb_agg(
			jsonb_build_object(
					'item_feature_id', f_vals.item_feature_id,
					'val', f_vals.val
			)			
		) ||
		(SELECT
			jsonb_agg(
				jsonb_build_object(
						'item_feature_id', it_f_vals.item_feature_id,
						'val', it_f_vals.val
				)			
			) AS f
		FROM item_feature_vals as it_f_vals
		WHERE it_f_vals.item_id = s_it.item_id
		)
		
		AS feature_list
	FROM supplier_item_feature_vals as f_vals
	LEFT JOIN supplier_items AS s_it ON s_it.id = f_vals.supplier_item_id
	GROUP BY f_vals.supplier_item_id, s_it.item_id
) AS s
WHERE
	s.feature_list @> 
	(SELECT
		jsonb_agg(
			jsonb_build_object(
				'item_feature_id', (s.opts->>'id')::int,
				'val', s.opts->>'val'
			)
		)
	FROM (
		SELECT
			jsonb_array_elements(auto_to_glass_match_options.option_list) AS opts
		FROM auto_to_glass_match_options
		WHERE auto_to_glass_match_options.id = 21
	) AS s
	WHERE s.opts->>'val'<>'false')

----WHERE s.f @> '[{"id_19": "ОП"}]'::jsonb

--***************************
--SELECT * FROM auto_to_glass_match_options
SELECT
	b.id
FROM auto_bodies AS b
LEFT JOIN auto_model_generations AS gen ON gen.id = b.auto_model_generation_id
WHERE b.auto_model_generation_id IN (
	SELECT
		gn.id
	FROM(
		SELECT
			unnest(eurocode_list) As eurocode
		FROM auto_to_glass_match_options
		WHERE id=21
	) AS s
	LEFT JOIN auto_model_generations AS gn ON gn.eurocode||'-'||gn.local_id=s.eurocode
)
AND b.auto_body_type_id IN (
	SELECT
		(json_array_elements(body_type_list)->>'id')::int AS body_type_id
	FROM auto_to_glass_match_options
	WHERE id=21
)
AND b.auto_body_door_id IN (
	SELECT
		(json_array_elements(body_door_list)->>'id')::int AS body_door_id
	FROM auto_to_glass_match_options
	WHERE id=21
)
AND b.auto_body_door_id IN (
	SELECT
		(json_array_elements(body_door_list)->>'id')::int AS body_door_id
	FROM auto_to_glass_match_options
	WHERE id=21
)

AND gen.model IN (
	SELECT
		unnest(body_model_list) As eurocode
	FROM auto_to_glass_match_options
	WHERE id=21
)


--************************
SELECT
	s.supplier_item_id,
	s.feature_list,
	b.id AS body_id,
	21 AS auto_to_glass_match_option_id
FROM (
	SELECT
		f_vals.supplier_item_id,
		jsonb_agg(
			jsonb_build_object(
					'item_feature_id', f_vals.item_feature_id,
					'val', f_vals.val
			)			
		) ||
		(SELECT
			jsonb_agg(
				jsonb_build_object(
						'item_feature_id', it_f_vals.item_feature_id,
						'val', it_f_vals.val
				)			
			) AS f
		FROM item_feature_vals as it_f_vals
		WHERE it_f_vals.item_id = s_it.item_id
		)
		
		AS feature_list
	FROM supplier_item_feature_vals as f_vals
	LEFT JOIN supplier_items AS s_it ON s_it.id = f_vals.supplier_item_id
	GROUP BY f_vals.supplier_item_id, s_it.item_id
) AS s
CROSS JOIN (
		SELECT
			b.id
		FROM auto_bodies AS b
		LEFT JOIN auto_model_generations AS gen ON gen.id = b.auto_model_generation_id
		WHERE b.auto_model_generation_id IN (
			SELECT
				gn.id
			FROM(
				SELECT
					unnest(eurocode_list) As eurocode
				FROM auto_to_glass_match_options
				WHERE id=21
			) AS s
			LEFT JOIN auto_model_generations AS gn ON gn.eurocode||'-'||gn.local_id=s.eurocode
		)
		AND b.auto_body_type_id IN (
			SELECT
				(json_array_elements(body_type_list)->>'id')::int AS body_type_id
			FROM auto_to_glass_match_options
			WHERE id=21
		)
		AND b.auto_body_door_id IN (
			SELECT
				(json_array_elements(body_door_list)->>'id')::int AS body_door_id
			FROM auto_to_glass_match_options
			WHERE id=21
		)
		AND b.auto_body_door_id IN (
			SELECT
				(json_array_elements(body_door_list)->>'id')::int AS body_door_id
			FROM auto_to_glass_match_options
			WHERE id=21
		)

		AND gen.model IN (
			SELECT
				unnest(body_model_list) As eurocode
			FROM auto_to_glass_match_options
			WHERE id=21
		)
	
) AS b
WHERE
	s.feature_list @> 
	(SELECT
		jsonb_agg(
			jsonb_build_object(
				'item_feature_id', (s.opts->>'id')::int,
				'val', s.opts->>'val'
			)
		)
	FROM (
		SELECT
			jsonb_array_elements(auto_to_glass_match_options.option_list) AS opts
		FROM auto_to_glass_match_options
		WHERE auto_to_glass_match_options.id = 21
	) AS s
	WHERE s.opts->>'val'<>'false')

