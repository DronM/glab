-- VIEW: public.manufacturers_dialog

--DROP VIEW public.manufacturers_dialog;

CREATE OR REPLACE VIEW public.manufacturers_dialog AS
	SELECT
		t.id
		,t.name
		,t.quality_level
	FROM public.manufacturers AS t
	
	
	;
	
ALTER VIEW public.manufacturers_dialog OWNER TO ;
