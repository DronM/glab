
-- VIEW: public.cash_income_sources_list

DROP VIEW public.cash_income_sources_list;

CREATE OR REPLACE VIEW public.cash_income_sources_list AS
	SELECT
		t.id
		,t.name
		,cash_locations_ref(cash_locations_ref_t) AS cash_locations_ref
	FROM public.cash_income_sources AS t
	LEFT JOIN cash_locations AS cash_locations_ref_t ON cash_locations_ref_t.id = t.cash_location_id
	ORDER BY t.name
	;
	
-- ALTER VIEW public.cash_income_sources_list OWNER TO ;
