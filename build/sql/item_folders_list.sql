-- VIEW: public.item_folders_list

--DROP VIEW public.item_folders_list;

CREATE OR REPLACE VIEW public.item_folders_list AS
	SELECT
		t.id
		,t.name
		,t.parent_item_folder_id
		,t.code
		,(
			SELECT
				json_agg(item_feature_groups_ref)
			FROM item_folder_feature_groups_list AS l
			WHERE l.item_folder_id = t.id
		) AS item_feature_groups_list
		,(
			SELECT
				json_agg(item_feature_groups_ref)
			FROM supplier_item_folder_feature_groups_list AS l
			WHERE l.item_folder_id = t.id
		) AS supplier_item_feature_groups_list
		
		,item_priorities_ref(item_priorities_ref_t) AS item_priorities_ref
		,vehicle_types_ref(vehicle_types_ref_t) AS vehicle_types_ref
		
	FROM public.item_folders AS t
	LEFT JOIN item_priorities AS item_priorities_ref_t ON item_priorities_ref_t.id = t.item_priority_id
	LEFT JOIN vehicle_types AS vehicle_types_ref_t ON vehicle_types_ref_t.id = t.vehicle_type_id
	;
	
ALTER VIEW public.item_folders_list OWNER TO ;
