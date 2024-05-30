-- Function: auto_to_glass_match_options_process()

-- DROP FUNCTION auto_to_glass_match_options_process();

CREATE OR REPLACE FUNCTION auto_to_glass_match_options_process()
  RETURNS trigger AS
$BODY$
BEGIN
	IF TG_WHEN='BEFORE' AND TG_OP='INSERT' THEN
		
		NEW.line_num = coalesce(
			(SELECT max(t.line_num)
			FROM auto_to_glass_match_options AS t
			WHERE t.auto_to_glass_match_head_id = NEW.auto_to_glass_match_head_id AND t.item_priority_id = NEW.item_priority_id
			)
		,0) + 1;
		
		RETURN NEW;
	
	ELSIF TG_WHEN='BEFORE' AND TG_OP='DELETE' THEN	
		DELETE FROM auto_to_glass_match_supplier_items WHERE auto_to_glass_match_option_id = NEW.id;
		RETURN OLD;

	ELSIF TG_WHEN='BEFORE' AND TG_OP='UPDATE' THEN	
		DELETE FROM auto_to_glass_match_supplier_items WHERE auto_to_glass_match_option_id = NEW.id;
		
		RETURN NEW;
	
	ELSIF TG_WHEN='AFTER' AND (TG_OP='INSERT' OR TG_OP='UPDATE') THEN	
		INSERT INTO auto_to_glass_match_supplier_items
		(auto_to_glass_match_option_id, supplier_item_id, auto_body_id, auto_model_generation_id, auto_model_id, auto_make_id,
		feature_list, quality_level, item_priority_id)
		SELECT
			NEW.id,
			s.supplier_item_id,
			b.auto_body_id,
			b.auto_model_generation_id,
			b.auto_model_id,
			b.auto_make_id,
			s.feature_list,
			s.quality_level,
			NEW.item_priority_id
			
		FROM (
			SELECT
				f_vals.supplier_item_id,
				mnf_b.quality_level,
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
			LEFT JOIN items AS it ON it.id = s_it.id
			LEFT JOIN manufacturer_brands AS mnf_b ON mnf_b.id = it.manufacturer_brand_id
			GROUP BY
				f_vals.supplier_item_id,
				s_it.item_id,
				mnf_b.quality_level
		) AS s
		CROSS JOIN (
				SELECT
					b.id AS auto_body_id,
					b.auto_model_generation_id,
					gen.auto_model_id,
					md.auto_make_id
				FROM auto_bodies AS b
				LEFT JOIN auto_model_generations AS gen ON gen.id = b.auto_model_generation_id
				LEFT JOIN auto_models AS md ON md.id = gen.auto_model_id
				LEFT JOIN auto_makes AS mk ON mk.id = md.auto_make_id
				WHERE b.auto_model_generation_id IN (
					SELECT
						gn.id
					FROM(
						SELECT unnest(NEW.eurocode_list) AS eurocode
					) AS s
					LEFT JOIN auto_model_generations AS gn ON gn.eurocode||'-'||gn.local_id=s.eurocode
				)
				AND b.auto_body_type_id IN (
					SELECT
						(json_array_elements(NEW.body_type_list)->>'id')::int AS body_type_id
				)
				AND b.auto_body_door_id IN (
					SELECT
						(json_array_elements(NEW.body_door_list)->>'id')::int AS body_door_id
				)
				AND b.auto_body_door_id IN (
					SELECT
						(json_array_elements(NEW.body_door_list)->>'id')::int AS body_door_id
				)

				AND gen.model IN (
					SELECT
						unnest(NEW.body_model_list) As eurocode
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
					jsonb_array_elements(NEW.option_list) AS opts
			) AS s
			WHERE s.opts->>'val'<>'false')
		;
	
		RETURN NEW;
		
	ELSIF TG_WHEN='AFTER' AND TG_OP='DELETE' THEN	
		IF OLD.line_num >= 1 THEN
			UPDATE auto_to_glass_match_options
			SET line_num = line_num - 1
			WHERE
				auto_to_glass_match_head_id = NEW.auto_to_glass_match_head_id
				AND item_priority_id = NEW.item_priority_id
				AND line_num > OLD.line_num;
		END IF;
		
		RETURN OLD;
	END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION auto_to_glass_match_options_process()
  OWNER TO ;

