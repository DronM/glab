-- VIEW: public.auto_makes_list

--DROP VIEW public.auto_makes_list;

CREATE OR REPLACE VIEW public.auto_makes_list AS
	SELECT
		t.id
		,t.name
		,t.name_variants
		,(SELECT
			jsonb_agg(
				att.content_info || jsonb_build_object('dataBase64',encode(att.content_data, 'base64'))
			)
		FROM attachments att
		WHERE att.ref->>'dataType' = 'auto_makes' AND (att.ref->'keys'->>'id')::int = t.id
		) AS logo
		
		,popularity_types_ref(pop) AS popularity_types_ref
		,t.popularity_type_id
		,(SELECT count(*) FROM auto_models AS md WHERE md.auto_make_id = t.id) AS model_count
		
	FROM public.auto_makes AS t
	LEFT JOIN popularity_types AS pop ON pop.id = t.popularity_type_id
	ORDER BY pop.code DESC, t.name
	;
	
ALTER VIEW public.auto_makes_list OWNER TO ;
