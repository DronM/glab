-- VIEW: public.cash_flow_transfer_list

--DROP VIEW public.cash_flow_transfer_list;

CREATE OR REPLACE VIEW public.cash_flow_transfer_list AS
	SELECT
		t.id
		,t.date_time
		,t.from_cash_location_id
		,cash_locations_ref(from_loc) as from_cash_locations_ref
		,t.to_cash_location_id
		,cash_locations_ref(to_loc) as to_cash_locations_ref
		,t.comment_text
		,users_ref(users_ref_t) AS users_ref
		,t.total
	FROM public.cash_flow_transfers AS t
	LEFT JOIN users AS users_ref_t ON users_ref_t.id = t.user_id
	LEFT JOIN cash_locations AS from_loc ON from_loc.id = t.from_cash_location_id
	LEFT JOIN cash_locations AS to_loc ON to_loc.id = t.to_cash_location_id
	ORDER BY date_time DESC
	;
	
ALTER VIEW public.cash_flow_transfer_list OWNER TO ;
