-- VIEW: public.suppliers_list

--DROP VIEW public.suppliers_list;

CREATE OR REPLACE VIEW public.suppliers_list AS
	SELECT
		t.id
		,t.name
	FROM public.suppliers AS t
	
	ORDER BY name ASC
	;
	
ALTER VIEW public.suppliers_list OWNER TO ;
