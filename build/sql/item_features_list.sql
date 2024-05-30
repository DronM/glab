-- VIEW: public.item_features_list

--DROP VIEW public.item_features_list;

CREATE OR REPLACE VIEW public.item_features_list AS
	SELECT
		t.id
		,t.name
		,t.name_lat
		,t.comment_text
		--,t.filter_option_type
	FROM public.item_features AS t
	
	ORDER BY name ASC
	;
	
ALTER VIEW public.item_features_list OWNER TO ;
