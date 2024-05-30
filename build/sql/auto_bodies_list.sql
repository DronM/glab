-- VIEW: public.auto_bodies_list

--DROP VIEW public.auto_bodies_list CASCADE;

CREATE OR REPLACE VIEW public.auto_bodies_list AS
	SELECT
		t.id
		,t.name
		,t.auto_model_id
		,auto_models_ref(auto_models_ref_t) AS auto_models_ref		
		,t.auto_body_type_id
		,auto_body_types_ref(auto_body_types_ref_t) AS auto_body_types_ref
		,auto_body_doors_ref(auto_body_doors_ref_t) AS auto_body_doors_ref
		,t.year_from
		,t.year_to
		,t.model
		,auto_price_categories_ref(pr_cat) AS auto_price_categories_ref
		,t.auto_body_size
		,t.complexity_film_body
		,t.complexity_film_front
		,t.complexity_film_back
		,t.complexity_glass
		
	FROM public.auto_bodies AS t
	LEFT JOIN auto_models AS auto_models_ref_t ON auto_models_ref_t.id = t.auto_model_id
	LEFT JOIN auto_body_types AS auto_body_types_ref_t ON auto_body_types_ref_t.id = t.auto_body_type_id
	LEFT JOIN auto_body_doors AS auto_body_doors_ref_t ON auto_body_doors_ref_t.id = t.auto_body_door_id
	LEFT JOIN auto_price_categories AS pr_cat ON pr_cat.id = t.auto_price_category_id
	
	ORDER BY auto_models_ref_t.name, t.name
	;
	
ALTER VIEW public.auto_bodies_list OWNER TO ;

