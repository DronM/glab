-- VIEW: public.users_list

--DROP VIEW public.users_list;

CREATE OR REPLACE VIEW public.users_list AS
	SELECT
		t.id
		,t.name
		,t.role_id
		
		,(SELECT
			m_log.date_time
		FROM object_mod_log AS m_log
		WHERE m_log.object_type = 'users' AND m_log.object_id = t.id
		ORDER BY m_log.date_time DESC
		LIMIT 1
		) AS last_update
		
		,(SELECT
			m_log.user_descr
		FROM object_mod_log AS m_log
		WHERE m_log.object_type = 'users' AND m_log.object_id = t.id
		ORDER BY m_log.date_time DESC
		LIMIT 1
		) AS last_update_user
		
		
	FROM public.users AS t
	
	ORDER BY t.name ASC
	;
	
ALTER VIEW public.users_list OWNER TO ;

