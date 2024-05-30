-- VIEW: public.auto_models_list

--DROP VIEW public.auto_models_list;

CREATE OR REPLACE VIEW public.auto_models_list AS
	SELECT
		t.id
		,t.auto_make_id
		,auto_makes_ref(auto_makes_ref_t) AS auto_makes_ref
		,t.name
		,t.name_variants
		,t.popularity_type_id
		,popularity_types_ref(popularity_types_t) AS popularity_types_ref
		,t.vehicle_type_id
		,vehicle_types_ref(vehicle_types_t) AS vehicle_types_ref
		,(SELECT count(*) FROM auto_model_generations AS g WHERE g.auto_model_id = t.id) AS model_generation_count
		,(SELECT count(*) FROM auto_bodies AS b WHERE b.auto_model_id = t.id) AS body_count
		
	FROM public.auto_models AS t
	LEFT JOIN auto_makes AS auto_makes_ref_t ON auto_makes_ref_t.id = t.auto_make_id	
	LEFT JOIN popularity_types AS popularity_types_t ON popularity_types_t.id = t.popularity_type_id
	LEFT JOIN vehicle_types AS vehicle_types_t ON vehicle_types_t.id = t.vehicle_type_id
	LEFT JOIN popularity_types AS make_popularity_types_t ON make_popularity_types_t.id = auto_makes_ref_t.popularity_type_id
	ORDER BY make_popularity_types_t.code DESC, make_popularity_types_t.code DESC, name ASC
	;
	
ALTER VIEW public.auto_models_list OWNER TO ;

