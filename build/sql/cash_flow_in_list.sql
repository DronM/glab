-- VIEW: public.cash_flow_in_list

DROP VIEW public.cash_flow_in_list;

CREATE OR REPLACE VIEW public.cash_flow_in_list AS
	SELECT
		t.id
		,t.date_time
		,t.cash_location_id
		,cash_locations_ref(cash_locations_ref_t) AS cash_locations_ref
		,t.comment_text
		,users_ref(users_ref_t) AS users_ref
		,t.total
		,t.cash_flow_income_type
		,cash_income_sources_ref(cash_income_sources_ref_t) AS cash_income_sources_ref
	FROM public.cash_flow_in AS t
	LEFT JOIN cash_locations AS cash_locations_ref_t ON cash_locations_ref_t.id = t.cash_location_id
	LEFT JOIN cash_income_sources AS cash_income_sources_ref_t ON cash_income_sources_ref_t.id = t.cash_income_source_id
	LEFT JOIN users AS users_ref_t ON users_ref_t.id = t.user_id
	ORDER BY t.date_time DESC
	;
	
ALTER VIEW public.cash_flow_in_list OWNER TO ;
