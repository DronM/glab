-- Function: items_name(in_item items)

-- DROP FUNCTION items_name(in_item items);

CREATE OR REPLACE FUNCTION items_name(in_item items)
  RETURNS text AS
$$
	SELECT	
		coalesce((SELECT fld.code ||' '||fld.name FROM item_folders AS fld WHERE fld.id = in_item.item_folder_id) ||' ', '')||
		coalesce(
			(SELECT
				manufacturer_brands.name || ' ('||m.name||')'
			FROM manufacturer_brands
			LEFT JOIN manufacturers AS m ON m.id = manufacturer_brands.manufacturer_id
			WHERE manufacturer_brands.id = in_item.manufacturer_brand_id
			) ||' '
		, '')||
		coalesce(
			(SELECT
			STRING_AGG(
				CASE
					WHEN (f.value_attrs->>'data_type')::text = 'dt_list' THEN '[' || f_v.val || ']'
					WHEN (f.value_attrs->>'data_type')::text = 'dt_bool' THEN '[' || (f.value_attrs->>'name')::text || ']'
					WHEN (f.value_attrs->>'data_type')::text = 'dt_float' THEN '[' || (f.value_attrs->>'name')::text || ':' || round(text_to_float_safe_cast(f_v.val),1) || ']'
					ELSE '[' || (f.value_attrs->>'name')::text || ':' || f_v.val::text || ']'
				END
			,' ')
		FROM item_feature_vals AS f_v
		LEFT JOIN item_features AS f ON f.id = f_v.item_feature_id
		WHERE f_v.item_id = in_item.id)
		,'')
		;
$$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION items_name(in_item items) OWNER TO ;
