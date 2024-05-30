-- VIEW: public.manufacturers_list

--DROP VIEW public.manufacturers_list;

CREATE OR REPLACE VIEW public.manufacturers_list AS
	SELECT
		t.id
		,t.name
		,t.quality_level
		,(SELECT
			json_agg(
				json_build_object(
					'name', b.name
				)
			)
		FROM manufacturer_brands AS b
		WHERE b.manufacturer_id = t.id) AS brand_list
	FROM public.manufacturers AS t
	
	ORDER BY name ASC
	;
	
ALTER VIEW public.manufacturers_list OWNER TO ;
