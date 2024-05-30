-- VIEW: public.auto_model_generation_bodies_list

--DROP VIEW public.auto_model_generation_bodies_list;

CREATE OR REPLACE VIEW public.auto_model_generation_bodies_list AS
	SELECT
		t.id
		,t.auto_model_generation_id
		,auto_bodies_ref(auto_bodies_ref_t) AS auto_bodies_ref
		,t.eurocode
		,t.local_id
	FROM public.auto_model_generation_bodies AS t
	LEFT JOIN auto_bodies AS auto_bodies_ref_t ON auto_bodies_ref_t.id = t.auto_body_id
	ORDER BY t.auto_model_generation_id, auto_bodies_ref_t.name
	;
	
ALTER VIEW public.auto_model_generation_bodies_list OWNER TO ;
