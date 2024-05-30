-- VIEW: public.auto_to_glass_match_eurocodes_list

--DROP VIEW public.auto_to_glass_match_eurocodes_list;

CREATE OR REPLACE VIEW public.auto_to_glass_match_eurocodes_list AS
	SELECT
		t.id
		,t.auto_to_glass_match_head_id
		,t.user_code
		,(SELECT
			jsonb_agg(
				jsonb_build_object(
					'auto_make', auto_makes_ref_t.name,
					'auto_model', auto_models_ref_t.name,
					'auto_model_generation_num', auto_model_generations_ref_t.generation_num,
					'auto_model_generation_series', auto_model_generations_ref_t.series,
					'auto_model_generation_year_from', auto_model_generations_ref_t.year_from,
					'auto_model_generation_year_to', auto_model_generations_ref_t.year_to,
					'auto_model_generation_model', auto_model_generations_ref_t.model,
					'eurocode', auto_model_generations_ref_t.eurocode,
					'local_id', auto_model_generations_ref_t.local_id
				)
			)
		FROM auto_bodies_list AS auto_b
		LEFT JOIN auto_model_generations AS auto_model_generations_ref_t ON auto_model_generations_ref_t.id = auto_b.auto_model_generation_id
		LEFT JOIN auto_models AS auto_models_ref_t ON auto_models_ref_t.id = auto_model_generations_ref_t.auto_model_id
		LEFT JOIN auto_makes AS auto_makes_ref_t ON auto_makes_ref_t.id = auto_models_ref_t.auto_make_id		
		WHERE auto_b.id IN (SELECT unnest(t.auto_bodies_list))
		) AS auto_bodies_list
		
	FROM public.auto_to_glass_match_eurocodes AS t
	ORDER BY t.user_code
	;
	
ALTER VIEW public.auto_to_glass_match_eurocodes_list OWNER TO ;
