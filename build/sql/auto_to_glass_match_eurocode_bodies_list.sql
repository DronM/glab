-- VIEW: public.auto_to_glass_match_eurocode_bodies_list

--DROP VIEW public.auto_to_glass_match_eurocode_bodies_list;

CREATE OR REPLACE VIEW public.auto_to_glass_match_eurocode_bodies_list AS
	SELECT
		sub.auto_to_glass_match_head_id
		,b.auto_body_doors_ref->>'descr' AS doors
		,b.auto_body_types_ref->>'descr' AS type
		,b.model AS model
		,gen.eurocode||'-'||gen.local_id AS eurocode_local
	FROM (
		SELECT
			t.auto_to_glass_match_head_id,
			unnest(t.auto_bodies_list) AS auto_body_id
		FROM auto_to_glass_match_eurocodes AS t
	) AS sub
	LEFT JOIN auto_bodies_list AS b ON b.id = sub.auto_body_id
	LEFT JOIN auto_model_generations AS gen ON gen.id = b.auto_model_generation_id
	ORDER BY eurocode_local, doors		
	;
	
ALTER VIEW public.auto_to_glass_match_eurocode_bodies_list OWNER TO ;
