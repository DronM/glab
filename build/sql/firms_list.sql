-- VIEW: public.firms_list

--DROP VIEW public.firms_list;

CREATE OR REPLACE VIEW public.firms_list AS
	SELECT
		t.id
		,t.name
		,t.inn
	FROM public.firms AS t
	
	ORDER BY name ASC
	;
	
ALTER VIEW public.firms_list OWNER TO ;
