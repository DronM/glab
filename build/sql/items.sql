-- VIEW: public.items

--DROP VIEW public.items;

CREATE OR REPLACE VIEW public.items AS
	SELECT
		t.id
		,t.name
		,t.item_folder_id
		,t.auto_make_id
		,t.auto_model_id
		,t.auto_model_generation_id
		,t.auto_body_id
	FROM public. AS t
	
	
	;
	
ALTER VIEW public.items OWNER TO ;
