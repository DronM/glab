-- Function: auto_to_glass_match_opt_edit(in_auto_to_glass_match_head_id int)

-- DROP FUNCTION auto_to_glass_match_opt_edit(in_auto_to_glass_match_head_id int);

CREATE OR REPLACE FUNCTION auto_to_glass_match_opt_edit(in_auto_to_glass_match_head_id int)
  RETURNS TABLE(
  	eurocode_list json,
  	body_door_list json,
  	body_type_list json,
  	body_model_list json
  ) AS
$$

	WITH
	autos AS (
		SELECT
			auto_body_doors_ref(d) AS body_door,
			auto_body_types_ref(tp) AS body_type,
			g.model AS body_model,
			g.eurocode||'-'||g.local_id AS eurocode
		FROM auto_bodies AS b
		LEFT JOIN auto_model_generations AS g ON g.id = b.auto_model_generation_id
		LEFT JOIN auto_body_doors AS d ON d.id = b.auto_body_door_id
		LEFT JOIN auto_body_types AS tp ON tp.id = b.auto_body_type_id
		WHERE b.id IN (
			SELECT
				unnest(auto_bodies_list)
			FROM auto_to_glass_match_eurocodes
			WHERE auto_to_glass_match_head_id = in_auto_to_glass_match_head_id
		)
		ORDER BY g.eurocode, g.local_id, d.name, tp.name
	)
	SELECT
		(SELECT
				json_agg(
					json_build_object(
						'id', ec.eurocode,
						'checked', FALSE
					)
				)
		FROM (SELECT DISTINCT eurocode FROM autos) AS ec
		) AS eurocode_list
		
		,(SELECT
				json_agg(
					json_build_object(
						'ref', t.body_door,
						'checked', FALSE
					)
				)
		FROM (SELECT DISTINCT body_door::text FROM autos) AS t
		) AS body_door_list	
		
		,(SELECT
				json_agg(
					json_build_object(
						'ref', t.body_type,
						'checked', FALSE
					)
				)
		FROM (SELECT DISTINCT body_type::text FROM autos) AS t
		) AS body_type_list		
		
		,(SELECT
				json_agg(
					json_build_object(
						'name', coalesce(t.body_model, 'Пустое значние'),
						'checked', FALSE
					)
				)
		FROM (SELECT DISTINCT body_model::text FROM autos) AS t
		) AS body_model_list		
	;		
$$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION auto_to_glass_match_opt_edit(in_auto_to_glass_match_head_id int) OWNER TO ;
