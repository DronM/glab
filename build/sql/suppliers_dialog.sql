-- VIEW: public.suppliers_dialog

--DROP VIEW public.suppliers_dialog;

CREATE OR REPLACE VIEW public.suppliers_dialog AS
	SELECT
		t.id
		,t.name
	FROM public.suppliers AS t
	
	
	;
	
ALTER VIEW public.suppliers_dialog OWNER TO ;
