-- VIEW: public.firms_dialog

--DROP VIEW public.firms_dialog;

CREATE OR REPLACE VIEW public.firms_dialog AS
	SELECT
		t.id
		,t.name
		,t.inn
	FROM public.firms AS t
	;
	
ALTER VIEW public.firms_dialog OWNER TO ;
