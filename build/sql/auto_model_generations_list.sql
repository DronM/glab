-- VIEW: public.auto_model_generations_list

DROP VIEW public.auto_model_generations_list;

CREATE OR REPLACE VIEW public.auto_model_generations_list AS
	SELECT
		t.id
		,t.auto_model_id
		,auto_models_ref(auto_models_ref_t) AS auto_models_ref
		,auto_models_ref_t.auto_make_id
		,auto_makes_ref(auto_makes_ref_t) AS auto_makes_ref
		,t.generation_num
		,t.prod_index
		,t.year_from
		,t.year_to
		,t.model
		,t.series
		,auto_model_generations_name(t) AS name
		,(SELECT count(*) FROM auto_bodies AS b WHERE b.auto_model_generation_id = t.id) AS body_count
		
	FROM public.auto_model_generations AS t
	LEFT JOIN auto_models AS auto_models_ref_t ON auto_models_ref_t.id = t.auto_model_id
	LEFT JOIN auto_makes AS auto_makes_ref_t ON auto_makes_ref_t.id = auto_models_ref_t.auto_make_id  
	ORDER BY t.generation_num
	
	;
	
ALTER VIEW public.auto_model_generations_list OWNER TO ;

