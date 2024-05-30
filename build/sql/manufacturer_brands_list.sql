-- VIEW: public.manufacturer_brands_list

--DROP VIEW public.manufacturer_brands_list;

CREATE OR REPLACE VIEW public.manufacturer_brands_list AS
	SELECT
		t.id
		,t.name
		,t.quality_level
		,manufacturers_ref(manufacturers_ref_t) AS manufacturers_ref
		,t.manufacturer_id
	FROM public.manufacturer_brands AS t
	LEFT JOIN manufacturers AS manufacturers_ref_t ON manufacturers_ref_t.id = t.manufacturer_id
	ORDER BY manufacturers_ref_t.name, t.name ASC
	;
	
ALTER VIEW public.manufacturer_brands_list OWNER TO ;
