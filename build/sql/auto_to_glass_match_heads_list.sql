-- View: public.auto_to_glass_match_heads_list

 DROP VIEW public.auto_to_glass_match_heads_list;

CREATE OR REPLACE VIEW public.auto_to_glass_match_heads_list
AS
	SELECT
		t.id,
		t.date_time,
		t.user_id,
		users_ref(users_ref_t.*) AS users_ref,
		e_codes.user_code_list,
		e_codes.auto_bodies_list
		
	FROM auto_to_glass_match_heads t
	LEFT JOIN users users_ref_t ON users_ref_t.id = t.user_id
	LEFT JOIN (
		SELECT
			t1.auto_to_glass_match_head_id,
			string_agg(t1.user_code, ', ') AS user_code_list,
			jsonb_agg(t1.auto_bodies_list) AS auto_bodies_list
		FROM auto_to_glass_match_eurocodes_list AS t1
		GROUP BY t1.auto_to_glass_match_head_id
	) AS e_codes ON e_codes.auto_to_glass_match_head_id = t.id
	ORDER BY t.date_time DESC;

ALTER TABLE public.auto_to_glass_match_heads_list OWNER TO ;


