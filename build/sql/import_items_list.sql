-- VIEW: public.import_items_list

--DROP VIEW public.import_items_list;

CREATE OR REPLACE VIEW public.import_items_list AS
	SELECT
		t.id
		,t.date_time
		,t.import_comment
		,t.name
		,t.make
		,t.model
		,t.model_generation
		,t.body
		,t.supplier
		,item_folders_ref(item_folders_ref_t) AS item_folders_ref
		,auto_makes_ref(auto_makes_ref_t) AS auto_makes_ref
		,auto_models_ref(auto_models_ref_t) AS auto_models_ref
		,auto_model_generations_ref(auto_model_generations_ref_t) AS auto_model_generations_ref
		,auto_bodies_ref(auto_bodies_ref_t) AS auto_bodies_ref
		,suppliers_ref(suppliers_ref_t) AS suppliers_ref
		,t.options
	FROM public.import_items AS t
	LEFT JOIN item_folders AS item_folders_ref_t ON item_folders_ref_t.id = t.item_folder_id	
	LEFT JOIN auto_makes AS auto_makes_ref_t ON auto_makes_ref_t.id = t.auto_make_id	
	LEFT JOIN auto_models AS auto_models_ref_t ON auto_models_ref_t.id = t.auto_model_id	
	LEFT JOIN auto_model_generations AS auto_model_generations_ref_t ON auto_model_generations_ref_t.id = t.auto_model_generation_id	
	LEFT JOIN auto_bodies AS auto_bodies_ref_t ON auto_bodies_ref_t.id = t.auto_body_id
	LEFT JOIN suppliers AS suppliers_ref_t ON suppliers_ref_t.id = t.supplier_id
	ORDER BY t.date_time DESC, t.name
	;
	
ALTER VIEW public.import_items_list OWNER TO ;
