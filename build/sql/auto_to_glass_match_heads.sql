-- VIEW: public.auto_to_glass_match_heads_list

--DROP VIEW public.auto_to_glass_match_heads_list;

CREATE OR REPLACE VIEW public.auto_to_glass_match_heads_list AS
	SELECT
		t.id
		,t.date_time
		,t.user_id
		,users_ref(users_ref_t) AS users_ref
	FROM public.auto_to_glass_match_heads AS t
	LEFT JOIN users AS users_ref_t ON users_ref_t.id = t.user_id
	ORDER BY t.date_time DESC
	;
	
ALTER VIEW public.auto_to_glass_match_heads_list OWNER TO ;
