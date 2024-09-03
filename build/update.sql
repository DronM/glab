
-- ******************* update 16/08/2023 07:56:05 ******************
﻿-- Function: auto_model_generations_name(auto_model_generations)

-- DROP FUNCTION auto_model_generations_name(auto_model_generations);

CREATE OR REPLACE FUNCTION auto_model_generations_name(auto_model_generations)
  RETURNS text AS
$$
	SELECT $1.generation_num ||
			coalesce(' (' || $1.series || ')', '') ||
			coalesce(' ' || $1.model, '') ||
			coalesce(' (' || $1.year_from::text || '-' || $1.year_to::text || ')', '');
$$
  LANGUAGE sql IMMUTABLE
  COST 100;
ALTER FUNCTION auto_model_generations_name(auto_model_generations) OWNER TO glab;


-- ******************* update 16/08/2023 07:56:21 ******************
--Refrerece type
CREATE OR REPLACE FUNCTION auto_model_generations_ref(auto_model_generations)
  RETURNS json AS
$$
	SELECT json_build_object(
		'keys',json_build_object(
			'id',$1.id    
			),	
		'descr',auto_model_generations_name($1),
		'dataType','auto_model_generations'
	);
$$
  LANGUAGE sql VOLATILE COST 100;
ALTER FUNCTION auto_model_generations_ref(auto_model_generations) OWNER TO glab;	
	



-- ******************* update 16/08/2023 07:56:42 ******************
-- VIEW: public.auto_model_generations_list

--DROP VIEW public.auto_model_generations_list;

CREATE OR REPLACE VIEW public.auto_model_generations_list AS
	SELECT
		t.id
		,t.auto_model_id
		,auto_models_ref(auto_models_ref_t) AS auto_models_ref
		,auto_models_ref_t.auto_make_id
		,auto_makes_ref(auto_makes_ref_t) AS auto_makes_ref
		,t.generation_num
		,t.prod_index
		,t.year_from
		,t.year_to
		,t.model
		,t.series
		,t.eurocode
		,t.local_id
		,auto_model_generations_name(t) AS name
		
	FROM public.auto_model_generations AS t
	LEFT JOIN auto_models AS auto_models_ref_t ON auto_models_ref_t.id = t.auto_model_id
	LEFT JOIN auto_makes AS auto_makes_ref_t ON auto_makes_ref_t.id = auto_models_ref_t.auto_make_id  
	ORDER BY t.generation_num
	
	;
	
ALTER VIEW public.auto_model_generations_list OWNER TO glab;



-- ******************* update 16/08/2023 08:00:54 ******************
-- VIEW: public.auto_models_list

--DROP VIEW public.auto_models_list;

CREATE OR REPLACE VIEW public.auto_models_list AS
	SELECT
		t.id
		,t.auto_make_id
		,auto_makes_ref(auto_makes_ref_t) AS auto_makes_ref
		,t.name
		,t.name_variants
		,t.popularity_type_id
		,popularity_types_ref(popularity_types_t) AS popularity_types_ref
		,t.vehicle_type_id
		,vehicle_types_ref(vehicle_types_t) AS vehicle_types_ref
		,(SELECT
			count(*)
		FROM auto_model_generations AS g
		WHERE g.auto_model_id = t.id
		) AS model_generation_count
		
	FROM public.auto_models AS t
	LEFT JOIN auto_makes AS auto_makes_ref_t ON auto_makes_ref_t.id = t.auto_make_id	
	LEFT JOIN popularity_types AS popularity_types_t ON popularity_types_t.id = t.popularity_type_id
	LEFT JOIN vehicle_types AS vehicle_types_t ON vehicle_types_t.id = t.vehicle_type_id
	LEFT JOIN popularity_types AS make_popularity_types_t ON make_popularity_types_t.id = auto_makes_ref_t.popularity_type_id
	ORDER BY make_popularity_types_t.code DESC, make_popularity_types_t.code DESC, name ASC
	;
	
ALTER VIEW public.auto_models_list OWNER TO glab;



-- ******************* update 16/08/2023 08:04:58 ******************
-- VIEW: public.auto_model_generations_list

--DROP VIEW public.auto_model_generations_list;

CREATE OR REPLACE VIEW public.auto_model_generations_list AS
	SELECT
		t.id
		,t.auto_model_id
		,auto_models_ref(auto_models_ref_t) AS auto_models_ref
		,auto_models_ref_t.auto_make_id
		,auto_makes_ref(auto_makes_ref_t) AS auto_makes_ref
		,t.generation_num
		,t.prod_index
		,t.year_from
		,t.year_to
		,t.model
		,t.series
		,t.eurocode
		,t.local_id
		,auto_model_generations_name(t) AS name
		,(SELECT count(*) FROM auto_bodies AS b WHERE b.auto_model_generation_id = t.id) AS body_count
		
	FROM public.auto_model_generations AS t
	LEFT JOIN auto_models AS auto_models_ref_t ON auto_models_ref_t.id = t.auto_model_id
	LEFT JOIN auto_makes AS auto_makes_ref_t ON auto_makes_ref_t.id = auto_models_ref_t.auto_make_id  
	ORDER BY t.generation_num
	
	;
	
ALTER VIEW public.auto_model_generations_list OWNER TO glab;



-- ******************* update 16/08/2023 09:46:34 ******************
﻿-- Function: auto_mode_generations_gen_next_id(in_auto_model_id int, in_eurocode text)

-- DROP FUNCTION auto_mode_generations_gen_next_id(in_auto_model_id int, in_eurocode text);

CREATE OR REPLACE FUNCTION auto_mode_generations_gen_next_id(in_auto_model_id int, in_eurocode text)
  RETURNS text AS
$$
	WITH
	new_id AS (SELECT		
			((regexp_replace(local_id, '[^0-9]+', '', 'g'))::int + 1)::text AS id
		FROM auto_model_generations
		WHERE auto_model_id = in_auto_model_id AND eurocode = in_eurocode
		ORDER BY local_id DESC
		LIMIT 1
	)
	SELECT
		CASE
			WHEN length((SELECT id FROM new_id)) = 1 THEN '0' || (SELECT id FROM new_id)
			ELSE (SELECT id FROM new_id)
		END;
$$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION auto_mode_generations_gen_next_id(in_auto_model_id int, in_eurocode text) OWNER TO glab;


-- ******************* update 16/08/2023 10:14:56 ******************
/**
 * Andrey Mikhalevich 15/12/21
 * This file is part of the OSBE framework
 *
 * THIS FILE IS GENERATED FROM TEMPLATE build/templates/permissions/permissions.sql.tmpl
 * ALL DIRECT MODIFICATIONS WILL BE LOST WITH THE NEXT BUILD PROCESS!!!
 */

/*
-- If this is the first time you execute the script, uncomment these lines
-- to create table and insert row
CREATE TABLE IF NOT EXISTS permissions (
    rules json NOT NULL
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.permissions OWNER to ;

INSERT INTO permissions VALUES ('{"admin":{}}');
*/

UPDATE permissions SET rules = '{
	"admin":{
		"Event":{
			"subscribe":true
			,"unsubscribe":true
			,"publish":true
		}
		,"Constant":{
			"set_value":true
			,"get_list":true
			,"get_object":true
			,"get_values":true
		}
		,"Enum":{
			"get_enum_list":true
		}
		,"MainMenuConstructor":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MainMenuContent":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"View":{
			"get_list":true
			,"complete":true
			,"get_section_list":true
		}
		,"VariantStorage":{
			"insert":true
			,"upsert_filter_data":true
			,"upsert_col_visib_data":true
			,"upsert_col_order_data":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_filter_data":true
			,"get_col_visib_data":true
			,"get_col_order_data":true
		}
		,"About":{
			"get_object":true
		}
		,"Service":{
			"reload_config":true
			,"reload_version":true
		}
		,"User":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
			,"get_profile":true
			,"reset_pwd":true
			,"login":true
			,"login_refresh":true
			,"logout":true
			,"logout_html":true
			,"download_photo":true
			,"delete_photo":true
			,"password_recover":true
		}
		,"Login":{
			"get_list":true
			,"get_object":true
			,"logout":true
		}
		,"LoginDevice":{
			"get_list":true
			,"switch_banned":true
		}
		,"Captcha":{
			"get":true
		}
		,"LoginDeviceBan":{
			"insert":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"TimeZoneLocale":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Department":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Post":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Contact":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
			,"upsert":true
		}
		,"EntityContact":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ObjectModLog":{
			"get_list":true
			,"get_object":true
		}
		,"MailMessage":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MailMessageAttachment":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MailTemplate":{
			"insert":true
			,"update":true
			,"get_list":true
			,"get_object":true
		}
		,"Attachment":{
			"get_list":true
			,"get_object":true
			,"delete_file":true
			,"get_file":true
			,"add_file":true
		}
		,"AutoMake":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"AutoModel":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_make":true
			,"get_all_years":true
		}
		,"AutoModelGeneration":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_model":true
			,"gen_next_id":true
		}
		,"AutoType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"AutoBodyType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoBodyDoor":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoBody":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_model_generation":true
		}
		,"ItemFolder":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemFeature":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemFeatureValueList":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItemFeatureValueList":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFeatureGroupItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFolderFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItemFolderFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Item":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_item":true
			,"complete":true
			,"set_feature":true
			,"get_features_filter_list":true
		}
		,"Manufacturer":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ManufacturerBrand":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Supplier":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"VehicleType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemPriority":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"PopularityType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"import":true
			,"set_feature":true
			,"get_features_filter_list":true
		}
		,"ItemSearch":{
			"get_object":true
			,"find_items":true
		}
		,"ImportItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierStore":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_supplier":true
		}
		,"SupplierStoreValue":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoPriceCategory":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoToGlassMatchHead":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoToGlassMatchEurocode":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_body_list":true
		}
		,"AutoToGlassMatchOption":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_conf_form":true
		}
	}
	,"guest":{
		"User":{
			"login":true
		}
	}
}';


-- ******************* update 16/08/2023 14:42:41 ******************
-- VIEW: public.auto_bodies_list

DROP VIEW public.auto_bodies_list CASCADE;

CREATE OR REPLACE VIEW public.auto_bodies_list AS
	SELECT
		t.id
		,t.name
		,t.auto_body_type_id
		,auto_body_types_ref(auto_body_types_ref_t) AS auto_body_types_ref
		,auto_body_doors_ref(auto_body_doors_ref_t) AS auto_body_doors_ref
		,t.year_from
		,t.year_to
		,t.model
		,auto_price_categories_ref(pr_cat) AS auto_price_categories_ref
		,t.auto_body_size
		,t.complexity_film_body
		,t.complexity_film_front
		,t.complexity_film_back
		,t.complexity_glass
		
	FROM public.auto_bodies AS t
	LEFT JOIN auto_body_types AS auto_body_types_ref_t ON auto_body_types_ref_t.id = t.auto_body_type_id
	LEFT JOIN auto_body_doors AS auto_body_doors_ref_t ON auto_body_doors_ref_t.id = t.auto_body_door_id
	LEFT JOIN auto_model_generations AS auto_model_generations_ref_t ON auto_model_generations_ref_t.id = t.auto_model_generation_id
	LEFT JOIN auto_models AS auto_models_ref_t ON auto_models_ref_t.id = auto_model_generations_ref_t.auto_model_id
	LEFT JOIN auto_makes AS auto_makes_ref_t ON auto_makes_ref_t.id = auto_models_ref_t.auto_make_id
	LEFT JOIN auto_price_categories AS pr_cat ON pr_cat.id = t.auto_price_category_id
	
	ORDER BY auto_models_ref_t.name, t.name
	;
	
ALTER VIEW public.auto_bodies_list OWNER TO glab;



-- ******************* update 17/08/2023 12:17:53 ******************
	
		ALTER TABLE public.auto_bodies ADD COLUMN auto_model_id int REFERENCES auto_models(id);



-- ******************* update 17/08/2023 12:19:20 ******************
	
UPDATE auto_bodies AS b
SET auto_model_id = (SELECT g.auto_model_id FROM auto_model_generations AS g WHERE g.id = b.auto_model_generation_id)



-- ******************* update 17/08/2023 12:25:15 ******************
-- VIEW: public.auto_bodies_list

DROP VIEW public.auto_bodies_list CASCADE;

CREATE OR REPLACE VIEW public.auto_bodies_list AS
	SELECT
		t.id
		,t.name
		,t.auto_model_id
		,auto_models_ref(auto_models_ref_t) AS auto_models_ref		
		,t.auto_body_type_id
		,auto_body_types_ref(auto_body_types_ref_t) AS auto_body_types_ref
		,auto_body_doors_ref(auto_body_doors_ref_t) AS auto_body_doors_ref
		,t.year_from
		,t.year_to
		,t.model
		,auto_price_categories_ref(pr_cat) AS auto_price_categories_ref
		,t.auto_body_size
		,t.complexity_film_body
		,t.complexity_film_front
		,t.complexity_film_back
		,t.complexity_glass
		
	FROM public.auto_bodies AS t
	LEFT JOIN auto_models AS auto_models_ref_t ON auto_models_ref_t.id = t.auto_model_id
	LEFT JOIN auto_body_types AS auto_body_types_ref_t ON auto_body_types_ref_t.id = t.auto_body_type_id
	LEFT JOIN auto_body_doors AS auto_body_doors_ref_t ON auto_body_doors_ref_t.id = t.auto_body_door_id
	LEFT JOIN auto_price_categories AS pr_cat ON pr_cat.id = t.auto_price_category_id
	
	ORDER BY auto_models_ref_t.name, t.name
	;
	
ALTER VIEW public.auto_bodies_list OWNER TO glab;



-- ******************* update 17/08/2023 12:37:17 ******************
-- VIEW: public.auto_models_list

--DROP VIEW public.auto_models_list;

CREATE OR REPLACE VIEW public.auto_models_list AS
	SELECT
		t.id
		,t.auto_make_id
		,auto_makes_ref(auto_makes_ref_t) AS auto_makes_ref
		,t.name
		,t.name_variants
		,t.popularity_type_id
		,popularity_types_ref(popularity_types_t) AS popularity_types_ref
		,t.vehicle_type_id
		,vehicle_types_ref(vehicle_types_t) AS vehicle_types_ref
		,(SELECT count(*) FROM auto_model_generations AS g WHERE g.auto_model_id = t.id) AS model_generation_count
		,(SELECT count(*) FROM auto_bodies AS b WHERE b.auto_model_id = t.id) AS body_count
		
	FROM public.auto_models AS t
	LEFT JOIN auto_makes AS auto_makes_ref_t ON auto_makes_ref_t.id = t.auto_make_id	
	LEFT JOIN popularity_types AS popularity_types_t ON popularity_types_t.id = t.popularity_type_id
	LEFT JOIN vehicle_types AS vehicle_types_t ON vehicle_types_t.id = t.vehicle_type_id
	LEFT JOIN popularity_types AS make_popularity_types_t ON make_popularity_types_t.id = auto_makes_ref_t.popularity_type_id
	ORDER BY make_popularity_types_t.code DESC, make_popularity_types_t.code DESC, name ASC
	;
	
ALTER VIEW public.auto_models_list OWNER TO glab;



-- ******************* update 17/08/2023 13:26:38 ******************
-- VIEW: public.auto_model_generations_list

DROP VIEW public.auto_model_generations_list;

CREATE OR REPLACE VIEW public.auto_model_generations_list AS
	SELECT
		t.id
		,t.auto_model_id
		,auto_models_ref(auto_models_ref_t) AS auto_models_ref
		,auto_models_ref_t.auto_make_id
		,auto_makes_ref(auto_makes_ref_t) AS auto_makes_ref
		,t.generation_num
		,t.prod_index
		,t.year_from
		,t.year_to
		,t.model
		,t.series
		,auto_model_generations_name(t) AS name
		,(SELECT count(*) FROM auto_bodies AS b WHERE b.auto_model_generation_id = t.id) AS body_count
		
	FROM public.auto_model_generations AS t
	LEFT JOIN auto_models AS auto_models_ref_t ON auto_models_ref_t.id = t.auto_model_id
	LEFT JOIN auto_makes AS auto_makes_ref_t ON auto_makes_ref_t.id = auto_models_ref_t.auto_make_id  
	ORDER BY t.generation_num
	
	;
	
ALTER VIEW public.auto_model_generations_list OWNER TO glab;



-- ******************* update 17/08/2023 13:30:07 ******************

	
	-- ********** Adding new table from model **********
	CREATE TABLE public.auto_model_generation_bodies
	(id serial NOT NULL,auto_model_generation_id int REFERENCES auto_models(id),auto_body_id int REFERENCES auto_bodies(id),eurocode text,local_id  varchar(10),CONSTRAINT auto_model_generation_bodies_pkey PRIMARY KEY (id)
	);
	
	ALTER TABLE public.auto_model_generation_bodies OWNER TO glab;



-- ******************* update 17/08/2023 13:33:56 ******************
-- VIEW: public.auto_model_generation_bodies_list

--DROP VIEW public.auto_model_generation_bodies_list;

CREATE OR REPLACE VIEW public.auto_model_generation_bodies_list AS
	SELECT
		t.id
		,t.auto_model_generation_id
		,auto_bodies_ref(auto_bodies_ref_t) AS auto_bodies_ref
		,t.eurocode
		,t.local_id
	FROM public.auto_model_generation_bodies AS t
	LEFT JOIN auto_bodies AS auto_bodies_ref_t ON auto_bodies_ref_t.id = t.auto_body_id
	ORDER BY t.auto_model_generation_id, auto_bodies_ref_t.name
	;
	
ALTER VIEW public.auto_model_generation_bodies_list OWNER TO glab;


-- ******************* update 17/08/2023 14:06:26 ******************
/**
 * Andrey Mikhalevich 15/12/21
 * This file is part of the OSBE framework
 *
 * THIS FILE IS GENERATED FROM TEMPLATE build/templates/permissions/permissions.sql.tmpl
 * ALL DIRECT MODIFICATIONS WILL BE LOST WITH THE NEXT BUILD PROCESS!!!
 */

/*
-- If this is the first time you execute the script, uncomment these lines
-- to create table and insert row
CREATE TABLE IF NOT EXISTS permissions (
    rules json NOT NULL
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.permissions OWNER to ;

INSERT INTO permissions VALUES ('{"admin":{}}');
*/

UPDATE permissions SET rules = '{
	"admin":{
		"Event":{
			"subscribe":true
			,"unsubscribe":true
			,"publish":true
		}
		,"Constant":{
			"set_value":true
			,"get_list":true
			,"get_object":true
			,"get_values":true
		}
		,"Enum":{
			"get_enum_list":true
		}
		,"MainMenuConstructor":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MainMenuContent":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"View":{
			"get_list":true
			,"complete":true
			,"get_section_list":true
		}
		,"VariantStorage":{
			"insert":true
			,"upsert_filter_data":true
			,"upsert_col_visib_data":true
			,"upsert_col_order_data":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_filter_data":true
			,"get_col_visib_data":true
			,"get_col_order_data":true
		}
		,"About":{
			"get_object":true
		}
		,"Service":{
			"reload_config":true
			,"reload_version":true
		}
		,"User":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
			,"get_profile":true
			,"reset_pwd":true
			,"login":true
			,"login_refresh":true
			,"logout":true
			,"logout_html":true
			,"download_photo":true
			,"delete_photo":true
			,"password_recover":true
		}
		,"Login":{
			"get_list":true
			,"get_object":true
			,"logout":true
		}
		,"LoginDevice":{
			"get_list":true
			,"switch_banned":true
		}
		,"Captcha":{
			"get":true
		}
		,"LoginDeviceBan":{
			"insert":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"TimeZoneLocale":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Department":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Post":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Contact":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
			,"upsert":true
		}
		,"EntityContact":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ObjectModLog":{
			"get_list":true
			,"get_object":true
		}
		,"MailMessage":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MailMessageAttachment":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MailTemplate":{
			"insert":true
			,"update":true
			,"get_list":true
			,"get_object":true
		}
		,"Attachment":{
			"get_list":true
			,"get_object":true
			,"delete_file":true
			,"get_file":true
			,"add_file":true
		}
		,"AutoMake":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"AutoModel":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_make":true
			,"get_all_years":true
		}
		,"AutoModelGeneration":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_model":true
			,"gen_next_id":true
		}
		,"AutoType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"AutoBodyType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoBodyDoor":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoBody":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_model_generation":true
		}
		,"ItemFolder":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemFeature":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemFeatureValueList":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItemFeatureValueList":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFeatureGroupItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFolderFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItemFolderFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Item":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_item":true
			,"complete":true
			,"set_feature":true
			,"get_features_filter_list":true
		}
		,"Manufacturer":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ManufacturerBrand":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Supplier":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"VehicleType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemPriority":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"PopularityType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"import":true
			,"set_feature":true
			,"get_features_filter_list":true
		}
		,"ItemSearch":{
			"get_object":true
			,"find_items":true
		}
		,"ImportItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierStore":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_supplier":true
		}
		,"SupplierStoreValue":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoPriceCategory":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoToGlassMatchHead":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoToGlassMatchEurocode":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_body_list":true
		}
		,"AutoToGlassMatchOption":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_conf_form":true
		}
		,"AutoModelGenerationBody":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
	}
	,"guest":{
		"User":{
			"login":true
		}
	}
}';


-- ******************* update 17/08/2023 14:10:54 ******************
/**
 * Andrey Mikhalevich 15/12/21
 * This file is part of the OSBE framework
 *
 * THIS FILE IS GENERATED FROM TEMPLATE build/templates/permissions/permissions.sql.tmpl
 * ALL DIRECT MODIFICATIONS WILL BE LOST WITH THE NEXT BUILD PROCESS!!!
 */

/*
-- If this is the first time you execute the script, uncomment these lines
-- to create table and insert row
CREATE TABLE IF NOT EXISTS permissions (
    rules json NOT NULL
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.permissions OWNER to ;

INSERT INTO permissions VALUES ('{"admin":{}}');
*/

UPDATE permissions SET rules = '{
	"admin":{
		"Event":{
			"subscribe":true
			,"unsubscribe":true
			,"publish":true
		}
		,"Constant":{
			"set_value":true
			,"get_list":true
			,"get_object":true
			,"get_values":true
		}
		,"Enum":{
			"get_enum_list":true
		}
		,"MainMenuConstructor":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MainMenuContent":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"View":{
			"get_list":true
			,"complete":true
			,"get_section_list":true
		}
		,"VariantStorage":{
			"insert":true
			,"upsert_filter_data":true
			,"upsert_col_visib_data":true
			,"upsert_col_order_data":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_filter_data":true
			,"get_col_visib_data":true
			,"get_col_order_data":true
		}
		,"About":{
			"get_object":true
		}
		,"Service":{
			"reload_config":true
			,"reload_version":true
		}
		,"User":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
			,"get_profile":true
			,"reset_pwd":true
			,"login":true
			,"login_refresh":true
			,"logout":true
			,"logout_html":true
			,"download_photo":true
			,"delete_photo":true
			,"password_recover":true
		}
		,"Login":{
			"get_list":true
			,"get_object":true
			,"logout":true
		}
		,"LoginDevice":{
			"get_list":true
			,"switch_banned":true
		}
		,"Captcha":{
			"get":true
		}
		,"LoginDeviceBan":{
			"insert":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"TimeZoneLocale":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Department":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Post":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Contact":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
			,"upsert":true
		}
		,"EntityContact":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ObjectModLog":{
			"get_list":true
			,"get_object":true
		}
		,"MailMessage":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MailMessageAttachment":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MailTemplate":{
			"insert":true
			,"update":true
			,"get_list":true
			,"get_object":true
		}
		,"Attachment":{
			"get_list":true
			,"get_object":true
			,"delete_file":true
			,"get_file":true
			,"add_file":true
		}
		,"AutoMake":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"AutoModel":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_make":true
			,"get_all_years":true
		}
		,"AutoModelGeneration":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_model":true
			,"gen_next_id":true
		}
		,"AutoType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"AutoBodyType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoBodyDoor":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoBody":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_model_generation":true
		}
		,"ItemFolder":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemFeature":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemFeatureValueList":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItemFeatureValueList":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFeatureGroupItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFolderFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItemFolderFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Item":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_item":true
			,"complete":true
			,"set_feature":true
			,"get_features_filter_list":true
		}
		,"Manufacturer":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ManufacturerBrand":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Supplier":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"VehicleType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemPriority":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"PopularityType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"import":true
			,"set_feature":true
			,"get_features_filter_list":true
		}
		,"ItemSearch":{
			"get_object":true
			,"find_items":true
		}
		,"ImportItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierStore":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_supplier":true
		}
		,"SupplierStoreValue":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoPriceCategory":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoToGlassMatchHead":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoToGlassMatchEurocode":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_body_list":true
		}
		,"AutoToGlassMatchOption":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_conf_form":true
		}
		,"AutoModelGenerationBody":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
	}
	,"guest":{
		"User":{
			"login":true
		}
	}
}';


-- ******************* update 17/08/2023 14:45:50 ******************
--Refrerece type
CREATE OR REPLACE FUNCTION auto_bodies_ref(auto_bodies)
  RETURNS json AS
$$
	SELECT json_build_object(
		'keys',json_build_object(
			'id',$1.id    
			),	
		'descr',$1.name || coalesce(' ('||$1.model||')', '') || coalesce($1.year_from::text,'') || coalesce('-'||$1.year_to::text,''),
		'dataType','auto_bodies'
	);
$$
  LANGUAGE sql VOLATILE COST 100;
ALTER FUNCTION auto_bodies_ref(auto_bodies) OWNER TO glab;	
	


-- ******************* update 17/08/2023 14:46:10 ******************
--Refrerece type
CREATE OR REPLACE FUNCTION auto_bodies_ref(auto_bodies)
  RETURNS json AS
$$
	SELECT json_build_object(
		'keys',json_build_object(
			'id',$1.id    
			),	
		'descr',$1.name || coalesce(' ('||$1.model||')', '') || coalesce(' '||$1.year_from::text,'') || coalesce('-'||$1.year_to::text,''),
		'dataType','auto_bodies'
	);
$$
  LANGUAGE sql VOLATILE COST 100;
ALTER FUNCTION auto_bodies_ref(auto_bodies) OWNER TO glab;	
	


-- ******************* update 17/08/2023 15:00:28 ******************
-- Function: auto_model_generation_bodies_process()

-- DROP FUNCTION auto_model_generation_bodies_process();

CREATE OR REPLACE FUNCTION auto_model_generation_bodies_process()
  RETURNS trigger AS
$BODY$
BEGIN
	IF (TG_WHEN='BEFORE' AND TG_OP='UPDATE' OR TG_OP='INSERT') THEN
		
		IF coalesce(NEW.eurocode,'') = '' THEN
			-- assign temp eurocode
			SELECT
				'$' ||
				substring('0000', 1, 4 - length((coalesce(max((substring(b.eurocode, 2))::int), 0) + 1)::text)) ||
				(coalesce(max((substring(b.eurocode, 2))::int), 0) + 1)::text
			INTO 
				NEW.eurocode
			FROM auto_model_generation_bodies AS b
			WHERE substring(b.eurocode, 1, 1) = '$'
				AND (TG_OP='INSERT' OR b.id <> OLD.id)
			;
		END IF;
		
		IF coalesce(NEW.local_id,'') = '' THEN
			SELECT
				substring('0', 1, 2 - length( (coalesce((b.local_id)::int, 0) + 1)::text ))||
				coalesce((b.local_id)::int, 0) + 1
			INTO
				NEW.local_id
			FROM auto_model_generation_bodies AS b
			WHERE b.eurocode = NEW.eurocode
				AND (TG_OP='INSERT' OR b.id <> OLD.id)
			;
		
		END IF;
		
		RETURN NEW;
	END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION auto_model_generation_bodies_process()
  OWNER TO glab;



-- ******************* update 17/08/2023 15:20:37 ******************
-- Trigger: auto_model_generation_bodies_trigger_before on public.auto_model_generation_bodies

-- DROP TRIGGER auto_model_generation_bodies_trigger_before ON public.auto_model_generation_bodies;


CREATE TRIGGER auto_model_generation_bodies_trigger_before
  BEFORE INSERT OR UPDATE
  ON public.auto_model_generation_bodies
  FOR EACH ROW
  EXECUTE PROCEDURE public.auto_model_generation_bodies_process();



-- ******************* update 17/08/2023 15:29:50 ******************
-- Function: auto_model_generation_bodies_process()

-- DROP FUNCTION auto_model_generation_bodies_process();

CREATE OR REPLACE FUNCTION auto_model_generation_bodies_process()
  RETURNS trigger AS
$BODY$
BEGIN
	IF (TG_WHEN='BEFORE' AND TG_OP='UPDATE' OR TG_OP='INSERT') THEN
		
		IF coalesce(NEW.eurocode,'') = '' THEN
			-- assign temp eurocode
			SELECT
				'$' ||
				substring('0000', 1, 4 - length((coalesce(max((substring(b.eurocode, 2))::int), 0) + 1)::text)) ||
				(coalesce(max((substring(b.eurocode, 2))::int), 0) + 1)::text
			INTO 
				NEW.eurocode
			FROM auto_model_generation_bodies AS b
			WHERE substring(b.eurocode, 1, 1) = '$'
				AND (TG_OP='INSERT' OR b.id <> OLD.id)
			;
		END IF;
		
		IF coalesce(NEW.local_id,'') = '' THEN
			SELECT
				substring('0', 1, 2 - length( (coalesce((b.local_id)::int, 0) + 1)::text ))||
				coalesce((b.local_id)::int, 0) + 1
			INTO
				NEW.local_id
			FROM auto_model_generation_bodies AS b
			WHERE b.eurocode = NEW.eurocode
				AND (TG_OP='INSERT' OR b.id <> OLD.id)
			;
		
		END IF;
RAISE EXCEPTION	'%', NEW.local_id;
		RETURN NEW;
	END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION auto_model_generation_bodies_process()
  OWNER TO glab;



-- ******************* update 17/08/2023 15:34:58 ******************
-- Function: auto_model_generation_bodies_process()

-- DROP FUNCTION auto_model_generation_bodies_process();

CREATE OR REPLACE FUNCTION auto_model_generation_bodies_process()
  RETURNS trigger AS
$BODY$
BEGIN
	IF (TG_WHEN='BEFORE' AND TG_OP='UPDATE' OR TG_OP='INSERT') THEN
		
		IF coalesce(NEW.eurocode,'') = '' THEN
			-- assign temp eurocode
			SELECT
				'$' ||
				substring('0000', 1, 4 - length((coalesce(max((substring(b.eurocode, 2))::int), 0) + 1)::text)) ||
				(coalesce(max((substring(b.eurocode, 2))::int), 0) + 1)::text
			INTO 
				NEW.eurocode
			FROM auto_model_generation_bodies AS b
			WHERE substring(b.eurocode, 1, 1) = '$'
				AND (TG_OP='INSERT' OR b.id <> OLD.id)
			;
		END IF;
		
		IF coalesce(NEW.local_id,'') = '' THEN
			SELECT
				substring('0', 1, 2 - length( (coalesce((b.local_id)::int, 0) + 1)::text ))||
				coalesce((b.local_id)::int, 0) + 1
			INTO
				NEW.local_id
			FROM auto_model_generation_bodies AS b
			WHERE b.eurocode = NEW.eurocode
				AND (TG_OP='INSERT' OR b.id <> OLD.id)
			;
			IF NEW.local_id IS NULL THEN
				NEW.local_id = '01';
			END IF;
		
		END IF;

		RETURN NEW;
	END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION auto_model_generation_bodies_process()
  OWNER TO glab;



-- ******************* update 19/02/2024 16:15:42 ******************

	
	-- ********** Adding new table from model **********
	CREATE TABLE public.card_banks
	(id serial NOT NULL,name  varchar(250) NOT NULL,CONSTRAINT card_banks_pkey PRIMARY KEY (id)
	);
	
	DROP INDEX IF EXISTS card_banks_name_idx;
	CREATE UNIQUE INDEX card_banks_name_idx
	ON card_banks(lower(name));

	ALTER TABLE public.card_banks OWNER TO glab;
	
	

-- ******************* update 19/02/2024 17:06:43 ******************

	
	-- Adding menu item
	INSERT INTO views
	(id,c,f,t,section,descr,limited)
	VALUES (
	'10023',
	'BankCard_Controller',
	'get_list',
	'BankCardList',
	'Справочники',
	'Виды банковских карт',
	FALSE
	);
	
	

-- ******************* update 19/02/2024 17:34:54 ******************
DROP TYPE data_types CASCADE;
	-- Adding new type
	CREATE TYPE data_types AS ENUM (
	
		'users'			
	,
		'employees'			
				
	);
	ALTER TYPE data_types OWNER TO glab;
/*		
	CREATE OR REPLACE FUNCTION enum_data_types_val(data_types,locales)
	RETURNS text AS $$
		SELECT
		CASE
		WHEN $1='users'::data_types AND $2='ru'::locales THEN 'Пользователи'
		WHEN $1='employees'::data_types AND $2='ru'::locales THEN 'Сотрудники'
		ELSE ''
		END;		
	$$ LANGUAGE sql;	
	ALTER FUNCTION enum_data_types_val(data_types,locales) OWNER TO glab;		
*/	
/*	
	-- ********** Adding new table from model **********
	CREATE TABLE public.contacts
	(id serial NOT NULL,name  varchar(250) NOT NULL,post_id int REFERENCES posts(id),email  varchar(100),email_confirmed bool,tel  varchar(11),tel_ext  varchar(20),tel_confirmed bool,descr text,comment_text text,CONSTRAINT contacts_pkey PRIMARY KEY (id)
	);
	
	DROP INDEX IF EXISTS contacts_descr_idx;
	CREATE UNIQUE INDEX contacts_descr_idx
	ON contacts(lower(descr));

	DROP INDEX IF EXISTS contacts_tel_idx;
	CREATE UNIQUE INDEX contacts_tel_idx
	ON contacts(tel);

	ALTER TABLE public.contacts OWNER TO glab;
	
*/


-- ******************* update 19/02/2024 17:35:14 ******************
	CREATE OR REPLACE FUNCTION enum_data_types_val(data_types,locales)
	RETURNS text AS $$
		SELECT
		CASE
		WHEN $1='users'::data_types AND $2='ru'::locales THEN 'Пользователи'
		WHEN $1='employees'::data_types AND $2='ru'::locales THEN 'Сотрудники'
		ELSE ''
		END;		
	$$ LANGUAGE sql;	
	ALTER FUNCTION enum_data_types_val(data_types,locales) OWNER TO glab;		
/*	
	-- ********** Adding new table from model **********
	CREATE TABLE public.contacts
	(id serial NOT NULL,name  varchar(250) NOT NULL,post_id int REFERENCES posts(id),email  varchar(100),email_confirmed bool,tel  varchar(11),tel_ext  varchar(20),tel_confirmed bool,descr text,comment_text text,CONSTRAINT contacts_pkey PRIMARY KEY (id)
	);
	
	DROP INDEX IF EXISTS contacts_descr_idx;
	CREATE UNIQUE INDEX contacts_descr_idx
	ON contacts(lower(descr));

	DROP INDEX IF EXISTS contacts_tel_idx;
	CREATE UNIQUE INDEX contacts_tel_idx
	ON contacts(tel);

	ALTER TABLE public.contacts OWNER TO glab;
	
*/


-- ******************* update 20/02/2024 15:33:07 ******************
/**
 * Andrey Mikhalevich 15/12/21
 * This file is part of the OSBE framework
 *
 * THIS FILE IS GENERATED FROM TEMPLATE build/templates/permissions/permissions.sql.tmpl
 * ALL DIRECT MODIFICATIONS WILL BE LOST WITH THE NEXT BUILD PROCESS!!!
 */

/*
-- If this is the first time you execute the script, uncomment these lines
-- to create table and insert row
CREATE TABLE IF NOT EXISTS permissions (
    rules json NOT NULL
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.permissions OWNER TO glab;

INSERT INTO permissions VALUES ('{"admin":{}}');
*/

UPDATE permissions SET rules = '{
	"admin":{
		"Event":{
			"subscribe":true
			,"unsubscribe":true
			,"publish":true
		}
		,"Constant":{
			"set_value":true
			,"get_list":true
			,"get_object":true
			,"get_values":true
		}
		,"Enum":{
			"get_enum_list":true
		}
		,"MainMenuConstructor":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MainMenuContent":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"View":{
			"get_list":true
			,"complete":true
			,"get_section_list":true
		}
		,"VariantStorage":{
			"insert":true
			,"upsert_filter_data":true
			,"upsert_col_visib_data":true
			,"upsert_col_order_data":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_filter_data":true
			,"get_col_visib_data":true
			,"get_col_order_data":true
		}
		,"About":{
			"get_object":true
		}
		,"Service":{
			"reload_config":true
			,"reload_version":true
		}
		,"User":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
			,"get_profile":true
			,"reset_pwd":true
			,"login":true
			,"login_refresh":true
			,"logout":true
			,"logout_html":true
			,"download_photo":true
			,"delete_photo":true
			,"password_recover":true
		}
		,"Login":{
			"get_list":true
			,"get_object":true
			,"logout":true
		}
		,"LoginDevice":{
			"get_list":true
			,"switch_banned":true
		}
		,"Captcha":{
			"get":true
		}
		,"LoginDeviceBan":{
			"insert":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"TimeZoneLocale":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Department":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Post":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Contact":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
			,"upsert":true
		}
		,"EntityContact":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ObjectModLog":{
			"get_list":true
			,"get_object":true
		}
		,"MailMessage":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MailMessageAttachment":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MailTemplate":{
			"insert":true
			,"update":true
			,"get_list":true
			,"get_object":true
		}
		,"Attachment":{
			"get_list":true
			,"get_object":true
			,"delete_file":true
			,"get_file":true
			,"add_file":true
		}
		,"AutoMake":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"AutoModel":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_make":true
			,"get_all_years":true
		}
		,"AutoModelGeneration":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_model":true
			,"gen_next_id":true
		}
		,"AutoType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"AutoBodyType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoBodyDoor":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoBody":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_model_generation":true
			,"complete_for_model":true
		}
		,"ItemFolder":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemFeature":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemFeatureValueList":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItemFeatureValueList":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFeatureGroupItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFolderFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItemFolderFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Item":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_item":true
			,"complete":true
			,"set_feature":true
			,"get_features_filter_list":true
		}
		,"Manufacturer":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ManufacturerBrand":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Supplier":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"VehicleType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemPriority":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"PopularityType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"import":true
			,"set_feature":true
			,"get_features_filter_list":true
		}
		,"ItemSearch":{
			"get_object":true
			,"find_items":true
		}
		,"ImportItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierStore":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_supplier":true
		}
		,"SupplierStoreValue":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoPriceCategory":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoToGlassMatchHead":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoToGlassMatchEurocode":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_body_list":true
		}
		,"AutoToGlassMatchOption":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_conf_form":true
		}
		,"AutoModelGenerationBody":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"BankCard":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
	}
	,"guest":{
		"User":{
			"login":true
		}
	}
}';


-- ******************* update 20/02/2024 15:43:41 ******************
/**
 * Andrey Mikhalevich 15/12/21
 * This file is part of the OSBE framework
 *
 * THIS FILE IS GENERATED FROM TEMPLATE build/templates/permissions/permissions.sql.tmpl
 * ALL DIRECT MODIFICATIONS WILL BE LOST WITH THE NEXT BUILD PROCESS!!!
 */

/*
-- If this is the first time you execute the script, uncomment these lines
-- to create table and insert row
CREATE TABLE IF NOT EXISTS permissions (
    rules json NOT NULL
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.permissions OWNER TO glab;
*/
INSERT INTO permissions VALUES ('{"admin":{}}');


/*
UPDATE permissions SET rules = '{
	"admin":{
		"Event":{
			"subscribe":true
			,"unsubscribe":true
			,"publish":true
		}
		,"Constant":{
			"set_value":true
			,"get_list":true
			,"get_object":true
			,"get_values":true
		}
		,"Enum":{
			"get_enum_list":true
		}
		,"MainMenuConstructor":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MainMenuContent":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"View":{
			"get_list":true
			,"complete":true
			,"get_section_list":true
		}
		,"VariantStorage":{
			"insert":true
			,"upsert_filter_data":true
			,"upsert_col_visib_data":true
			,"upsert_col_order_data":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_filter_data":true
			,"get_col_visib_data":true
			,"get_col_order_data":true
		}
		,"About":{
			"get_object":true
		}
		,"Service":{
			"reload_config":true
			,"reload_version":true
		}
		,"User":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
			,"get_profile":true
			,"reset_pwd":true
			,"login":true
			,"login_refresh":true
			,"logout":true
			,"logout_html":true
			,"download_photo":true
			,"delete_photo":true
			,"password_recover":true
		}
		,"Login":{
			"get_list":true
			,"get_object":true
			,"logout":true
		}
		,"LoginDevice":{
			"get_list":true
			,"switch_banned":true
		}
		,"Captcha":{
			"get":true
		}
		,"LoginDeviceBan":{
			"insert":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"TimeZoneLocale":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Department":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Post":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Contact":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
			,"upsert":true
		}
		,"EntityContact":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ObjectModLog":{
			"get_list":true
			,"get_object":true
		}
		,"MailMessage":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MailMessageAttachment":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MailTemplate":{
			"insert":true
			,"update":true
			,"get_list":true
			,"get_object":true
		}
		,"Attachment":{
			"get_list":true
			,"get_object":true
			,"delete_file":true
			,"get_file":true
			,"add_file":true
		}
		,"AutoMake":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"AutoModel":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_make":true
			,"get_all_years":true
		}
		,"AutoModelGeneration":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_model":true
			,"gen_next_id":true
		}
		,"AutoType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"AutoBodyType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoBodyDoor":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoBody":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_model_generation":true
			,"complete_for_model":true
		}
		,"ItemFolder":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemFeature":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemFeatureValueList":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItemFeatureValueList":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFeatureGroupItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFolderFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItemFolderFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Item":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_item":true
			,"complete":true
			,"set_feature":true
			,"get_features_filter_list":true
		}
		,"Manufacturer":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ManufacturerBrand":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Supplier":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"VehicleType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemPriority":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"PopularityType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"import":true
			,"set_feature":true
			,"get_features_filter_list":true
		}
		,"ItemSearch":{
			"get_object":true
			,"find_items":true
		}
		,"ImportItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierStore":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_supplier":true
		}
		,"SupplierStoreValue":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoPriceCategory":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoToGlassMatchHead":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoToGlassMatchEurocode":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_body_list":true
		}
		,"AutoToGlassMatchOption":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_conf_form":true
		}
		,"AutoModelGenerationBody":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"BankCard":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
	}
	,"guest":{
		"User":{
			"login":true
		}
	}
}';
*/


-- ******************* update 20/02/2024 15:43:50 ******************
/**
 * Andrey Mikhalevich 15/12/21
 * This file is part of the OSBE framework
 *
 * THIS FILE IS GENERATED FROM TEMPLATE build/templates/permissions/permissions.sql.tmpl
 * ALL DIRECT MODIFICATIONS WILL BE LOST WITH THE NEXT BUILD PROCESS!!!
 */

/*
-- If this is the first time you execute the script, uncomment these lines
-- to create table and insert row
CREATE TABLE IF NOT EXISTS permissions (
    rules json NOT NULL
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.permissions OWNER TO glab;
*/
--INSERT INTO permissions VALUES ('{"admin":{}}');



UPDATE permissions SET rules = '{
	"admin":{
		"Event":{
			"subscribe":true
			,"unsubscribe":true
			,"publish":true
		}
		,"Constant":{
			"set_value":true
			,"get_list":true
			,"get_object":true
			,"get_values":true
		}
		,"Enum":{
			"get_enum_list":true
		}
		,"MainMenuConstructor":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MainMenuContent":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"View":{
			"get_list":true
			,"complete":true
			,"get_section_list":true
		}
		,"VariantStorage":{
			"insert":true
			,"upsert_filter_data":true
			,"upsert_col_visib_data":true
			,"upsert_col_order_data":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_filter_data":true
			,"get_col_visib_data":true
			,"get_col_order_data":true
		}
		,"About":{
			"get_object":true
		}
		,"Service":{
			"reload_config":true
			,"reload_version":true
		}
		,"User":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
			,"get_profile":true
			,"reset_pwd":true
			,"login":true
			,"login_refresh":true
			,"logout":true
			,"logout_html":true
			,"download_photo":true
			,"delete_photo":true
			,"password_recover":true
		}
		,"Login":{
			"get_list":true
			,"get_object":true
			,"logout":true
		}
		,"LoginDevice":{
			"get_list":true
			,"switch_banned":true
		}
		,"Captcha":{
			"get":true
		}
		,"LoginDeviceBan":{
			"insert":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"TimeZoneLocale":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Department":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Post":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Contact":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
			,"upsert":true
		}
		,"EntityContact":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ObjectModLog":{
			"get_list":true
			,"get_object":true
		}
		,"MailMessage":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MailMessageAttachment":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MailTemplate":{
			"insert":true
			,"update":true
			,"get_list":true
			,"get_object":true
		}
		,"Attachment":{
			"get_list":true
			,"get_object":true
			,"delete_file":true
			,"get_file":true
			,"add_file":true
		}
		,"AutoMake":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"AutoModel":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_make":true
			,"get_all_years":true
		}
		,"AutoModelGeneration":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_model":true
			,"gen_next_id":true
		}
		,"AutoType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"AutoBodyType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoBodyDoor":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoBody":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_model_generation":true
			,"complete_for_model":true
		}
		,"ItemFolder":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemFeature":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemFeatureValueList":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItemFeatureValueList":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFeatureGroupItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFolderFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItemFolderFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Item":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_item":true
			,"complete":true
			,"set_feature":true
			,"get_features_filter_list":true
		}
		,"Manufacturer":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ManufacturerBrand":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Supplier":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"VehicleType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemPriority":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"PopularityType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"import":true
			,"set_feature":true
			,"get_features_filter_list":true
		}
		,"ItemSearch":{
			"get_object":true
			,"find_items":true
		}
		,"ImportItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierStore":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_supplier":true
		}
		,"SupplierStoreValue":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoPriceCategory":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoToGlassMatchHead":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoToGlassMatchEurocode":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_body_list":true
		}
		,"AutoToGlassMatchOption":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_conf_form":true
		}
		,"AutoModelGenerationBody":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"BankCard":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
	}
	,"guest":{
		"User":{
			"login":true
		}
	}
}';



-- ******************* update 20/02/2024 16:00:30 ******************
	
		ALTER TABLE public.entity_contacts ADD COLUMN entity_type data_types NOT NULL;
		
	DROP INDEX IF EXISTS entity_contacts_id_idx;
	CREATE UNIQUE INDEX entity_contacts_id_idx
	ON entity_contacts(entity_type,entity_id,contact_id);

	DROP INDEX IF EXISTS entity_contacts_contact_idx;
	CREATE INDEX entity_contacts_contact_idx
	ON entity_contacts(entity_type,contact_id);
	
		ALTER TABLE public.object_mod_log ADD COLUMN object_type data_types NOT NULL;
		
	DROP INDEX IF EXISTS object_mod_log_object_type_idx;
	CREATE INDEX object_mod_log_object_type_idx
	ON object_mod_log(object_type);

	DROP INDEX IF EXISTS object_mod_log_object_id_idx;
	CREATE INDEX object_mod_log_object_id_idx
	ON object_mod_log(object_id);



-- ******************* update 20/02/2024 16:00:53 ******************
-- VIEW: public.users_list

--DROP VIEW public.users_list;

CREATE OR REPLACE VIEW public.users_list AS
	SELECT
		t.id
		,t.name
		,t.role_id
		
		,(SELECT
			m_log.date_time
		FROM object_mod_log AS m_log
		WHERE m_log.object_type = 'users' AND m_log.object_id = t.id
		ORDER BY m_log.date_time DESC
		LIMIT 1
		) AS last_update
		
		,(SELECT
			m_log.user_descr
		FROM object_mod_log AS m_log
		WHERE m_log.object_type = 'users' AND m_log.object_id = t.id
		ORDER BY m_log.date_time DESC
		LIMIT 1
		) AS last_update_user
		
		
	FROM public.users AS t
	
	ORDER BY t.name ASC
	;
	
ALTER VIEW public.users_list OWNER TO glab;



-- ******************* update 20/02/2024 16:01:21 ******************
-- VIEW: public.users_dialog

--DROP VIEW public.users_dialog CASCADE;

CREATE OR REPLACE VIEW public.users_dialog AS
	SELECT
		t.id
		,t.name
		,t.role_id
		,t.create_dt
		,t.banned
		,time_zone_locales_ref(time_zone_locales_ref_t) AS time_zone_locales_ref
		,t.locale_id
		
		,jsonb_build_object(
			'id', 'user_photo'||t.id::text,
			'name', 'photo',
			'size', 0,
			'dataBase64',encode(t.photo, 'base64')
		) AS photo
		
	FROM public.users AS t
	LEFT JOIN time_zone_locales AS time_zone_locales_ref_t ON time_zone_locales_ref_t.id = t.time_zone_locale_id
	;
	
ALTER VIEW public.users_dialog OWNER TO glab;



-- ******************* update 20/02/2024 16:03:08 ******************
-- FUNCTION: public.contacts_ref(contacts)

-- DROP FUNCTION IF EXISTS public.contacts_ref(contacts);

CREATE OR REPLACE FUNCTION public.contacts_ref(
	contacts)
    RETURNS json
    LANGUAGE 'sql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
	SELECT json_build_object(
		'keys',json_build_object(
			'id',$1.id    
			),	
		'descr',$1.name,
		'dataType','contacts'
	);
$BODY$;

ALTER FUNCTION public.contacts_ref(contacts)
    OWNER TO glab;



-- ******************* update 20/02/2024 16:03:13 ******************
-- VIEW: contacts_list

--DROP VIEW contacts_list;

CREATE OR REPLACE VIEW contacts_list AS
	SELECT
		ct.id,
		ct.name,
		posts_ref(p) AS posts_ref,
		ct.email,
		ct.tel,
		ct.descr,
		ct.tel_ext,
		ct.comment_text
		/*e_us.tm_first_name AS tm_first_name,
		e_us.tm_photo,
		e_us.id AS ext_id,
		(e_us.id IS NOT NULL) AS tm_exists,
		(e_us.tm_id IS NOT NULL) AS tm_activated
		*/
		
	FROM contacts AS ct
	LEFT JOIN posts AS p ON p.id = ct.post_id
	--LEFT JOIN notifications.ext_users_photo_list AS e_us ON e_us.ext_contact_id = ct.id
	ORDER BY ct.name
	;
	
ALTER VIEW contacts_list OWNER TO glab;


-- ******************* update 20/02/2024 16:03:16 ******************
-- VIEW: contacts_dialog

--DROP VIEW contacts_dialog;

CREATE OR REPLACE VIEW contacts_dialog AS
	SELECT
		ct.id,
		ct.name,
		posts_ref(p) AS posts_ref,
		ct.email,
		ct.tel,
		ct.descr,
		ct.tel_ext,
		ct.comment_text
		/*
		(e_us.id IS NOT NULL) AS tm_exists,
		(e_us.tm_id IS NOT NULL) AS tm_activated,
		e_us.tm_photo,
		e_us.tm_first_name,
		e_us.id AS ext_id
		*/
		
	FROM contacts AS ct
	LEFT JOIN posts AS p ON p.id = ct.post_id
	--LEFT JOIN notifications.ext_users_photo_list AS e_us ON e_us.ext_contact_id = ct.id
	ORDER BY ct.name
	;
	
ALTER VIEW contacts_dialog OWNER TO glab;


-- ******************* update 20/02/2024 16:03:21 ******************
-- VIEW: entity_contacts_list

--DROP VIEW entity_contacts_list;

CREATE OR REPLACE VIEW entity_contacts_list AS
	SELECT
		e_ct.id ,
		e_ct.entity_type,
		e_ct.entity_id,
		CASE			
			WHEN e_ct.entity_type = 'users' THEN users_ref(u)
			--WHEN e_ct.entity_type = 'clients' THEN clients_ref(cl)
			--WHEN e_ct.entity_type = 'suppliers' THEN suppliers_ref(spl)
			ELSE NULL
		END AS entities_ref,
		e_ct.contact_id,
		contacts_ref(ct) AS contacts_ref,
		json_build_object(
			'name', ct.name,
			'tel', ct.tel,
			'email', ct.email,
			'tel_ext', ct.tel_ext,
			'post', p.name
		) AS contact_attrs
		
		--(e_user.id IS NOT NULL) AS tm_exists,
		--(e_user.tm_id IS NOT NULL) AS tm_activated
		
		
	FROM entity_contacts AS e_ct	
	LEFT JOIN users AS u ON e_ct.entity_type = 'users' AND u.id = e_ct.entity_id
	--LEFT JOIN suppliers AS spl ON e_ct.entity_type = 'suppliers' AND spl.id = e_ct.entity_id
	--LEFT JOIN clients AS cl ON e_ct.entity_type = 'clients' AND cl.id = e_ct.entity_id
	LEFT JOIN contacts AS ct ON ct.id = e_ct.contact_id
	LEFT JOIN posts AS p ON p.id = ct.post_id
	
	/*LEFT JOIN notifications.ext_users_list AS e_user ON e_user.ext_obj->>'dataType'='contacts'
		AND (e_user.ext_obj->'keys'->>'id')::int = e_ct.contact_id
		AND e_user.app_id=1
	*/
	ORDER BY e_ct.entity_type,
		CASE			
			WHEN e_ct.entity_type = 'users' THEN users_ref(u)->>'descr'
			--WHEN e_ct.entity_type = 'clients' THEN clients_ref(cl)->>'descr'
			--WHEN e_ct.entity_type = 'suppliers' THEN suppliers_ref(spl)->>'descr'
			ELSE NULL
		END
	;
	
ALTER VIEW entity_contacts_list OWNER TO glab;


-- ******************* update 20/02/2024 16:43:53 ******************

	
	-- Adding menu item
	INSERT INTO views
	(id,c,f,t,section,descr,limited)
	VALUES (
	'10024',
	'Department_Controller',
	'get_list',
	'BankCardList',
	'Справочники',
	'Отделы',
	FALSE
	);
	
	
	
	-- Adding menu item
	INSERT INTO views
	(id,c,f,t,section,descr,limited)
	VALUES (
	'10025',
	'Post_Controller',
	'get_list',
	'BankCardList',
	'Справочники',
	'Должности',
	FALSE
	);
	
	

-- ******************* update 20/02/2024 16:45:43 ******************

		UPDATE views SET
			c='Department_Controller',
			f='get_list',
			t='DepartmentList',
			section='Справочники',
			descr='Отделы',
			limited=FALSE
		WHERE id='10024';
	
		UPDATE views SET
			c='Post_Controller',
			f='get_list',
			t='PostList',
			section='Справочники',
			descr='Должности',
			limited=FALSE
		WHERE id='10025';
	

-- ******************* update 20/02/2024 16:46:42 ******************

		UPDATE views SET
			c='Department_Controller',
			f='get_list',
			t='DepartmentList',
			section='Справочники',
			descr='Отделы',
			limited=FALSE
		WHERE id='10024';
	
		UPDATE views SET
			c='Post_Controller',
			f='get_list',
			t='PostList',
			section='Справочники',
			descr='Должности',
			limited=FALSE
		WHERE id='10025';
	

-- ******************* update 20/02/2024 17:01:21 ******************
--Refrerece type
CREATE OR REPLACE FUNCTION departments_ref(departments)
  RETURNS json AS
$$
	SELECT json_build_object(
		'keys',json_build_object(
			'id',$1.id    
			),	
		'descr',$1.name,
		'dataType','departments'
	);
$$
  LANGUAGE sql VOLATILE COST 100;
ALTER FUNCTION departments_ref(departments) OWNER TO glab;	
	


-- ******************* update 20/02/2024 17:03:36 ******************

					ALTER TYPE data_types ADD VALUE 'bank_cards';
					
					ALTER TYPE data_types ADD VALUE 'contacts';
					
	/* type get function */
	CREATE OR REPLACE FUNCTION enum_data_types_val(data_types,locales)
	RETURNS text AS $$
		SELECT
		CASE
		WHEN $1='users'::data_types AND $2='ru'::locales THEN 'Пользователи'
		WHEN $1='employees'::data_types AND $2='ru'::locales THEN 'Сотрудники'
		WHEN $1='bank_cards'::data_types AND $2='ru'::locales THEN 'Карты банков'
		WHEN $1='contacts'::data_types AND $2='ru'::locales THEN 'Контакты'
		ELSE ''
		END;		
	$$ LANGUAGE sql;	
	ALTER FUNCTION enum_data_types_val(data_types,locales) OWNER TO glab;		
	

-- ******************* update 20/02/2024 17:04:49 ******************
--Refrerece type
CREATE OR REPLACE FUNCTION card_banks_ref(card_banks)
  RETURNS json AS
$$
	SELECT json_build_object(
		'keys',json_build_object(
			    
			),	
		'descr',$1.name,
		'dataType','card_banks'
	);
$$
  LANGUAGE sql VOLATILE COST 100;
ALTER FUNCTION card_banks_ref(card_banks) OWNER TO glab;	



-- ******************* update 20/02/2024 17:05:28 ******************

	
	-- ********** Adding new table from model **********
	CREATE TABLE public.employees
	(id serial NOT NULL,name  varchar(250) NOT NULL,birth_date date,department_id int REFERENCES departments(id),post_id int REFERENCES posts(id),qualification int
			DEFAULT 0,driving_lic_cat jsonb,expirience jsonb,staff bool
			DEFAULT FALSE,card_bank_id int REFERENCES card_banks(id),children jsonb,alimony bool
			DEFAULT FALSE,cloth jsonb,contact_id int REFERENCES contacts(id),comment_test text,CONSTRAINT employees_pkey PRIMARY KEY (id)
	);
	
	DROP INDEX IF EXISTS employees_name_idx;
	CREATE INDEX employees_name_idx
	ON employees(lower(name));

	ALTER TABLE public.employees OWNER TO glab;
	
	



-- ******************* update 20/02/2024 17:10:14 ******************
ALTER TABLE employees DROP COLUMN post_id;


-- ******************* update 20/02/2024 17:12:13 ******************
ALTER TABLE employees DROP COLUMN comment_test;
--ALTER TABLE employees DROP COLUMN comment_test;


-- ******************* update 20/02/2024 17:12:25 ******************
--ALTER TABLE employees DROP COLUMN comment_test;
ALTER TABLE employees ADD COLUMN comment_text text;


-- ******************* update 20/02/2024 17:20:34 ******************
-- VIEW: public.employees_dialog

--DROP VIEW public.employees_dialog;

CREATE OR REPLACE VIEW public.employees_dialog AS
	SELECT
		t.id
		,t.name
		,t.birth_date
		,departments_ref(departments_ref_t) AS departments_ref
		,t.qualification
		,t.driving_lic_cat
		,t.expirience
		,t.staff
		,card_banks_ref(card_banks_ref_t) AS card_banks_ref
		,t.children
		,t.alimony
		,t.cloth
		,contacts_ref(contacts_ref_t) AS contacts_ref
		,t.comment_text
		
		,posts_ref(posts_ref_t) AS posts_ref
		
	FROM public.employees AS t
	LEFT JOIN departments AS departments_ref_t ON departments_ref_t.id = t.department_id
	LEFT JOIN card_banks AS card_banks_ref_t ON card_banks_ref_t.id = t.card_bank_id
	LEFT JOIN contacts AS contacts_ref_t ON contacts_ref_t.id = t.contact_id
	LEFT JOIN posts AS posts_ref_t ON posts_ref_t.id = contacts_ref_t.post_id
	;
	
ALTER VIEW public.employees_dialog OWNER TO glab;


-- ******************* update 20/02/2024 17:22:12 ******************
	
		ALTER TABLE public.employees ADD COLUMN sort_index int;



-- ******************* update 20/02/2024 17:27:31 ******************
	
	DROP INDEX IF EXISTS employees_sort_index_idx;
	CREATE INDEX employees_sort_index_idx
	ON employees(sort_index);



-- ******************* update 20/02/2024 17:28:13 ******************
-- VIEW: public.employees_list

--DROP VIEW public.employees_list;

CREATE OR REPLACE VIEW public.employees_list AS
	SELECT
		t.id
		,t.name
		,t.birth_date
		,departments_ref(departments_ref_t) AS departments_ref
		,t.qualification
		,t.driving_lic_cat
		,t.expirience
		,t.staff
		,card_banks_ref(card_banks_ref_t) AS card_banks_ref
		,t.children
		,t.alimony
		,t.cloth
		,contacts_ref(contacts_ref_t) AS contacts_ref
		,t.comment_text
		,posts_ref(posts_ref_t) AS posts_ref
	FROM public.employees AS t
	LEFT JOIN departments AS departments_ref_t ON departments_ref_t.id = t.department_id
	LEFT JOIN card_banks AS card_banks_ref_t ON card_banks_ref_t.id = t.card_bank_id
	LEFT JOIN contacts AS contacts_ref_t ON contacts_ref_t.id = t.contact_id
	LEFT JOIN posts AS posts_ref_t ON posts_ref_t.id = contacts_ref_t.post_id
	ORDER BY t.sort_index
	;
	
ALTER VIEW public.employees_list OWNER TO glab;


-- ******************* update 20/02/2024 17:34:10 ******************

	-- Adding new type
	CREATE TYPE employee_status_types AS ENUM (
	
		'employed_staff'			
	,
		'employed_outstaff'			
	,
		'fired'			
				
	);
	ALTER TYPE employee_status_types OWNER TO glab;
		
	/* type get function */
	CREATE OR REPLACE FUNCTION enum_employee_status_types_val(employee_status_types,locales)
	RETURNS text AS $$
		SELECT
		CASE
		WHEN $1='employed_staff'::employee_status_types AND $2='ru'::locales THEN 'Штатный сотрудник'
		WHEN $1='employed_outstaff'::employee_status_types AND $2='ru'::locales THEN 'Внештатный сотрудник'
		WHEN $1='fired'::employee_status_types AND $2='ru'::locales THEN 'Уволен'
		ELSE ''
		END;		
	$$ LANGUAGE sql;	
	ALTER FUNCTION enum_employee_status_types_val(employee_status_types,locales) OWNER TO glab;		
	

-- ******************* update 20/02/2024 17:34:49 ******************

	
	-- ********** Adding new table from model **********
	CREATE TABLE public.employee_statuses
	(id serial NOT NULL,employee_id int NOT NULL REFERENCES employees(id),status_type employee_status_types NOT NULL,date_time timestampTZ
			DEFAULT CURRENT_TIMESTAMP NOT NULL,CONSTRAINT employee_statuses_pkey PRIMARY KEY (id)
	);
	
	DROP INDEX IF EXISTS employee_statuses_idx;
	CREATE UNIQUE INDEX employee_statuses_idx
	ON employee_statuses(employee_id,date_time);

	ALTER TABLE public.employee_statuses OWNER TO glab;



-- ******************* update 20/02/2024 17:38:13 ******************
-- Function: employees_process()

-- DROP FUNCTION employees_process();

CREATE OR REPLACE FUNCTION employees_process()
  RETURNS trigger AS
$BODY$
BEGIN
	IF (TG_WHEN='BEFORE' AND TG_OP='INSERT') THEN
		
		NEW.sort_index = coalesce((SELECT max(sort_index) FROM employees), 0) + 100;
		
		RETURN NEW;
	END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION employees_process()
  OWNER TO glab;



-- ******************* update 20/02/2024 17:40:04 ******************
-- Trigger: employees_trigger_before on public.employees

-- DROP TRIGGER employees_trigger_before ON public.employees;


CREATE TRIGGER employees_trigger_before
  BEFORE INSERT
  ON public.employees
  FOR EACH ROW
  EXECUTE PROCEDURE public.employees_process();



-- ******************* update 20/02/2024 17:57:46 ******************

	
	-- ********** Adding new table from model **********
	CREATE TABLE public.person_documents
	(id serial NOT NULL,name  varchar(250) NOT NULL,CONSTRAINT person_documents_pkey PRIMARY KEY (id)
	);
	
	DROP INDEX IF EXISTS person_documents_name_idx;
	CREATE UNIQUE INDEX person_documents_name_idx
	ON person_documents(lower(name));

	ALTER TABLE public.person_documents OWNER TO glab;
	
	
	
	-- Adding menu item
	INSERT INTO views
	(id,c,f,t,section,descr,limited)
	VALUES (
	'10026',
	'PersonDocument_Controller',
	'get_list',
	'PersonDocumentList',
	'Справочники',
	'Виды кадровых документов',
	FALSE
	);
	
	

-- ******************* update 20/02/2024 18:05:27 ******************

	
	-- ********** Adding new table from model **********
	CREATE TABLE public.person_document_types
	(id serial NOT NULL,name  varchar(250) NOT NULL,CONSTRAINT person_document_types_pkey PRIMARY KEY (id)
	);
	
	DROP INDEX IF EXISTS person_document_types_name_idx;
	CREATE UNIQUE INDEX person_document_types_name_idx
	ON person_document_types(lower(name));

	ALTER TABLE public.person_document_types OWNER TO glab;
	
	
		UPDATE views SET
			c='PersonDocumentType_Controller',
			f='get_list',
			t='PersonDocumentTypeList',
			section='Справочники',
			descr='Виды кадровых документов',
			limited=FALSE
		WHERE id='10026';
	

-- ******************* update 20/02/2024 18:10:00 ******************
	
		ALTER TABLE public.person_documents ADD COLUMN employee_id int REFERENCES employees(id),ADD COLUMN person_document_type_id int REFERENCES person_document_types(id),
		DROP COLUMN name;
		
	DROP INDEX IF EXISTS person_documents_name_idx;
	CREATE UNIQUE INDEX person_documents_name_idx
	ON person_documents(employee_id,person_document_type_id);




-- ******************* update 19/04/2024 09:47:54 ******************

	
	-- ********** Adding new table from model **********
	CREATE TABLE public.cash_locations
	(id serial NOT NULL,name text,CONSTRAINT cash_locations_pkey PRIMARY KEY (id)
	);
	
	DROP INDEX IF EXISTS cach_locations_name_idx;
	CREATE UNIQUE INDEX cach_locations_name_idx
	ON cash_locations(name);

	ALTER TABLE public.cash_locations OWNER TO glab;
	
	
	
	-- Adding menu item
	INSERT INTO views
	(id,c,f,t,section,descr,limited)
	VALUES (
	'10027',
	'CashLocation_Controller',
	'get_list',
	'CashLocationList',
	'Справочники',
	'Кассы',
	FALSE
	);
	
	

-- ******************* update 19/04/2024 10:54:15 ******************
/**
 * Andrey Mikhalevich 15/12/21
 * This file is part of the OSBE framework
 *
 * THIS FILE IS GENERATED FROM TEMPLATE build/templates/permissions/permissions.sql.tmpl
 * ALL DIRECT MODIFICATIONS WILL BE LOST WITH THE NEXT BUILD PROCESS!!!
 */

/*
-- If this is the first time you execute the script, uncomment these lines
-- to create table and insert row
CREATE TABLE IF NOT EXISTS permissions (
    rules json NOT NULL
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.permissions OWNER TO glab;

INSERT INTO permissions VALUES ('{"admin":{}}');
*/

UPDATE permissions SET rules = '{
	"admin":{
		"Event":{
			"subscribe":true
			,"unsubscribe":true
			,"publish":true
		}
		,"Constant":{
			"set_value":true
			,"get_list":true
			,"get_object":true
			,"get_values":true
		}
		,"Enum":{
			"get_enum_list":true
		}
		,"MainMenuConstructor":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MainMenuContent":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"View":{
			"get_list":true
			,"complete":true
			,"get_section_list":true
		}
		,"VariantStorage":{
			"insert":true
			,"upsert_filter_data":true
			,"upsert_col_visib_data":true
			,"upsert_col_order_data":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_filter_data":true
			,"get_col_visib_data":true
			,"get_col_order_data":true
		}
		,"About":{
			"get_object":true
		}
		,"Service":{
			"reload_config":true
			,"reload_version":true
		}
		,"User":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
			,"get_profile":true
			,"reset_pwd":true
			,"login":true
			,"login_refresh":true
			,"logout":true
			,"logout_html":true
			,"download_photo":true
			,"delete_photo":true
			,"password_recover":true
		}
		,"Login":{
			"get_list":true
			,"get_object":true
			,"logout":true
		}
		,"LoginDevice":{
			"get_list":true
			,"switch_banned":true
		}
		,"Captcha":{
			"get":true
		}
		,"LoginDeviceBan":{
			"insert":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"TimeZoneLocale":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Department":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Post":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Contact":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
			,"upsert":true
		}
		,"EntityContact":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ObjectModLog":{
			"get_list":true
			,"get_object":true
		}
		,"MailMessage":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MailMessageAttachment":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MailTemplate":{
			"insert":true
			,"update":true
			,"get_list":true
			,"get_object":true
		}
		,"Attachment":{
			"get_list":true
			,"get_object":true
			,"delete_file":true
			,"get_file":true
			,"add_file":true
		}
		,"AutoMake":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"AutoModel":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_make":true
			,"get_all_years":true
		}
		,"AutoModelGeneration":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_model":true
			,"gen_next_id":true
		}
		,"AutoType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"AutoBodyType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoBodyDoor":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoBody":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_model_generation":true
			,"complete_for_model":true
		}
		,"ItemFolder":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemFeature":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemFeatureValueList":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItemFeatureValueList":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFeatureGroupItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFolderFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItemFolderFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Item":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_item":true
			,"complete":true
			,"set_feature":true
			,"get_features_filter_list":true
		}
		,"Manufacturer":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ManufacturerBrand":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Supplier":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"VehicleType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemPriority":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"PopularityType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"import":true
			,"set_feature":true
			,"get_features_filter_list":true
		}
		,"ItemSearch":{
			"get_object":true
			,"find_items":true
		}
		,"ImportItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierStore":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_supplier":true
		}
		,"SupplierStoreValue":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoPriceCategory":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoToGlassMatchHead":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoToGlassMatchEurocode":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_body_list":true
		}
		,"AutoToGlassMatchOption":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_conf_form":true
		}
		,"AutoModelGenerationBody":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"BankCard":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Employee":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"EmployeeStatus":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"PersonDocument":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"PersonDocumentType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"CashLocation":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
	}
	,"guest":{
		"User":{
			"login":true
		}
	}
}';


-- ******************* update 19/04/2024 13:11:33 ******************

	
	-- ********** Adding new table from model **********
	CREATE TABLE public.fin_expence_types
	(id serial NOT NULL,parent_id int,name text,deleted bool,CONSTRAINT fin_expence_types_pkey PRIMARY KEY (id)
	);
	
	DROP INDEX IF EXISTS expence_types_parent_idx;
	CREATE INDEX expence_types_parent_idx
	ON fin_expence_types(parent_id);

	DROP INDEX IF EXISTS expence_types_name_idx;
	CREATE UNIQUE INDEX expence_types_name_idx
	ON fin_expence_types(name);

	ALTER TABLE public.fin_expence_types OWNER TO glab;
	
	
	
	-- Adding menu item
	INSERT INTO views
	(id,c,f,t,section,descr,limited)
	VALUES (
	'10028',
	'FinExpenseType_Controller',
	'get_list',
	'FinExpenseTypeList',
	'Справочники',
	'Статьи асходов',
	FALSE
	);
	
	

-- ******************* update 19/04/2024 13:21:48 ******************

		UPDATE views SET
			c='FinExpenseType_Controller',
			f='get_list',
			t='FinExpenseTypeList',
			section='Справочники',
			descr='Статьи расходов',
			limited=FALSE
		WHERE id='10028';
	

-- ******************* update 19/04/2024 13:22:19 ******************
/**
 * Andrey Mikhalevich 15/12/21
 * This file is part of the OSBE framework
 *
 * THIS FILE IS GENERATED FROM TEMPLATE build/templates/permissions/permissions.sql.tmpl
 * ALL DIRECT MODIFICATIONS WILL BE LOST WITH THE NEXT BUILD PROCESS!!!
 */

/*
-- If this is the first time you execute the script, uncomment these lines
-- to create table and insert row
CREATE TABLE IF NOT EXISTS permissions (
    rules json NOT NULL
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.permissions OWNER TO glab;

INSERT INTO permissions VALUES ('{"admin":{}}');
*/

UPDATE permissions SET rules = '{
	"admin":{
		"Event":{
			"subscribe":true
			,"unsubscribe":true
			,"publish":true
		}
		,"Constant":{
			"set_value":true
			,"get_list":true
			,"get_object":true
			,"get_values":true
		}
		,"Enum":{
			"get_enum_list":true
		}
		,"MainMenuConstructor":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MainMenuContent":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"View":{
			"get_list":true
			,"complete":true
			,"get_section_list":true
		}
		,"VariantStorage":{
			"insert":true
			,"upsert_filter_data":true
			,"upsert_col_visib_data":true
			,"upsert_col_order_data":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_filter_data":true
			,"get_col_visib_data":true
			,"get_col_order_data":true
		}
		,"About":{
			"get_object":true
		}
		,"Service":{
			"reload_config":true
			,"reload_version":true
		}
		,"User":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
			,"get_profile":true
			,"reset_pwd":true
			,"login":true
			,"login_refresh":true
			,"logout":true
			,"logout_html":true
			,"download_photo":true
			,"delete_photo":true
			,"password_recover":true
		}
		,"Login":{
			"get_list":true
			,"get_object":true
			,"logout":true
		}
		,"LoginDevice":{
			"get_list":true
			,"switch_banned":true
		}
		,"Captcha":{
			"get":true
		}
		,"LoginDeviceBan":{
			"insert":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"TimeZoneLocale":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Department":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Post":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Contact":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
			,"upsert":true
		}
		,"EntityContact":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ObjectModLog":{
			"get_list":true
			,"get_object":true
		}
		,"MailMessage":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MailMessageAttachment":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MailTemplate":{
			"insert":true
			,"update":true
			,"get_list":true
			,"get_object":true
		}
		,"Attachment":{
			"get_list":true
			,"get_object":true
			,"delete_file":true
			,"get_file":true
			,"add_file":true
		}
		,"AutoMake":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"AutoModel":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_make":true
			,"get_all_years":true
		}
		,"AutoModelGeneration":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_model":true
			,"gen_next_id":true
		}
		,"AutoType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"AutoBodyType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoBodyDoor":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoBody":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_model_generation":true
			,"complete_for_model":true
		}
		,"ItemFolder":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemFeature":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemFeatureValueList":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItemFeatureValueList":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFeatureGroupItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFolderFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItemFolderFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Item":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_item":true
			,"complete":true
			,"set_feature":true
			,"get_features_filter_list":true
		}
		,"Manufacturer":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ManufacturerBrand":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Supplier":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"VehicleType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemPriority":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"PopularityType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"import":true
			,"set_feature":true
			,"get_features_filter_list":true
		}
		,"ItemSearch":{
			"get_object":true
			,"find_items":true
		}
		,"ImportItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierStore":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_supplier":true
		}
		,"SupplierStoreValue":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoPriceCategory":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoToGlassMatchHead":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoToGlassMatchEurocode":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_body_list":true
		}
		,"AutoToGlassMatchOption":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_conf_form":true
		}
		,"AutoModelGenerationBody":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"BankCard":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Employee":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"EmployeeStatus":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"PersonDocument":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"PersonDocumentType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"CashLocation":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"FinExpenseType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
	}
	,"guest":{
		"User":{
			"login":true
		}
	}
}';


-- ******************* update 19/04/2024 13:32:54 ******************
-- VIEW: public.fin_expence_types_list

--DROP VIEW public.fin_expence_types_list;

CREATE OR REPLACE VIEW public.fin_expence_types_list AS
	SELECT
		t.id
		,t.parent_id
		,t.name
		,t.deleted
	FROM public.fin_expence_types AS t
	
	ORDER BY name ASC
	;
	
ALTER VIEW public.fin_expence_types_list OWNER TO glab;


-- ******************* update 19/04/2024 15:26:45 ******************

	
	-- ********** Adding new table from model **********
	CREATE TABLE public.cash_flow_in
	(id serial NOT NULL,date_time timestampTZ
			DEFAULT CURRENT_TIMESTAMP NOT NULL,cash_location_id int NOT NULL REFERENCES cash_locations(id),comment_text text,user_id int NOT NULL REFERENCES users(id),CONSTRAINT cash_flow_in_pkey PRIMARY KEY (id)
	);
	
	DROP INDEX IF EXISTS cash_flow_in_date_idx;
	CREATE INDEX cash_flow_in_date_idx
	ON cash_flow_in(date_time);

	DROP INDEX IF EXISTS cash_flow_in_location_idx;
	CREATE INDEX cash_flow_in_location_idx
	ON cash_flow_in(cash_location_id);

	ALTER TABLE public.cash_flow_in OWNER TO glab;
	
	
	
	-- Adding menu item
	INSERT INTO views
	(id,c,f,t,section,descr,limited)
	VALUES (
	'30001',
	'CashFlowIn_Controller',
	'get_list',
	'CashFlowInList',
	'Документы',
	'Приходные кассовые ордера',
	FALSE
	);
	



-- ******************* update 19/04/2024 15:26:48 ******************
CREATE OR REPLACE FUNCTION cash_locations_ref(cash_locations)
  RETURNS json AS
$$
	SELECT json_build_object(
		'keys',json_build_object(
			'id',$1.id    
			),	
		'descr',$1.name,
		'dataType','cash_locations'
	);
$$
  LANGUAGE sql VOLATILE COST 100;
ALTER FUNCTION cash_locations_ref(cash_locations) OWNER TO glab;	
	



-- ******************* update 19/04/2024 15:28:44 ******************
-- VIEW: public.cash_flow_in_list

--DROP VIEW public.cash_flow_in_list;

CREATE OR REPLACE VIEW public.cash_flow_in_list AS
	SELECT
		t.id
		,t.date_time
		,t.cash_location_id
		,cash_locations_ref(cash_locations_ref_t) AS cash_locations_ref
		,t.comment_text
		,users_ref(users_ref_t) AS users_ref
	FROM public.cash_flow_in AS t
	LEFT JOIN cash_locations AS cash_locations_ref_t ON cash_locations_ref_t.id = t.cash_location_id
	LEFT JOIN users AS users_ref_t ON users_ref_t.id = t.user_id
	ORDER BY t.date_time DESC
	;
	
ALTER VIEW public.cash_flow_in_list OWNER TO glab;


-- ******************* update 19/04/2024 15:47:30 ******************
/**
 * Andrey Mikhalevich 15/12/21
 * This file is part of the OSBE framework
 *
 * THIS FILE IS GENERATED FROM TEMPLATE build/templates/permissions/permissions.sql.tmpl
 * ALL DIRECT MODIFICATIONS WILL BE LOST WITH THE NEXT BUILD PROCESS!!!
 */

/*
-- If this is the first time you execute the script, uncomment these lines
-- to create table and insert row
CREATE TABLE IF NOT EXISTS permissions (
    rules json NOT NULL
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.permissions OWNER TO glab;

INSERT INTO permissions VALUES ('{"admin":{}}');
*/

UPDATE permissions SET rules = '{
	"admin":{
		"Event":{
			"subscribe":true
			,"unsubscribe":true
			,"publish":true
		}
		,"Constant":{
			"set_value":true
			,"get_list":true
			,"get_object":true
			,"get_values":true
		}
		,"Enum":{
			"get_enum_list":true
		}
		,"MainMenuConstructor":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MainMenuContent":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"View":{
			"get_list":true
			,"complete":true
			,"get_section_list":true
		}
		,"VariantStorage":{
			"insert":true
			,"upsert_filter_data":true
			,"upsert_col_visib_data":true
			,"upsert_col_order_data":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_filter_data":true
			,"get_col_visib_data":true
			,"get_col_order_data":true
		}
		,"About":{
			"get_object":true
		}
		,"Service":{
			"reload_config":true
			,"reload_version":true
		}
		,"User":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
			,"get_profile":true
			,"reset_pwd":true
			,"login":true
			,"login_refresh":true
			,"logout":true
			,"logout_html":true
			,"download_photo":true
			,"delete_photo":true
			,"password_recover":true
		}
		,"Login":{
			"get_list":true
			,"get_object":true
			,"logout":true
		}
		,"LoginDevice":{
			"get_list":true
			,"switch_banned":true
		}
		,"Captcha":{
			"get":true
		}
		,"LoginDeviceBan":{
			"insert":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"TimeZoneLocale":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Department":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Post":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Contact":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
			,"upsert":true
		}
		,"EntityContact":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ObjectModLog":{
			"get_list":true
			,"get_object":true
		}
		,"MailMessage":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MailMessageAttachment":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MailTemplate":{
			"insert":true
			,"update":true
			,"get_list":true
			,"get_object":true
		}
		,"Attachment":{
			"get_list":true
			,"get_object":true
			,"delete_file":true
			,"get_file":true
			,"add_file":true
		}
		,"AutoMake":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"AutoModel":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_make":true
			,"get_all_years":true
		}
		,"AutoModelGeneration":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_model":true
			,"gen_next_id":true
		}
		,"AutoType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"AutoBodyType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoBodyDoor":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoBody":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_model_generation":true
			,"complete_for_model":true
		}
		,"ItemFolder":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemFeature":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemFeatureValueList":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItemFeatureValueList":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFeatureGroupItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFolderFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItemFolderFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Item":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_item":true
			,"complete":true
			,"set_feature":true
			,"get_features_filter_list":true
		}
		,"Manufacturer":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ManufacturerBrand":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Supplier":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"VehicleType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemPriority":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"PopularityType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"import":true
			,"set_feature":true
			,"get_features_filter_list":true
		}
		,"ItemSearch":{
			"get_object":true
			,"find_items":true
		}
		,"ImportItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierStore":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_supplier":true
		}
		,"SupplierStoreValue":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoPriceCategory":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoToGlassMatchHead":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoToGlassMatchEurocode":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_body_list":true
		}
		,"AutoToGlassMatchOption":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_conf_form":true
		}
		,"AutoModelGenerationBody":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"BankCard":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Employee":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"EmployeeStatus":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"PersonDocument":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"PersonDocumentType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"CashLocation":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"FinExpenseType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"CashFlowIn":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
	}
	,"guest":{
		"User":{
			"login":true
		}
	}
}';


-- ******************* update 19/04/2024 15:58:51 ******************
	
		ALTER TABLE public.cash_flow_in ADD COLUMN total  numeric(15,2);



-- ******************* update 19/04/2024 16:12:46 ******************
-- VIEW: public.cash_flow_in_list

--DROP VIEW public.cash_flow_in_list;

CREATE OR REPLACE VIEW public.cash_flow_in_list AS
	SELECT
		t.id
		,t.date_time
		,t.cash_location_id
		,cash_locations_ref(cash_locations_ref_t) AS cash_locations_ref
		,t.comment_text
		,users_ref(users_ref_t) AS users_ref
		,t.total
	FROM public.cash_flow_in AS t
	LEFT JOIN cash_locations AS cash_locations_ref_t ON cash_locations_ref_t.id = t.cash_location_id
	LEFT JOIN users AS users_ref_t ON users_ref_t.id = t.user_id
	ORDER BY t.date_time DESC
	;
	
ALTER VIEW public.cash_flow_in_list OWNER TO glab;


-- ******************* update 19/04/2024 16:46:27 ******************
CREATE OR REPLACE FUNCTION fin_expence_types_ref(fin_expence_types)
  RETURNS json AS
$$
	SELECT json_build_object(
		'keys',json_build_object(
			    
			),	
		'descr',$1.name,
		'dataType','fin_expence_types'
	);
$$
  LANGUAGE sql VOLATILE COST 100;
ALTER FUNCTION fin_expence_types_ref(fin_expence_types) OWNER TO glab;	



-- ******************* update 19/04/2024 16:51:27 ******************
/**
 * Andrey Mikhalevich 15/12/21
 * This file is part of the OSBE framework
 *
 * THIS FILE IS GENERATED FROM TEMPLATE build/templates/permissions/permissions.sql.tmpl
 * ALL DIRECT MODIFICATIONS WILL BE LOST WITH THE NEXT BUILD PROCESS!!!
 */

/*
-- If this is the first time you execute the script, uncomment these lines
-- to create table and insert row
CREATE TABLE IF NOT EXISTS permissions (
    rules json NOT NULL
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.permissions OWNER TO glab;

INSERT INTO permissions VALUES ('{"admin":{}}');
*/

UPDATE permissions SET rules = '{
	"admin":{
		"Event":{
			"subscribe":true
			,"unsubscribe":true
			,"publish":true
		}
		,"Constant":{
			"set_value":true
			,"get_list":true
			,"get_object":true
			,"get_values":true
		}
		,"Enum":{
			"get_enum_list":true
		}
		,"MainMenuConstructor":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MainMenuContent":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"View":{
			"get_list":true
			,"complete":true
			,"get_section_list":true
		}
		,"VariantStorage":{
			"insert":true
			,"upsert_filter_data":true
			,"upsert_col_visib_data":true
			,"upsert_col_order_data":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_filter_data":true
			,"get_col_visib_data":true
			,"get_col_order_data":true
		}
		,"About":{
			"get_object":true
		}
		,"Service":{
			"reload_config":true
			,"reload_version":true
		}
		,"User":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
			,"get_profile":true
			,"reset_pwd":true
			,"login":true
			,"login_refresh":true
			,"logout":true
			,"logout_html":true
			,"download_photo":true
			,"delete_photo":true
			,"password_recover":true
		}
		,"Login":{
			"get_list":true
			,"get_object":true
			,"logout":true
		}
		,"LoginDevice":{
			"get_list":true
			,"switch_banned":true
		}
		,"Captcha":{
			"get":true
		}
		,"LoginDeviceBan":{
			"insert":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"TimeZoneLocale":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Department":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Post":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Contact":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
			,"upsert":true
		}
		,"EntityContact":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ObjectModLog":{
			"get_list":true
			,"get_object":true
		}
		,"MailMessage":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MailMessageAttachment":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MailTemplate":{
			"insert":true
			,"update":true
			,"get_list":true
			,"get_object":true
		}
		,"Attachment":{
			"get_list":true
			,"get_object":true
			,"delete_file":true
			,"get_file":true
			,"add_file":true
		}
		,"AutoMake":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"AutoModel":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_make":true
			,"get_all_years":true
		}
		,"AutoModelGeneration":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_model":true
			,"gen_next_id":true
		}
		,"AutoType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"AutoBodyType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoBodyDoor":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoBody":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_model_generation":true
			,"complete_for_model":true
		}
		,"ItemFolder":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemFeature":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemFeatureValueList":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItemFeatureValueList":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFeatureGroupItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFolderFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItemFolderFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Item":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_item":true
			,"complete":true
			,"set_feature":true
			,"get_features_filter_list":true
		}
		,"Manufacturer":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ManufacturerBrand":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Supplier":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"VehicleType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemPriority":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"PopularityType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"import":true
			,"set_feature":true
			,"get_features_filter_list":true
		}
		,"ItemSearch":{
			"get_object":true
			,"find_items":true
		}
		,"ImportItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierStore":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_supplier":true
		}
		,"SupplierStoreValue":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoPriceCategory":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoToGlassMatchHead":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoToGlassMatchEurocode":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_body_list":true
		}
		,"AutoToGlassMatchOption":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_conf_form":true
		}
		,"AutoModelGenerationBody":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"BankCard":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Employee":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"EmployeeStatus":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"PersonDocument":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"PersonDocumentType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"CashLocation":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"FinExpenseType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"CashFlowIn":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"CashFlowOut":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
	}
	,"guest":{
		"User":{
			"login":true
		}
	}
}';


-- ******************* update 19/04/2024 16:51:38 ******************
/**
 * Andrey Mikhalevich 15/12/21
 * This file is part of the OSBE framework
 *
 * THIS FILE IS GENERATED FROM TEMPLATE build/templates/permissions/permissions.sql.tmpl
 * ALL DIRECT MODIFICATIONS WILL BE LOST WITH THE NEXT BUILD PROCESS!!!
 */

/*
-- If this is the first time you execute the script, uncomment these lines
-- to create table and insert row
CREATE TABLE IF NOT EXISTS permissions (
    rules json NOT NULL
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.permissions OWNER TO glab;

INSERT INTO permissions VALUES ('{"admin":{}}');
*/

UPDATE permissions SET rules = '{
	"admin":{
		"Event":{
			"subscribe":true
			,"unsubscribe":true
			,"publish":true
		}
		,"Constant":{
			"set_value":true
			,"get_list":true
			,"get_object":true
			,"get_values":true
		}
		,"Enum":{
			"get_enum_list":true
		}
		,"MainMenuConstructor":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MainMenuContent":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"View":{
			"get_list":true
			,"complete":true
			,"get_section_list":true
		}
		,"VariantStorage":{
			"insert":true
			,"upsert_filter_data":true
			,"upsert_col_visib_data":true
			,"upsert_col_order_data":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_filter_data":true
			,"get_col_visib_data":true
			,"get_col_order_data":true
		}
		,"About":{
			"get_object":true
		}
		,"Service":{
			"reload_config":true
			,"reload_version":true
		}
		,"User":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
			,"get_profile":true
			,"reset_pwd":true
			,"login":true
			,"login_refresh":true
			,"logout":true
			,"logout_html":true
			,"download_photo":true
			,"delete_photo":true
			,"password_recover":true
		}
		,"Login":{
			"get_list":true
			,"get_object":true
			,"logout":true
		}
		,"LoginDevice":{
			"get_list":true
			,"switch_banned":true
		}
		,"Captcha":{
			"get":true
		}
		,"LoginDeviceBan":{
			"insert":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"TimeZoneLocale":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Department":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Post":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Contact":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
			,"upsert":true
		}
		,"EntityContact":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ObjectModLog":{
			"get_list":true
			,"get_object":true
		}
		,"MailMessage":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MailMessageAttachment":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MailTemplate":{
			"insert":true
			,"update":true
			,"get_list":true
			,"get_object":true
		}
		,"Attachment":{
			"get_list":true
			,"get_object":true
			,"delete_file":true
			,"get_file":true
			,"add_file":true
		}
		,"AutoMake":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"AutoModel":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_make":true
			,"get_all_years":true
		}
		,"AutoModelGeneration":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_model":true
			,"gen_next_id":true
		}
		,"AutoType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"AutoBodyType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoBodyDoor":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoBody":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_model_generation":true
			,"complete_for_model":true
		}
		,"ItemFolder":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemFeature":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemFeatureValueList":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItemFeatureValueList":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFeatureGroupItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFolderFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItemFolderFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Item":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_item":true
			,"complete":true
			,"set_feature":true
			,"get_features_filter_list":true
		}
		,"Manufacturer":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ManufacturerBrand":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Supplier":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"VehicleType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemPriority":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"PopularityType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"import":true
			,"set_feature":true
			,"get_features_filter_list":true
		}
		,"ItemSearch":{
			"get_object":true
			,"find_items":true
		}
		,"ImportItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierStore":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_supplier":true
		}
		,"SupplierStoreValue":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoPriceCategory":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoToGlassMatchHead":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoToGlassMatchEurocode":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_body_list":true
		}
		,"AutoToGlassMatchOption":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_conf_form":true
		}
		,"AutoModelGenerationBody":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"BankCard":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Employee":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"EmployeeStatus":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"PersonDocument":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"PersonDocumentType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"CashLocation":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"FinExpenseType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"CashFlowIn":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"CashFlowOut":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
	}
	,"guest":{
		"User":{
			"login":true
		}
	}
}';


-- ******************* update 19/04/2024 16:55:00 ******************
-- VIEW: public.cash_flow_out_list

--DROP VIEW public.cash_flow_out_list;

CREATE OR REPLACE VIEW public.cash_flow_out_list AS
	SELECT
		t.id
		,t.date_time
		,t.cash_location_id
		,cash_locations_ref(cash_locations_ref_t) AS cash_locations_ref
		,fin_expence_types_ref(exp1) AS fin_expence_types1_ref
		,fin_expence_types_ref(exp2) AS fin_expence_types2_ref
		,fin_expence_types_ref(exp3) AS fin_expence_types3_ref
		,t.comment_text
		,users_ref(users_ref_t) AS users_ref
		,t.total
	FROM public.cash_flow_out AS t
	LEFT JOIN cash_locations AS cash_locations_ref_t ON cash_locations_ref_t.id = t.cash_location_id
	LEFT JOIN users AS users_ref_t ON users_ref_t.id = t.user_id
	LEFT JOIN fin_expence_types AS exp1 ON exp1.id = t.fin_expence_type1_id
	LEFT JOIN fin_expence_types AS exp2 ON exp2.id = t.fin_expence_type2_id
	LEFT JOIN fin_expence_types AS exp3 ON exp3.id = t.fin_expence_type3_id
	ORDER BY t.date_time DESC
	;
	
ALTER VIEW public.cash_flow_out_list OWNER TO glab;


-- ******************* update 22/04/2024 10:25:51 ******************
/**
 * Andrey Mikhalevich 15/12/21
 * This file is part of the OSBE framework
 *
 * THIS FILE IS GENERATED FROM TEMPLATE build/templates/permissions/permissions.sql.tmpl
 * ALL DIRECT MODIFICATIONS WILL BE LOST WITH THE NEXT BUILD PROCESS!!!
 */

/*
-- If this is the first time you execute the script, uncomment these lines
-- to create table and insert row
CREATE TABLE IF NOT EXISTS permissions (
    rules json NOT NULL
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.permissions OWNER TO glab;

INSERT INTO permissions VALUES ('{"admin":{}}');
*/

UPDATE permissions SET rules = '{
	"admin":{
		"Event":{
			"subscribe":true
			,"unsubscribe":true
			,"publish":true
		}
		,"Constant":{
			"set_value":true
			,"get_list":true
			,"get_object":true
			,"get_values":true
		}
		,"Enum":{
			"get_enum_list":true
		}
		,"MainMenuConstructor":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MainMenuContent":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"View":{
			"get_list":true
			,"complete":true
			,"get_section_list":true
		}
		,"VariantStorage":{
			"insert":true
			,"upsert_filter_data":true
			,"upsert_col_visib_data":true
			,"upsert_col_order_data":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_filter_data":true
			,"get_col_visib_data":true
			,"get_col_order_data":true
		}
		,"About":{
			"get_object":true
		}
		,"Service":{
			"reload_config":true
			,"reload_version":true
		}
		,"User":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
			,"get_profile":true
			,"reset_pwd":true
			,"login":true
			,"login_refresh":true
			,"logout":true
			,"logout_html":true
			,"download_photo":true
			,"delete_photo":true
			,"password_recover":true
		}
		,"Login":{
			"get_list":true
			,"get_object":true
			,"logout":true
		}
		,"LoginDevice":{
			"get_list":true
			,"switch_banned":true
		}
		,"Captcha":{
			"get":true
		}
		,"LoginDeviceBan":{
			"insert":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"TimeZoneLocale":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Department":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Post":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Contact":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
			,"upsert":true
		}
		,"EntityContact":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ObjectModLog":{
			"get_list":true
			,"get_object":true
		}
		,"MailMessage":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MailMessageAttachment":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MailTemplate":{
			"insert":true
			,"update":true
			,"get_list":true
			,"get_object":true
		}
		,"Attachment":{
			"get_list":true
			,"get_object":true
			,"delete_file":true
			,"get_file":true
			,"add_file":true
		}
		,"AutoMake":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"AutoModel":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_make":true
			,"get_all_years":true
		}
		,"AutoModelGeneration":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_model":true
			,"gen_next_id":true
		}
		,"AutoType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"AutoBodyType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoBodyDoor":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoBody":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_model_generation":true
			,"complete_for_model":true
		}
		,"ItemFolder":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemFeature":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemFeatureValueList":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItemFeatureValueList":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFeatureGroupItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFolderFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItemFolderFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Item":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_item":true
			,"complete":true
			,"set_feature":true
			,"get_features_filter_list":true
		}
		,"Manufacturer":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ManufacturerBrand":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Supplier":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"VehicleType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemPriority":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"PopularityType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"import":true
			,"set_feature":true
			,"get_features_filter_list":true
		}
		,"ItemSearch":{
			"get_object":true
			,"find_items":true
		}
		,"ImportItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierStore":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_supplier":true
		}
		,"SupplierStoreValue":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoPriceCategory":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoToGlassMatchHead":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoToGlassMatchEurocode":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_body_list":true
		}
		,"AutoToGlassMatchOption":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_conf_form":true
		}
		,"AutoModelGenerationBody":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"BankCard":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Employee":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"EmployeeStatus":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"PersonDocument":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"PersonDocumentType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"CashLocation":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"FinExpenseType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"CashFlowIn":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"CashFlowOut":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
	}
	,"guest":{
		"User":{
			"login":true
		}
	}
}';


-- ******************* update 22/04/2024 11:53:22 ******************
DROP FUNCTION fin_expence_types_ref(fin_expense_types) CASCADE;
/*
CREATE OR REPLACE FUNCTION fin_expense_types_ref(fin_expense_types)
  RETURNS json AS
$$
	SELECT json_build_object(
		'keys',json_build_object(
			    
			),	
		'descr',$1.name,
		'dataType','fin_expense_types'
	);
$$
  LANGUAGE sql VOLATILE COST 100;
ALTER FUNCTION fin_expense_types_ref(fin_expense_types) OWNER TO glab;	
*/


-- ******************* update 22/04/2024 11:53:38 ******************
CREATE OR REPLACE FUNCTION fin_expense_types_ref(fin_expense_types)
  RETURNS json AS
$$
	SELECT json_build_object(
		'keys',json_build_object(
			    
			),	
		'descr',$1.name,
		'dataType','fin_expense_types'
	);
$$
  LANGUAGE sql VOLATILE COST 100;
ALTER FUNCTION fin_expense_types_ref(fin_expense_types) OWNER TO glab;	



-- ******************* update 22/04/2024 11:54:01 ******************
-- VIEW: public.cash_flow_out_list

--DROP VIEW public.cash_flow_out_list;

CREATE OR REPLACE VIEW public.cash_flow_out_list AS
	SELECT
		t.id
		,t.date_time
		,t.cash_location_id
		,cash_locations_ref(cash_locations_ref_t) AS cash_locations_ref
		,fin_expense_types_ref(exp1) AS fin_expense_types1_ref
		,fin_expense_types_ref(exp2) AS fin_expense_types2_ref
		,fin_expense_types_ref(exp3) AS fin_expense_types3_ref
		,t.comment_text
		,users_ref(users_ref_t) AS users_ref
		,t.total
	FROM public.cash_flow_out AS t
	LEFT JOIN cash_locations AS cash_locations_ref_t ON cash_locations_ref_t.id = t.cash_location_id
	LEFT JOIN users AS users_ref_t ON users_ref_t.id = t.user_id
	LEFT JOIN fin_expense_types AS exp1 ON exp1.id = t.fin_expense_type1_id
	LEFT JOIN fin_expense_types AS exp2 ON exp2.id = t.fin_expense_type2_id
	LEFT JOIN fin_expense_types AS exp3 ON exp3.id = t.fin_expense_type3_id
	ORDER BY t.date_time DESC
	;
	
ALTER VIEW public.cash_flow_out_list OWNER TO glab;


-- ******************* update 22/04/2024 11:55:53 ******************
-- VIEW: public.cash_flow_out_list

--DROP VIEW public.cash_flow_out_list;

CREATE OR REPLACE VIEW public.cash_flow_out_list AS
	SELECT
		t.id
		,t.date_time
		,t.cash_location_id
		,cash_locations_ref(cash_locations_ref_t) AS cash_locations_ref
		,fin_expense_types_ref(exp1) AS fin_expense_types1_ref
		,fin_expense_types_ref(exp2) AS fin_expense_types2_ref
		,fin_expense_types_ref(exp3) AS fin_expense_types3_ref
		,t.comment_text
		,users_ref(users_ref_t) AS users_ref
		,t.total
	FROM public.cash_flow_out AS t
	LEFT JOIN cash_locations AS cash_locations_ref_t ON cash_locations_ref_t.id = t.cash_location_id
	LEFT JOIN users AS users_ref_t ON users_ref_t.id = t.user_id
	LEFT JOIN fin_expense_types AS exp1 ON exp1.id = t.fin_expense_type1_id
	LEFT JOIN fin_expense_types AS exp2 ON exp2.id = t.fin_expense_type2_id
	LEFT JOIN fin_expense_types AS exp3 ON exp3.id = t.fin_expense_type3_id
	ORDER BY t.date_time DESC
	;
	
ALTER VIEW public.cash_flow_out_list OWNER TO glab;


-- ******************* update 22/04/2024 13:55:39 ******************

	-- Adding new type
	CREATE TYPE doc_types AS ENUM (
	
		'cash_flow_in'			
	,
		'cash_flow_out'			
				
	);
	ALTER TYPE doc_types OWNER TO glab;
		
	/* type get function */
	CREATE OR REPLACE FUNCTION enum_doc_types_val(doc_types,locales)
	RETURNS text AS $$
		SELECT
		CASE
		WHEN $1='cash_flow_in'::doc_types AND $2='ru'::locales THEN 'ПКО'
		WHEN $1='cash_flow_out'::doc_types AND $2='ru'::locales THEN 'РКО'
		ELSE ''
		END;		
	$$ LANGUAGE sql;	
	ALTER FUNCTION enum_doc_types_val(doc_types,locales) OWNER TO glab;		
	

-- ******************* update 22/04/2024 14:01:58 ******************

	
	-- ********** Adding new table from model **********
	CREATE TABLE public.ra_cash_flow
	(id serial NOT NULL,date_time timestamp NOT NULL,deb bool,doc_type doc_types NOT NULL,doc_id int,cash_location_id int NOT NULL REFERENCES cash_locations(id),total  numeric(15,2),CONSTRAINT ra_cash_flow_pkey PRIMARY KEY (id)
	);
	
	DROP INDEX IF EXISTS ra_cash_flow_date_time_idx;
	CREATE INDEX ra_cash_flow_date_time_idx
	ON ra_cash_flow(date_time);

	DROP INDEX IF EXISTS ra_cash_flow_doc_idx;
	CREATE INDEX ra_cash_flow_doc_idx
	ON ra_cash_flow(doc_type,doc_id);

	DROP INDEX IF EXISTS ra_cash_flow_location_id_idx;
	CREATE INDEX ra_cash_flow_location_id_idx
	ON ra_cash_flow(cash_location_id);

	ALTER TABLE public.ra_cash_flow OWNER TO glab;
	
					



-- ******************* update 22/04/2024 14:02:19 ******************
-- ADD
CREATE OR REPLACE FUNCTION ra_cash_flow_add_act(reg_act ra_cash_flow)
RETURNS void AS
$BODY$
	INSERT INTO ra_cash_flow
	(date_time,doc_type,doc_id
	,deb
	,cash_location_id				
	)
	VALUES (
	$1.date_time,$1.doc_type,$1.doc_id
	,$1.deb
	,$1.cash_location_id				
	);
$BODY$
LANGUAGE sql VOLATILE STRICT COST 100;

ALTER FUNCTION ra_cash_flow_add_act(reg_act ra_cash_flow) OWNER TO glab;



-- ******************* update 22/04/2024 14:02:23 ******************
-- REMOVE
CREATE OR REPLACE FUNCTION ra_cash_flow_remove_acts(in_doc_type doc_types,in_doc_id int)
RETURNS void AS
$BODY$
	DELETE FROM ra_cash_flow
	WHERE doc_type=$1 AND doc_id=$2;
$BODY$
LANGUAGE sql VOLATILE STRICT COST 100;

ALTER FUNCTION ra_cash_flow_remove_acts(in_doc_type doc_types,in_doc_id int) OWNER TO glab;



-- ******************* update 22/04/2024 14:02:26 ******************
--DROP VIEW ra_cash_flow_list;
CREATE OR REPLACE VIEW ra_cash_flow_list AS
	SELECT
		ra_cash_flow.id,
		ra_cash_flow.date_time,
		ra_cash_flow.deb,
		ra_cash_flow.doc_type,
		ra_cash_flow.doc_id,
		CASE ra_cash_flow.doc_type
			WHEN 'cash_flow_in' THEN 'РКО'
			WHEN 'cash_flow_out' THEN 'ПКО'
		END AS doc_descr
	FROM ra_cash_flow
;

ALTER TABLE ra_cash_flow_list OWNER TO glab;



-- ******************* update 22/04/2024 14:04:30 ******************

	-- Adding new type
	CREATE TYPE reg_types AS ENUM (
	
		'cash_flow'			
				
	);
	ALTER TYPE reg_types OWNER TO glab;
		
	/* type get function */
	CREATE OR REPLACE FUNCTION enum_reg_types_val(reg_types,locales)
	RETURNS text AS $$
		SELECT
		CASE
		WHEN $1='cash_flow'::reg_types AND $2='ru'::locales THEN 'Остатки в кассе'
		ELSE ''
		END;		
	$$ LANGUAGE sql;	
	ALTER FUNCTION enum_reg_types_val(reg_types,locales) OWNER TO glab;		
	

-- ******************* update 22/04/2024 14:08:08 ******************
-- FUNCTION: public.ra_cash_flow_process()

-- DROP FUNCTION IF EXISTS public.ra_cash_flow_process();

CREATE OR REPLACE FUNCTION public.ra_cash_flow_process()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
DECLARE
	v_delta_total  numeric(15,2) DEFAULT 0;
	CALC_DATE_TIME timestamp without time zone;
	CURRENT_BALANCE_DATE_TIME timestamp without time zone;
	v_loop_rg_period timestamp;
	v_calc_interval interval;			  			
BEGIN
	IF (TG_WHEN='BEFORE' AND TG_OP='INSERT') THEN
		RETURN NEW;
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='UPDATE') THEN
		RETURN NEW;
	ELSIF (TG_WHEN='AFTER' AND (TG_OP='UPDATE' OR TG_OP='INSERT')) THEN
		CALC_DATE_TIME = rg_calc_period('cash_flow'::reg_types);
		IF (CALC_DATE_TIME IS NULL) OR (NEW.date_time::date > rg_period_balance('cash_flow'::reg_types, CALC_DATE_TIME)) THEN
			CALC_DATE_TIME = rg_period('cash_flow'::reg_types,NEW.date_time);
			PERFORM rg_cash_flow_set_custom_period(CALC_DATE_TIME);						
		END IF;
		
		IF TG_OP='UPDATE' AND
		(NEW.date_time<>OLD.date_time
		) THEN
			--delete old data completely
			PERFORM rg_cash_flow_update_periods(OLD.date_time, OLD.cash_flow_silos_id,-1*OLD.total);
			v_delta_total = 0;
		ELSIF TG_OP='UPDATE' THEN						
			v_delta_total = OLD.total;
		ELSE
			v_delta_total = 0;
		END IF;
		
		v_delta_total = NEW.total - v_delta_total;
		IF NOT NEW.deb THEN
			v_delta_total = -1 * v_delta_total;
		END IF;

		PERFORM rg_cash_flow_update_periods(NEW.date_time, NEW.cash_flow_silos_id, v_delta_total);

		RETURN NEW;					
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='DELETE') THEN
		RETURN OLD;
	ELSIF (TG_WHEN='AFTER' AND TG_OP='DELETE') THEN
		CALC_DATE_TIME = rg_calc_period('cash_flow'::reg_types);
		IF (CALC_DATE_TIME IS NULL) OR (OLD.date_time::date > rg_period_balance('cash_flow'::reg_types, CALC_DATE_TIME)) THEN
			CALC_DATE_TIME = rg_period('cash_flow'::reg_types,OLD.date_time);
			PERFORM rg_cash_flow_set_custom_period(CALC_DATE_TIME);						
		END IF;
		v_delta_total = OLD.total;
		IF OLD.deb THEN
			v_delta_total = -1*v_delta_total;					
		END IF;

		PERFORM rg_cash_flow_update_periods(OLD.date_time, OLD.cash_flow_silos_id,v_delta_total);
		
		RETURN OLD;					
	END IF;
END;

$BODY$;

ALTER FUNCTION public.ra_cash_flow_process()
    OWNER TO glab;



-- ******************* update 22/04/2024 14:20:33 ******************
-- FUNCTION: public.rg_period(reg_types, timestamp without time zone)

-- DROP FUNCTION IF EXISTS public.rg_period(reg_types, timestamp without time zone);

CREATE OR REPLACE FUNCTION public.rg_period(
	in_reg_type reg_types,
	in_date_time timestamp without time zone)
    RETURNS timestamp without time zone
    LANGUAGE 'sql'
    COST 100
    IMMUTABLE PARALLEL UNSAFE
AS $BODY$
	SELECT date_trunc('MONTH', in_date_time)::timestamp without time zone;
$BODY$;

ALTER FUNCTION public.rg_period(reg_types, timestamp without time zone)
    OWNER TO glab;



-- ******************* update 22/04/2024 14:22:34 ******************
CREATE OR REPLACE FUNCTION rg_cash_flow_set_custom_period(IN in_new_period timestamp without time zone)
  RETURNS void AS
$BODY$
DECLARE
	NEW_PERIOD timestamp without time zone;
	v_prev_current_period timestamp without time zone;
	v_current_period timestamp without time zone;
	CURRENT_PERIOD timestamp without time zone;
	TA_PERIOD timestamp without time zone;
	REG_INTERVAL interval;
BEGIN
	NEW_PERIOD = rg_calc_period_start('cash_flow'::reg_types, in_new_period);
	SELECT date_time INTO CURRENT_PERIOD FROM rg_calc_periods WHERE reg_type = 'cash_flow'::reg_types;
	TA_PERIOD = reg_current_balance_time();
	--iterate through all periods between CURRENT_PERIOD and NEW_PERIOD
	REG_INTERVAL = rg_calc_interval('cash_flow'::reg_types);
	v_prev_current_period = CURRENT_PERIOD;		
	LOOP
		v_current_period = v_prev_current_period + REG_INTERVAL;
		IF v_current_period > NEW_PERIOD THEN
			EXIT;  -- exit loop
		END IF;
		
		--clear period
		DELETE FROM rg_cash_flow
		WHERE date_time = v_current_period;
		
		--new data
		INSERT INTO rg_cash_flow
		(date_time
		
		,cash_location_id
		,total						
		)
		(SELECT
				v_current_period
				
				,rg.cash_location_id
				,rg.total				
			FROM rg_cash_flow As rg
			WHERE (
			
			rg.total<>0
										
			)
			AND (rg.date_time=v_prev_current_period)
		);

		v_prev_current_period = v_current_period;
	END LOOP;

	--new TA data
	DELETE FROM rg_cash_flow
	WHERE date_time=TA_PERIOD;
	INSERT INTO rg_cash_flow
	(date_time
	
	,cash_location_id
	,total	
	)
	(SELECT
		TA_PERIOD
		
		,rg.cash_location_id
		,rg.total
		FROM rg_materials AS rg
		WHERE (
		
		rg.total<>0
											
		)
		AND (rg.date_time=NEW_PERIOD-REG_INTERVAL)
	);

	DELETE FROM rg_materials WHERE (date_time>NEW_PERIOD)
	AND (date_time<>TA_PERIOD);

	--set new period
	UPDATE rg_calc_periods SET date_time = NEW_PERIOD
	WHERE reg_type='cash_flow'::reg_types;		
END
$BODY$
LANGUAGE plpgsql VOLATILE COST 100;

ALTER FUNCTION rg_cash_flow_set_custom_period(IN in_new_period timestamp without time zone) OWNER TO glab;




-- ******************* update 22/04/2024 14:23:30 ******************
-- Function: rg_current_balance_time()

-- DROP FUNCTION rg_current_balance_time();

CREATE OR REPLACE FUNCTION rg_current_balance_time()
  RETURNS timestamp without time zone AS
$BODY$
	SELECT '3000-01-01 00:00:00'::timestamp without time zone;
$BODY$
LANGUAGE sql IMMUTABLE COST 100;
ALTER FUNCTION rg_current_balance_time() OWNER TO glab;



-- ******************* update 22/04/2024 14:24:14 ******************
--********** Calc interval for a reginster ***************************************** 
CREATE OR REPLACE FUNCTION rg_calc_interval(in_reg_type reg_types)
  RETURNS interval AS
$BODY$
	SELECT
		CASE $1
						
		WHEN 'cash_flow'::reg_types THEN '1 month'::interval
		
		END;
$BODY$
  LANGUAGE sql IMMUTABLE COST 100;
ALTER FUNCTION rg_calc_interval(reg_types) OWNER TO glab;



-- ******************* update 22/04/2024 14:25:20 ******************
--***** Table for current periods on registers *************************
CREATE TABLE IF NOT EXISTS rg_calc_periods(
  reg_type reg_types NOT NULL,
  date_time timestamp NOT NULL,
  CONSTRAINT rg_calc_periods_pkey PRIMARY KEY (reg_type)
);
ALTER TABLE rg_calc_periods OWNER TO glab;
--*****************************************************

--Populate with data
INSERT INTO rg_calc_periods VALUES

	('cash_flow'::reg_types,'2014-01-01 00:00:00'::timestamp without time zone)
;




-- ******************* update 22/04/2024 14:25:34 ******************
--********** Calc interval for a reginster ***************************************** 
CREATE OR REPLACE FUNCTION rg_calc_interval(in_reg_type reg_types)
  RETURNS interval AS
$BODY$
	SELECT
		CASE $1
						
		WHEN 'cash_flow'::reg_types THEN '1 month'::interval
		
		END;
$BODY$
  LANGUAGE sql IMMUTABLE COST 100;
ALTER FUNCTION rg_calc_interval(reg_types) OWNER TO glab;



-- ******************* update 22/04/2024 14:26:07 ******************
-- Function: rg_calc_period(reg_types)

-- DROP FUNCTION rg_calc_period(reg_types);

/**
 * Возвращает период рассчитанных итогов по регистру
 */
CREATE OR REPLACE FUNCTION rg_calc_period(in_reg_type reg_types)
  RETURNS timestamp without time zone AS
$BODY$
	SELECT
		coalesce(
			(SELECT date_time FROM rg_calc_periods WHERE reg_type=$1)
			,now()::date+' 00:00:00'::interval
		)
	;
$BODY$
  LANGUAGE sql STABLE
  COST 100;
ALTER FUNCTION rg_calc_period(reg_types) OWNER TO glab;



-- ******************* update 22/04/2024 14:26:29 ******************
-- FUNCTION: public.rg_period(reg_types, timestamp without time zone)

-- DROP FUNCTION IF EXISTS public.rg_period(reg_types, timestamp without time zone);

CREATE OR REPLACE FUNCTION public.rg_period(
	in_reg_type reg_types,
	in_date_time timestamp without time zone)
    RETURNS timestamp without time zone
    LANGUAGE 'sql'
    COST 100
    IMMUTABLE PARALLEL UNSAFE
AS $BODY$
	SELECT date_trunc('MONTH', in_date_time)::timestamp without time zone;
$BODY$;

ALTER FUNCTION public.rg_period(reg_types, timestamp without time zone)
    OWNER TO glab;



-- ******************* update 22/04/2024 14:29:32 ******************
-- Function: last_month_day(date)

-- DROP FUNCTION last_month_day(date);

CREATE OR REPLACE FUNCTION last_month_day(date)
  RETURNS date AS
$BODY$
 	SELECT (date_trunc('MONTH', $1) + INTERVAL '1 MONTH - 1 day')::date;
$BODY$
  LANGUAGE sql IMMUTABLE STRICT
  COST 100;
ALTER FUNCTION last_month_day(date)
  OWNER TO glab;



-- ******************* update 22/04/2024 14:29:35 ******************
-- Function: last_month_day(date)

-- DROP FUNCTION last_month_day(date);

CREATE OR REPLACE FUNCTION last_month_day(date)
  RETURNS date AS
$BODY$
 	SELECT (date_trunc('MONTH', $1) + INTERVAL '1 MONTH - 1 day')::date;
$BODY$
  LANGUAGE sql IMMUTABLE STRICT
  COST 100;
ALTER FUNCTION last_month_day(date)
  OWNER TO glab;



-- ******************* update 22/04/2024 14:29:40 ******************
-- Function: rg_calc_period_end(reg_types, timestamp without time zone)

-- DROP FUNCTION rg_calc_period_end(reg_types, timestamp without time zone);

/**
 * Возвращает дату конца периода итогов по любой дате
 */ 

CREATE OR REPLACE FUNCTION rg_calc_period_end(
    in_reg_type reg_types,
    in_date_time timestamp without time zone)
  RETURNS timestamp without time zone AS
$BODY$
	SELECT
		CASE
			WHEN rg_calc_interval(in_reg_type)='1 month' THEN
				last_month_day(in_date_time::date)+'23:59:59.999'::interval
			WHEN rg_calc_interval(in_reg_type)='1 day' THEN
				in_date_time::date+'23:59:59.999'::interval
		END	
	;
$BODY$
  LANGUAGE sql IMMUTABLE
  COST 100;
ALTER FUNCTION rg_calc_period_end(reg_types, timestamp without time zone)
  OWNER TO glab;



-- ******************* update 22/04/2024 14:29:43 ******************
-- Function: rg_period_balance(reg_types, timestamp without time zone)

-- DROP FUNCTION rg_period_balance(reg_types, timestamp without time zone);

CREATE OR REPLACE FUNCTION rg_period_balance(
    in_reg_type reg_types,
    in_date_time timestamp without time zone)
  RETURNS timestamp without time zone AS
$BODY$
	SELECT
		rg_calc_period_end(in_reg_type,in_date_time) - '0.000001 second'::interval
	;
$BODY$
  LANGUAGE sql IMMUTABLE
  COST 100;
ALTER FUNCTION rg_period_balance(reg_types, timestamp without time zone) OWNER TO glab;



-- ******************* update 22/04/2024 14:30:01 ******************

	
	-- ********** Adding new table from model **********
	CREATE TABLE public.rg_cash_flow
	(id serial NOT NULL,date_time timestamp NOT NULL,cash_location_id int REFERENCES cash_locations(id),total  numeric(15,2),CONSTRAINT rg_cash_flow_pkey PRIMARY KEY (id)
	);
	
	DROP INDEX IF EXISTS rg_cash_flow_date_time_idx;
	CREATE INDEX rg_cash_flow_date_time_idx
	ON rg_cash_flow(date_time);

	DROP INDEX IF EXISTS rg_cash_flow_location_id_idx;
	CREATE INDEX rg_cash_flow_location_id_idx
	ON rg_cash_flow(cash_location_id);

	ALTER TABLE public.rg_cash_flow OWNER TO glab;
	
	



-- ******************* update 22/04/2024 14:30:44 ******************
-- Table: doc_log

-- DROP TABLE doc_log;

CREATE TABLE doc_log
(
  id serial NOT NULL,
  doc_type doc_types,
  doc_id integer,
  date_time timestampTZ,
  CONSTRAINT doc_log_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE doc_log OWNER TO glab;

-- Index: doc_log_date_time_index

-- DROP INDEX doc_log_date_time_idx;

CREATE INDEX doc_log_date_time_idx ON doc_log USING btree (date_time);

-- Index: doc_log_doc_idx

-- DROP INDEX doc_log_doc_idx;

CREATE INDEX doc_log_doc_idx ON doc_log USING btree (doc_type, doc_id);




-- ******************* update 22/04/2024 14:30:53 ******************

CREATE OR REPLACE FUNCTION rg_cash_flow_balance(in_date_time timestamp,
	
	IN in_cash_location_id_ar int[]
					
	)

  RETURNS TABLE(
	cash_location_id int
	,
	total  numeric(15,2)				
	) AS
$BODY$
	WITH
	cur_per AS (SELECT rg_period('cash_flow'::reg_types, in_date_time) AS v ),
	
	act_forward AS (
		SELECT
			rg_period_balance('cash_flow'::reg_types,in_date_time) - in_date_time >
			(SELECT t.v FROM cur_per t) - in_date_time
			AS v
	),
	
	act_sg AS (SELECT CASE WHEN t.v THEN 1 ELSE -1 END AS v FROM act_forward t)

	SELECT 
	
	sub.cash_location_id
	,SUM(sub.total) AS total				
	FROM(
		(SELECT
		
		b.cash_location_id
		,b.total				
		FROM rg_cash_flow AS b
		WHERE
		
		(
			--date bigger than last calc period
			(in_date_time > rg_period_balance('cash_flow'::reg_types,rg_calc_period('cash_flow'::reg_types)) AND b.date_time = (SELECT rg_current_balance_time()))
			
			OR (
			--forward from previous period
			( (SELECT t.v FROM act_forward t) AND b.date_time = (SELECT t.v FROM cur_per t)-rg_calc_interval('cash_flow'::reg_types)
			)
			--backward from current
			OR			
			( NOT (SELECT t.v FROM act_forward t) AND b.date_time = (SELECT t.v FROM cur_per t)
			)
			
			)
		)	
		
				
		AND ( (in_cash_location_id_ar IS NULL OR ARRAY_LENGTH(in_cash_location_id_ar,1) IS NULL) OR (b.cash_location_id=ANY(in_cash_location_id_ar)))
		
		AND (
		b.total<>0
		)
		)
		
		UNION ALL
		
		(SELECT
		
		act.cash_location_id
		,CASE act.deb
			WHEN TRUE THEN act.total * (SELECT t.v FROM act_sg t)
			ELSE -act.total * (SELECT t.v FROM act_sg t)
		END AS quant
										
		FROM doc_log
		LEFT JOIN ra_cash_flow AS act ON act.doc_type=doc_log.doc_type AND act.doc_id=doc_log.doc_id
		WHERE
		(
			--forward from previous period
			( (SELECT t.v FROM act_forward t) AND
					act.date_time >= (SELECT t.v FROM cur_per t)
					AND act.date_time <= 
						(SELECT l.date_time FROM doc_log l
						WHERE date_trunc('second',l.date_time)<=date_trunc('second',in_date_time)
						ORDER BY l.date_time DESC LIMIT 1
						)
					
			)
			--backward from current
			OR			
			( NOT (SELECT t.v FROM act_forward t) AND
					act.date_time >= 
						(SELECT l.date_time FROM doc_log l
						WHERE date_trunc('second',l.date_time)>=date_trunc('second',in_date_time)
						ORDER BY l.date_time ASC LIMIT 1
						)			
					AND act.date_time <= (SELECT t.v FROM cur_per t)
			)
		)
			
		
		AND (in_cash_location_id_ar IS NULL OR ARRAY_LENGTH(in_cash_location_id_ar,1) IS NULL OR (act.cash_location_id=ANY(in_cash_location_id_ar)))
		
		AND (
		
		act.total<>0
		)
		ORDER BY doc_log.date_time,doc_log.id)
	) AS sub
	WHERE
	 (ARRAY_LENGTH(in_cash_location_id_ar,1) IS NULL OR (sub.cash_location_id=ANY(in_cash_location_id_ar)))
		
	GROUP BY
		
		sub.cash_location_id
	HAVING
		
		SUM(sub.total)<>0
						
	ORDER BY
		
		sub.cash_location_id;
$BODY$
  LANGUAGE sql VOLATILE CALLED ON NULL INPUT
  COST 100;

ALTER FUNCTION rg_cash_flow_balance(in_date_time timestamp,
	
	IN in_cash_location_id_ar int[]
					
	)
 OWNER TO glab;




-- ******************* update 22/04/2024 14:33:03 ******************
-- Function: doc_log_delete(doc_types, integer)

-- DROP FUNCTION doc_log_delete(doc_types, integer);

CREATE OR REPLACE FUNCTION doc_log_delete(
    doc_types,
    integer)
  RETURNS void AS
$BODY$
	DELETE FROM doc_log WHERE doc_type=$1 AND doc_id=$2;
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION doc_log_delete(doc_types, integer)
  OWNER TO glab;



-- ******************* update 22/04/2024 14:33:08 ******************
-- Function: doc_log_insert(doc_types, integer, timestampTZ)

-- DROP FUNCTION doc_log_insert(doc_types, integer, timestampTZ);

CREATE OR REPLACE FUNCTION doc_log_insert(
    doc_types,
    integer,
    timestampTZ)
  RETURNS void AS
$BODY$
	INSERT INTO doc_log (doc_type,doc_id,date_time) VALUES ($1,$2,$3);
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION doc_log_insert(doc_types, integer, timestampTZ)
  OWNER TO glab;



-- ******************* update 22/04/2024 14:33:16 ******************
-- Function: doc_log_update(doc_types, integer, timestampTZ)

-- DROP FUNCTION doc_log_update(doc_types, integer, timestampTZ);

CREATE OR REPLACE FUNCTION doc_log_update(
    doc_types,
    integer,
    timestampTZ)
  RETURNS void AS
$BODY$
	UPDATE doc_log SET date_time=$3 WHERE doc_type=$1 AND doc_id=$2;
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION doc_log_update(doc_types, integer, timestampTZ)
  OWNER TO glab;



-- ******************* update 22/04/2024 14:39:46 ******************
-- Function: public.cash_flow_in_process()

-- DROP FUNCTION public.cash_flow_in_process();

CREATE OR REPLACE FUNCTION public.cash_flow_in_process()
  RETURNS trigger AS
$BODY$
DECLARE
	reg_act ra_cash_flow%ROWTYPE;
BEGIN
	IF (TG_WHEN='BEFORE' AND TG_OP='INSERT') THEN
		--IF NEW.date_time < '2024-01-01T00:00:00'::timestamp THEN
		--	RAISE EXCEPTION 'Дата запрета редактирования: %', '2024-01-01T00:00:00'::timestamp;
		--END IF;
		
		RETURN NEW;
		
	ELSIF (TG_WHEN='AFTER') AND (TG_OP='INSERT' OR TG_OP='UPDATE') THEN					
		IF (TG_OP='INSERT') THEN						
			--log
			PERFORM doc_log_insert('cash_flow_in'::doc_types,NEW.id,NEW.date_time);
		END IF;

		--register actions ra_cash_flow
		reg_act.date_time		= NEW.date_time;
		reg_act.deb			= true;
		reg_act.doc_type  		= 'cash_flow_in'::doc_types;
		reg_act.doc_id  		= NEW.id;
		reg_act.cash_location_id	= NEW.cash_location_id;
		reg_act.total			= NEW.total;
		PERFORM ra_cash_flow_add_act(reg_act);	
		
		RETURN NEW;
		
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='UPDATE') THEN
		--IF NEW.date_time < '2024-01-01T00:00:00'::timestamp THEN
		--	RAISE EXCEPTION 'Дата запрета редактирования: %', '2024-01-01T00:00:00'::timestamp;
		--END IF;
	
		PERFORM ra_cash_flow_remove_acts('cash_flow_in'::doc_types,OLD.id);

		-- Временно!
		IF NEW.date_time<>OLD.date_time THEN
			PERFORM doc_log_update('cash_flow_in'::doc_types,NEW.id,NEW.date_time);
		END IF;
						
		RETURN NEW;
		
	ELSIF (TG_WHEN='AFTER' AND TG_OP='DELETE') THEN
	
		RETURN OLD;
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='DELETE') THEN
		--IF OLD.date_time < '2024-01-01T00:00:00'::timestamp THEN
		--	RAISE EXCEPTION 'Дата запрета редактирования: %', '2024-01-01T00:00:00'::timestamp;
		--END IF;
	
		--detail tables
		
		--register actions										
		PERFORM ra_cash_flow_remove_acts('cash_flow_in'::doc_types,OLD.id);
		
		--log
		PERFORM doc_log_delete('cash_flow_in'::doc_types,OLD.id);
		
		RETURN OLD;
	END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.cash_flow_in_process()
  OWNER TO glab;



-- ******************* update 22/04/2024 14:41:28 ******************
-- Trigger: cash_flow_in_before

-- DROP TRIGGER cash_flow_in_before ON public.cash_flow_in;

CREATE TRIGGER cash_flow_in_before
    BEFORE INSERT OR DELETE OR UPDATE 
    ON public.cash_flow_in
    FOR EACH ROW
    EXECUTE PROCEDURE public.cash_flow_in_process();
    
-- Trigger: cash_flow_in_after

--DROP TRIGGER cash_flow_in_after ON public.cash_flow_in;

CREATE TRIGGER cash_flow_in_after
    AFTER INSERT OR DELETE OR UPDATE 
    ON public.cash_flow_in
    FOR EACH ROW
    EXECUTE PROCEDURE public.cash_flow_in_process();    



-- ******************* update 22/04/2024 14:47:40 ******************
-- before trigger
CREATE TRIGGER ra_cash_flow_before
	BEFORE INSERT OR UPDATE OR DELETE ON ra_cash_flow
	FOR EACH ROW EXECUTE PROCEDURE ra_cash_flow_process();
	
-- after trigger
CREATE TRIGGER ra_cash_flow_after
	AFTER INSERT OR UPDATE OR DELETE ON ra_cash_flow
	FOR EACH ROW EXECUTE PROCEDURE ra_cash_flow_process();



-- ******************* update 22/04/2024 14:48:08 ******************
-- Function: rg_calc_period_start(reg_types, timestamp without time zone)

-- DROP FUNCTION rg_calc_period_start(reg_types, timestamp without time zone);

/**
 * Возвращает дату начала периода итогов по любой дате
 */ 
CREATE OR REPLACE FUNCTION rg_calc_period_start(
    in_reg_type reg_types,
    in_date_time  timestamp without time zone)
  RETURNS timestamp without time zone AS
$BODY$
	SELECT
		CASE
			WHEN rg_calc_interval(in_reg_type)='1 month' THEN
				date_trunc('month', in_date_time)
			WHEN rg_calc_interval(in_reg_type)='1 day' THEN
				in_date_time::date+'00:00:00'::interval
		END
	;
$BODY$
  LANGUAGE sql IMMUTABLE
  COST 100;
ALTER FUNCTION rg_calc_period_start(reg_types,  timestamp without time zone)
  OWNER TO glab;



-- ******************* update 22/04/2024 14:49:16 ******************
-- FUNCTION: public.reg_current_balance_time()

-- DROP FUNCTION IF EXISTS public.reg_current_balance_time();

CREATE OR REPLACE FUNCTION public.reg_current_balance_time(
	)
    RETURNS timestamp without time zone
    LANGUAGE 'sql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
			SELECT '3000-01-01 00:00:00'::timestamp without time zone;
		
$BODY$;

ALTER FUNCTION public.reg_current_balance_time()
    OWNER TO glab;



-- ******************* update 22/04/2024 14:52:49 ******************
CREATE OR REPLACE FUNCTION rg_cash_flow_set_custom_period(IN in_new_period timestamp without time zone)
  RETURNS void AS
$BODY$
DECLARE
	NEW_PERIOD timestamp without time zone;
	v_prev_current_period timestamp without time zone;
	v_current_period timestamp without time zone;
	CURRENT_PERIOD timestamp without time zone;
	TA_PERIOD timestamp without time zone;
	REG_INTERVAL interval;
BEGIN
	NEW_PERIOD = rg_calc_period_start('cash_flow'::reg_types, in_new_period);
	SELECT date_time INTO CURRENT_PERIOD FROM rg_calc_periods WHERE reg_type = 'cash_flow'::reg_types;
	TA_PERIOD = reg_current_balance_time();
	--iterate through all periods between CURRENT_PERIOD and NEW_PERIOD
	REG_INTERVAL = rg_calc_interval('cash_flow'::reg_types);
	v_prev_current_period = CURRENT_PERIOD;		
	LOOP
		v_current_period = v_prev_current_period + REG_INTERVAL;
		IF v_current_period > NEW_PERIOD THEN
			EXIT;  -- exit loop
		END IF;
		
		--clear period
		DELETE FROM rg_cash_flow
		WHERE date_time = v_current_period;
		
		--new data
		INSERT INTO rg_cash_flow
		(date_time
		
		,cash_location_id
		,total						
		)
		(SELECT
				v_current_period
				
				,rg.cash_location_id
				,rg.total				
			FROM rg_cash_flow As rg
			WHERE (
			
			rg.total<>0
										
			)
			AND (rg.date_time=v_prev_current_period)
		);

		v_prev_current_period = v_current_period;
	END LOOP;

	--new TA data
	DELETE FROM rg_cash_flow
	WHERE date_time=TA_PERIOD;
	INSERT INTO rg_cash_flow
	(date_time
	
	,cash_location_id
	,total	
	)
	(SELECT
		TA_PERIOD
		
		,rg.cash_location_id
		,rg.total
		FROM rg_cash_flow AS rg
		WHERE (
		
		rg.total<>0
											
		)
		AND (rg.date_time=NEW_PERIOD-REG_INTERVAL)
	);

	DELETE FROM rg_cash_flow WHERE (date_time>NEW_PERIOD)
	AND (date_time<>TA_PERIOD);

	--set new period
	UPDATE rg_calc_periods SET date_time = NEW_PERIOD
	WHERE reg_type='cash_flow'::reg_types;		
END
$BODY$
LANGUAGE plpgsql VOLATILE COST 100;

ALTER FUNCTION rg_cash_flow_set_custom_period(IN in_new_period timestamp without time zone) OWNER TO glab;




-- ******************* update 22/04/2024 14:55:48 ******************
-- ADD
CREATE OR REPLACE FUNCTION ra_cash_flow_add_act(reg_act ra_cash_flow)
RETURNS void AS
$BODY$
	INSERT INTO ra_cash_flow
	(date_time,doc_type,doc_id
	,deb
	,cash_location_id				
	)
	VALUES (
	$1.date_time,$1.doc_type,$1.doc_id
	,$1.deb
	,$1.cash_location_id				
	);
$BODY$
LANGUAGE sql VOLATILE STRICT COST 100;

ALTER FUNCTION ra_cash_flow_add_act(reg_act ra_cash_flow) OWNER TO glab;



-- ******************* update 22/04/2024 14:56:25 ******************
-- FUNCTION: public.ra_cash_flow_process()

-- DROP FUNCTION IF EXISTS public.ra_cash_flow_process();

CREATE OR REPLACE FUNCTION public.ra_cash_flow_process()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
DECLARE
	v_delta_total  numeric(15,2) DEFAULT 0;
	CALC_DATE_TIME timestamp without time zone;
	CURRENT_BALANCE_DATE_TIME timestamp without time zone;
	v_loop_rg_period timestamp;
	v_calc_interval interval;			  			
BEGIN
	IF (TG_WHEN='BEFORE' AND TG_OP='INSERT') THEN
		RETURN NEW;
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='UPDATE') THEN
		RETURN NEW;
	ELSIF (TG_WHEN='AFTER' AND (TG_OP='UPDATE' OR TG_OP='INSERT')) THEN
		CALC_DATE_TIME = rg_calc_period('cash_flow'::reg_types);
		IF (CALC_DATE_TIME IS NULL) OR (NEW.date_time::date > rg_period_balance('cash_flow'::reg_types, CALC_DATE_TIME)) THEN
			CALC_DATE_TIME = rg_period('cash_flow'::reg_types,NEW.date_time);
			PERFORM rg_cash_flow_set_custom_period(CALC_DATE_TIME);						
		END IF;
		
		IF TG_OP='UPDATE' AND
		(NEW.date_time<>OLD.date_time
		) THEN
			--delete old data completely
			PERFORM rg_cash_flow_update_periods(OLD.date_time, OLD.cash_flow_silos_id,-1*OLD.total);
			v_delta_total = 0;
		ELSIF TG_OP='UPDATE' THEN						
			v_delta_total = OLD.total;
		ELSE
			v_delta_total = 0;
		END IF;
		
		v_delta_total = NEW.total - v_delta_total;
		IF NOT NEW.deb THEN
			v_delta_total = -1 * v_delta_total;
		END IF;

		PERFORM rg_cash_flow_update_periods(NEW.date_time, NEW.cash_flow_silos_id, v_delta_total);

		RETURN NEW;					
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='DELETE') THEN
		RETURN OLD;
	ELSIF (TG_WHEN='AFTER' AND TG_OP='DELETE') THEN
		CALC_DATE_TIME = rg_calc_period('cash_flow'::reg_types);
		IF (CALC_DATE_TIME IS NULL) OR (OLD.date_time::date > rg_period_balance('cash_flow'::reg_types, CALC_DATE_TIME)) THEN
			CALC_DATE_TIME = rg_period('cash_flow'::reg_types,OLD.date_time);
			PERFORM rg_cash_flow_set_custom_period(CALC_DATE_TIME);						
		END IF;
		v_delta_total = OLD.total;
		IF OLD.deb THEN
			v_delta_total = -1*v_delta_total;					
		END IF;

		PERFORM rg_cash_flow_update_periods(OLD.date_time, OLD.cash_flow_silos_id,v_delta_total);
		
		RETURN OLD;					
	END IF;
END;

$BODY$;

ALTER FUNCTION public.ra_cash_flow_process()
    OWNER TO glab;



-- ******************* update 22/04/2024 14:57:10 ******************
-- FUNCTION: public.ra_cash_flow_process()

-- DROP FUNCTION IF EXISTS public.ra_cash_flow_process();

CREATE OR REPLACE FUNCTION public.ra_cash_flow_process()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
DECLARE
	v_delta_total  numeric(15,2) DEFAULT 0;
	CALC_DATE_TIME timestamp without time zone;
	CURRENT_BALANCE_DATE_TIME timestamp without time zone;
	v_loop_rg_period timestamp;
	v_calc_interval interval;			  			
BEGIN
	IF (TG_WHEN='BEFORE' AND TG_OP='INSERT') THEN
		RETURN NEW;
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='UPDATE') THEN
		RETURN NEW;
	ELSIF (TG_WHEN='AFTER' AND (TG_OP='UPDATE' OR TG_OP='INSERT')) THEN
		CALC_DATE_TIME = rg_calc_period('cash_flow'::reg_types);
		IF (CALC_DATE_TIME IS NULL) OR (NEW.date_time::date > rg_period_balance('cash_flow'::reg_types, CALC_DATE_TIME)) THEN
			CALC_DATE_TIME = rg_period('cash_flow'::reg_types,NEW.date_time);
			PERFORM rg_cash_flow_set_custom_period(CALC_DATE_TIME);						
		END IF;
		
		IF TG_OP='UPDATE' AND
		(NEW.date_time<>OLD.date_time
		) THEN
			--delete old data completely
			PERFORM rg_cash_flow_update_periods(OLD.date_time, OLD.cash_flow_location_id,-1*OLD.total);
			v_delta_total = 0;
		ELSIF TG_OP='UPDATE' THEN						
			v_delta_total = OLD.total;
		ELSE
			v_delta_total = 0;
		END IF;
		
		v_delta_total = NEW.total - v_delta_total;
		IF NOT NEW.deb THEN
			v_delta_total = -1 * v_delta_total;
		END IF;

		PERFORM rg_cash_flow_update_periods(NEW.date_time, NEW.cash_flow_location_id, v_delta_total);

		RETURN NEW;					
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='DELETE') THEN
		RETURN OLD;
	ELSIF (TG_WHEN='AFTER' AND TG_OP='DELETE') THEN
		CALC_DATE_TIME = rg_calc_period('cash_flow'::reg_types);
		IF (CALC_DATE_TIME IS NULL) OR (OLD.date_time::date > rg_period_balance('cash_flow'::reg_types, CALC_DATE_TIME)) THEN
			CALC_DATE_TIME = rg_period('cash_flow'::reg_types,OLD.date_time);
			PERFORM rg_cash_flow_set_custom_period(CALC_DATE_TIME);						
		END IF;
		v_delta_total = OLD.total;
		IF OLD.deb THEN
			v_delta_total = -1*v_delta_total;					
		END IF;

		PERFORM rg_cash_flow_update_periods(OLD.date_time, OLD.cash_flow_location_id,v_delta_total);
		
		RETURN OLD;					
	END IF;
END;

$BODY$;

ALTER FUNCTION public.ra_cash_flow_process()
    OWNER TO glab;



-- ******************* update 22/04/2024 14:57:43 ******************
-- FUNCTION: public.ra_cash_flow_process()

-- DROP FUNCTION IF EXISTS public.ra_cash_flow_process();

CREATE OR REPLACE FUNCTION public.ra_cash_flow_process()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
DECLARE
	v_delta_total  numeric(15,2) DEFAULT 0;
	CALC_DATE_TIME timestamp without time zone;
	CURRENT_BALANCE_DATE_TIME timestamp without time zone;
	v_loop_rg_period timestamp;
	v_calc_interval interval;			  			
BEGIN
	IF (TG_WHEN='BEFORE' AND TG_OP='INSERT') THEN
		RETURN NEW;
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='UPDATE') THEN
		RETURN NEW;
	ELSIF (TG_WHEN='AFTER' AND (TG_OP='UPDATE' OR TG_OP='INSERT')) THEN
		CALC_DATE_TIME = rg_calc_period('cash_flow'::reg_types);
		IF (CALC_DATE_TIME IS NULL) OR (NEW.date_time::date > rg_period_balance('cash_flow'::reg_types, CALC_DATE_TIME)) THEN
			CALC_DATE_TIME = rg_period('cash_flow'::reg_types,NEW.date_time);
			PERFORM rg_cash_flow_set_custom_period(CALC_DATE_TIME);						
		END IF;
		
		IF TG_OP='UPDATE' AND
		(NEW.date_time<>OLD.date_time
		) THEN
			--delete old data completely
			PERFORM rg_cash_flow_update_periods(OLD.date_time, OLD.cash_flow_location_id,-1*OLD.total);
			v_delta_total = 0;
		ELSIF TG_OP='UPDATE' THEN						
			v_delta_total = OLD.total;
		ELSE
			v_delta_total = 0;
		END IF;
		
		v_delta_total = NEW.total - v_delta_total;
		IF NOT NEW.deb THEN
			v_delta_total = -1 * v_delta_total;
		END IF;

		PERFORM rg_cash_flow_update_periods(NEW.date_time, NEW.cash_flow_location_id, v_delta_total);

		RETURN NEW;					
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='DELETE') THEN
		RETURN OLD;
	ELSIF (TG_WHEN='AFTER' AND TG_OP='DELETE') THEN
		CALC_DATE_TIME = rg_calc_period('cash_flow'::reg_types);
		IF (CALC_DATE_TIME IS NULL) OR (OLD.date_time::date > rg_period_balance('cash_flow'::reg_types, CALC_DATE_TIME)) THEN
			CALC_DATE_TIME = rg_period('cash_flow'::reg_types,OLD.date_time);
			PERFORM rg_cash_flow_set_custom_period(CALC_DATE_TIME);						
		END IF;
		v_delta_total = OLD.total;
		IF OLD.deb THEN
			v_delta_total = -1*v_delta_total;					
		END IF;

		PERFORM rg_cash_flow_update_periods(OLD.date_time, OLD.cash_flow_location_id,v_delta_total);
		
		RETURN OLD;					
	END IF;
END;

$BODY$;

ALTER FUNCTION public.ra_cash_flow_process()
    OWNER TO glab;



-- ******************* update 22/04/2024 14:58:09 ******************
-- FUNCTION: public.ra_cash_flow_process()

-- DROP FUNCTION IF EXISTS public.ra_cash_flow_process();

CREATE OR REPLACE FUNCTION public.ra_cash_flow_process()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
DECLARE
	v_delta_total  numeric(15,2) DEFAULT 0;
	CALC_DATE_TIME timestamp without time zone;
	CURRENT_BALANCE_DATE_TIME timestamp without time zone;
	v_loop_rg_period timestamp;
	v_calc_interval interval;			  			
BEGIN
	IF (TG_WHEN='BEFORE' AND TG_OP='INSERT') THEN
		RETURN NEW;
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='UPDATE') THEN
		RETURN NEW;
	ELSIF (TG_WHEN='AFTER' AND (TG_OP='UPDATE' OR TG_OP='INSERT')) THEN
		CALC_DATE_TIME = rg_calc_period('cash_flow'::reg_types);
		IF (CALC_DATE_TIME IS NULL) OR (NEW.date_time::date > rg_period_balance('cash_flow'::reg_types, CALC_DATE_TIME)) THEN
			CALC_DATE_TIME = rg_period('cash_flow'::reg_types,NEW.date_time);
			PERFORM rg_cash_flow_set_custom_period(CALC_DATE_TIME);						
		END IF;
		
		IF TG_OP='UPDATE' AND
		(NEW.date_time<>OLD.date_time
		) THEN
			--delete old data completely
			PERFORM rg_cash_flow_update_periods(OLD.date_time, OLD.location_id,-1*OLD.total);
			v_delta_total = 0;
		ELSIF TG_OP='UPDATE' THEN						
			v_delta_total = OLD.total;
		ELSE
			v_delta_total = 0;
		END IF;
		
		v_delta_total = NEW.total - v_delta_total;
		IF NOT NEW.deb THEN
			v_delta_total = -1 * v_delta_total;
		END IF;

		PERFORM rg_cash_flow_update_periods(NEW.date_time, NEW.location_id, v_delta_total);

		RETURN NEW;					
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='DELETE') THEN
		RETURN OLD;
	ELSIF (TG_WHEN='AFTER' AND TG_OP='DELETE') THEN
		CALC_DATE_TIME = rg_calc_period('cash_flow'::reg_types);
		IF (CALC_DATE_TIME IS NULL) OR (OLD.date_time::date > rg_period_balance('cash_flow'::reg_types, CALC_DATE_TIME)) THEN
			CALC_DATE_TIME = rg_period('cash_flow'::reg_types,OLD.date_time);
			PERFORM rg_cash_flow_set_custom_period(CALC_DATE_TIME);						
		END IF;
		v_delta_total = OLD.total;
		IF OLD.deb THEN
			v_delta_total = -1*v_delta_total;					
		END IF;

		PERFORM rg_cash_flow_update_periods(OLD.date_time, OLD.location_id,v_delta_total);
		
		RETURN OLD;					
	END IF;
END;

$BODY$;

ALTER FUNCTION public.ra_cash_flow_process()
    OWNER TO glab;



-- ******************* update 22/04/2024 14:58:33 ******************
-- FUNCTION: public.ra_cash_flow_process()

-- DROP FUNCTION IF EXISTS public.ra_cash_flow_process();

CREATE OR REPLACE FUNCTION public.ra_cash_flow_process()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
DECLARE
	v_delta_total  numeric(15,2) DEFAULT 0;
	CALC_DATE_TIME timestamp without time zone;
	CURRENT_BALANCE_DATE_TIME timestamp without time zone;
	v_loop_rg_period timestamp;
	v_calc_interval interval;			  			
BEGIN
	IF (TG_WHEN='BEFORE' AND TG_OP='INSERT') THEN
		RETURN NEW;
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='UPDATE') THEN
		RETURN NEW;
	ELSIF (TG_WHEN='AFTER' AND (TG_OP='UPDATE' OR TG_OP='INSERT')) THEN
		CALC_DATE_TIME = rg_calc_period('cash_flow'::reg_types);
		IF (CALC_DATE_TIME IS NULL) OR (NEW.date_time::date > rg_period_balance('cash_flow'::reg_types, CALC_DATE_TIME)) THEN
			CALC_DATE_TIME = rg_period('cash_flow'::reg_types,NEW.date_time);
			PERFORM rg_cash_flow_set_custom_period(CALC_DATE_TIME);						
		END IF;
		
		IF TG_OP='UPDATE' AND
		(NEW.date_time<>OLD.date_time
		) THEN
			--delete old data completely
			PERFORM rg_cash_flow_update_periods(OLD.date_time, OLD.cash_location_id,-1*OLD.total);
			v_delta_total = 0;
		ELSIF TG_OP='UPDATE' THEN						
			v_delta_total = OLD.total;
		ELSE
			v_delta_total = 0;
		END IF;
		
		v_delta_total = NEW.total - v_delta_total;
		IF NOT NEW.deb THEN
			v_delta_total = -1 * v_delta_total;
		END IF;

		PERFORM rg_cash_flow_update_periods(NEW.date_time, NEW.cash_location_id, v_delta_total);

		RETURN NEW;					
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='DELETE') THEN
		RETURN OLD;
	ELSIF (TG_WHEN='AFTER' AND TG_OP='DELETE') THEN
		CALC_DATE_TIME = rg_calc_period('cash_flow'::reg_types);
		IF (CALC_DATE_TIME IS NULL) OR (OLD.date_time::date > rg_period_balance('cash_flow'::reg_types, CALC_DATE_TIME)) THEN
			CALC_DATE_TIME = rg_period('cash_flow'::reg_types,OLD.date_time);
			PERFORM rg_cash_flow_set_custom_period(CALC_DATE_TIME);						
		END IF;
		v_delta_total = OLD.total;
		IF OLD.deb THEN
			v_delta_total = -1*v_delta_total;					
		END IF;

		PERFORM rg_cash_flow_update_periods(OLD.date_time, OLD.cash_location_id,v_delta_total);
		
		RETURN OLD;					
	END IF;
END;

$BODY$;

ALTER FUNCTION public.ra_cash_flow_process()
    OWNER TO glab;



-- ******************* update 22/04/2024 15:01:11 ******************
-- FUNCTION: public.rg_cash_flow_update_periods(timestamp without time zone, numeric)

-- DROP FUNCTION IF EXISTS public.rg_cash_flow_update_periods(timestamp without time zone, numeric);

CREATE OR REPLACE FUNCTION public.rg_cash_flow_update_periods(
	in_date_time timestamp without time zone,
	in_delta_total numeric)
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
	v_loop_rg_period timestamp;
	v_calc_interval interval;			  			
	CURRENT_BALANCE_DATE_TIME timestamp;
	CALC_DATE_TIME timestamp;
BEGIN
	CALC_DATE_TIME = rg_calc_period('cash_flow'::reg_types);
	v_loop_rg_period = rg_period('cash_flow'::reg_types,in_date_time);
	v_calc_interval = rg_calc_interval('cash_flow'::reg_types);
	LOOP
		UPDATE rg_cash_flow
		SET
			total = total + in_delta_total
		WHERE 
			date_time=v_loop_rg_period;
			
		IF NOT FOUND THEN
			BEGIN
				INSERT INTO rg_cash_flow (date_time
				,total)				
				VALUES (v_loop_rg_period
				,in_delta_total);
			EXCEPTION WHEN OTHERS THEN
				UPDATE rg_cash_flow
				SET
					total = total + in_delta_total
				WHERE date_time = v_loop_rg_period;
			END;
		END IF;
		v_loop_rg_period = v_loop_rg_period + v_calc_interval;
		IF v_loop_rg_period > CALC_DATE_TIME THEN
			EXIT;  -- exit loop
		END IF;
	END LOOP;
	
	--Current balance
	CURRENT_BALANCE_DATE_TIME = reg_current_balance_time();
	UPDATE rg_cash_flow
	SET
		total = total + in_delta_total
	WHERE 
		date_time=CURRENT_BALANCE_DATE_TIME;
		
	IF NOT FOUND THEN
		BEGIN
			INSERT INTO rg_cash_flow (date_time
			,total)				
			VALUES (CURRENT_BALANCE_DATE_TIME
			,in_delta_total);
		EXCEPTION WHEN OTHERS THEN
			UPDATE rg_cash_flow
			SET
				total = total + in_delta_total
			WHERE 
				date_time=CURRENT_BALANCE_DATE_TIME;
		END;
	END IF;					
	
END;
$BODY$;

ALTER FUNCTION public.rg_cash_flow_update_periods(timestamp without time zone, numeric)
    OWNER TO glab;



-- ******************* update 22/04/2024 15:01:29 ******************
-- FUNCTION: public.rg_cash_flow_update_periods(timestamp without time zone, numeric)

 DROP FUNCTION IF EXISTS public.rg_cash_flow_update_periods(timestamp without time zone, numeric);
/*
CREATE OR REPLACE FUNCTION public.rg_cash_flow_update_periods(
	in_date_time timestamp without time zone,
	in_delta_total numeric)
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
	v_loop_rg_period timestamp;
	v_calc_interval interval;			  			
	CURRENT_BALANCE_DATE_TIME timestamp;
	CALC_DATE_TIME timestamp;
BEGIN
	CALC_DATE_TIME = rg_calc_period('cash_flow'::reg_types);
	v_loop_rg_period = rg_period('cash_flow'::reg_types,in_date_time);
	v_calc_interval = rg_calc_interval('cash_flow'::reg_types);
	LOOP
		UPDATE rg_cash_flow
		SET
			total = total + in_delta_total
		WHERE 
			date_time=v_loop_rg_period;
			
		IF NOT FOUND THEN
			BEGIN
				INSERT INTO rg_cash_flow (date_time
				,total)				
				VALUES (v_loop_rg_period
				,in_delta_total);
			EXCEPTION WHEN OTHERS THEN
				UPDATE rg_cash_flow
				SET
					total = total + in_delta_total
				WHERE date_time = v_loop_rg_period;
			END;
		END IF;
		v_loop_rg_period = v_loop_rg_period + v_calc_interval;
		IF v_loop_rg_period > CALC_DATE_TIME THEN
			EXIT;  -- exit loop
		END IF;
	END LOOP;
	
	--Current balance
	CURRENT_BALANCE_DATE_TIME = reg_current_balance_time();
	UPDATE rg_cash_flow
	SET
		total = total + in_delta_total
	WHERE 
		date_time=CURRENT_BALANCE_DATE_TIME;
		
	IF NOT FOUND THEN
		BEGIN
			INSERT INTO rg_cash_flow (date_time
			,total)				
			VALUES (CURRENT_BALANCE_DATE_TIME
			,in_delta_total);
		EXCEPTION WHEN OTHERS THEN
			UPDATE rg_cash_flow
			SET
				total = total + in_delta_total
			WHERE 
				date_time=CURRENT_BALANCE_DATE_TIME;
		END;
	END IF;					
	
END;
$BODY$;

ALTER FUNCTION public.rg_cash_flow_update_periods(timestamp without time zone, numeric)
    OWNER TO glab;
*/


-- ******************* update 22/04/2024 15:04:31 ******************
-- FUNCTION: public.rg_cash_flow_update_periods(timestamp without time zone, integer, numeric)

-- DROP FUNCTION IF EXISTS public.rg_cash_flow_update_periods(timestamp without time zone, integer, numeric);

CREATE OR REPLACE FUNCTION public.rg_cash_flow_update_periods(
	in_date_time timestamp without time zone,
	in_cash_location_id integer,
	in_delta_total numeric)
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
	v_loop_rg_period timestamp;
	v_calc_interval interval;			  			
	CURRENT_BALANCE_DATE_TIME timestamp;
	CALC_DATE_TIME timestamp;
BEGIN
	CALC_DATE_TIME = rg_calc_period('cash_flow'::reg_types);
	v_loop_rg_period = rg_period('cash_flow'::reg_types,in_date_time);
	v_calc_interval = rg_calc_interval('cash_flow'::reg_types);
	LOOP
		UPDATE rg_cash_flow
		SET
			quant = quant + in_delta_total
		WHERE 
			date_time=v_loop_rg_period
			AND material_id = in_cash_location_id;
			
		IF NOT FOUND THEN
			BEGIN
				INSERT INTO rg_cash_flow (date_time
				,material_id
				,quant)				
				VALUES (v_loop_rg_period
				,in_cash_location_id
				,in_delta_total);
			EXCEPTION WHEN OTHERS THEN
				UPDATE rg_cash_flow
				SET
					quant = quant + in_delta_total
				WHERE date_time = v_loop_rg_period
				AND material_id = in_cash_location_id;
			END;
		END IF;
		v_loop_rg_period = v_loop_rg_period + v_calc_interval;
		IF v_loop_rg_period > CALC_DATE_TIME THEN
			EXIT;  -- exit loop
		END IF;
	END LOOP;
	
	--Current balance
	CURRENT_BALANCE_DATE_TIME = reg_current_balance_time();
	UPDATE rg_cash_flow
	SET
		quant = quant + in_delta_total
	WHERE 
		date_time=CURRENT_BALANCE_DATE_TIME
		AND material_id = in_cash_location_id;
		
	IF NOT FOUND THEN
		BEGIN
			INSERT INTO rg_cash_flow (date_time
			,material_id
			,quant)				
			VALUES (CURRENT_BALANCE_DATE_TIME
			,in_cash_location_id
			,in_delta_total);
		EXCEPTION WHEN OTHERS THEN
			UPDATE rg_cash_flow
			SET
				quant = quant + in_delta_total
			WHERE 
				date_time=CURRENT_BALANCE_DATE_TIME
				AND material_id = in_cash_location_id;
		END;
	END IF;					
	
END;
$BODY$;

ALTER FUNCTION public.rg_cash_flow_update_periods(timestamp without time zone, integer, numeric)
    OWNER TO glab;



-- ******************* update 22/04/2024 15:04:44 ******************
-- FUNCTION: public.rg_cash_flow_update_periods(timestamp without time zone, integer, numeric)

-- DROP FUNCTION IF EXISTS public.rg_cash_flow_update_periods(timestamp without time zone, integer, numeric);

CREATE OR REPLACE FUNCTION public.rg_cash_flow_update_periods(
	in_date_time timestamp without time zone,
	in_cash_location_id integer,
	in_delta_total numeric)
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
	v_loop_rg_period timestamp;
	v_calc_interval interval;			  			
	CURRENT_BALANCE_DATE_TIME timestamp;
	CALC_DATE_TIME timestamp;
BEGIN
	CALC_DATE_TIME = rg_calc_period('cash_flow'::reg_types);
	v_loop_rg_period = rg_period('cash_flow'::reg_types,in_date_time);
	v_calc_interval = rg_calc_interval('cash_flow'::reg_types);
	LOOP
		UPDATE rg_cash_flow
		SET
			total = total + in_delta_total
		WHERE 
			date_time=v_loop_rg_period
			AND material_id = in_cash_location_id;
			
		IF NOT FOUND THEN
			BEGIN
				INSERT INTO rg_cash_flow (date_time
				,material_id
				,total)				
				VALUES (v_loop_rg_period
				,in_cash_location_id
				,in_delta_total);
			EXCEPTION WHEN OTHERS THEN
				UPDATE rg_cash_flow
				SET
					total = total + in_delta_total
				WHERE date_time = v_loop_rg_period
				AND material_id = in_cash_location_id;
			END;
		END IF;
		v_loop_rg_period = v_loop_rg_period + v_calc_interval;
		IF v_loop_rg_period > CALC_DATE_TIME THEN
			EXIT;  -- exit loop
		END IF;
	END LOOP;
	
	--Current balance
	CURRENT_BALANCE_DATE_TIME = reg_current_balance_time();
	UPDATE rg_cash_flow
	SET
		total = total + in_delta_total
	WHERE 
		date_time=CURRENT_BALANCE_DATE_TIME
		AND material_id = in_cash_location_id;
		
	IF NOT FOUND THEN
		BEGIN
			INSERT INTO rg_cash_flow (date_time
			,material_id
			,total)				
			VALUES (CURRENT_BALANCE_DATE_TIME
			,in_cash_location_id
			,in_delta_total);
		EXCEPTION WHEN OTHERS THEN
			UPDATE rg_cash_flow
			SET
				total = total + in_delta_total
			WHERE 
				date_time=CURRENT_BALANCE_DATE_TIME
				AND material_id = in_cash_location_id;
		END;
	END IF;					
	
END;
$BODY$;

ALTER FUNCTION public.rg_cash_flow_update_periods(timestamp without time zone, integer, numeric)
    OWNER TO glab;



-- ******************* update 22/04/2024 15:05:23 ******************
-- FUNCTION: public.rg_cash_flow_update_periods(timestamp without time zone, integer, numeric)

-- DROP FUNCTION IF EXISTS public.rg_cash_flow_update_periods(timestamp without time zone, integer, numeric);

CREATE OR REPLACE FUNCTION public.rg_cash_flow_update_periods(
	in_date_time timestamp without time zone,
	in_cash_location_id integer,
	in_delta_total numeric)
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
	v_loop_rg_period timestamp;
	v_calc_interval interval;			  			
	CURRENT_BALANCE_DATE_TIME timestamp;
	CALC_DATE_TIME timestamp;
BEGIN
	CALC_DATE_TIME = rg_calc_period('cash_flow'::reg_types);
	v_loop_rg_period = rg_period('cash_flow'::reg_types,in_date_time);
	v_calc_interval = rg_calc_interval('cash_flow'::reg_types);
	LOOP
		UPDATE rg_cash_flow
		SET
			total = total + in_delta_total
		WHERE 
			date_time=v_loop_rg_period
			AND cash_location_id = in_cash_location_id;
			
		IF NOT FOUND THEN
			BEGIN
				INSERT INTO rg_cash_flow (date_time
				,cash_location_id
				,total)				
				VALUES (v_loop_rg_period
				,in_cash_location_id
				,in_delta_total);
			EXCEPTION WHEN OTHERS THEN
				UPDATE rg_cash_flow
				SET
					total = total + in_delta_total
				WHERE date_time = v_loop_rg_period
				AND cash_location_id = in_cash_location_id;
			END;
		END IF;
		v_loop_rg_period = v_loop_rg_period + v_calc_interval;
		IF v_loop_rg_period > CALC_DATE_TIME THEN
			EXIT;  -- exit loop
		END IF;
	END LOOP;
	
	--Current balance
	CURRENT_BALANCE_DATE_TIME = reg_current_balance_time();
	UPDATE rg_cash_flow
	SET
		total = total + in_delta_total
	WHERE 
		date_time=CURRENT_BALANCE_DATE_TIME
		AND cash_location_id = in_cash_location_id;
		
	IF NOT FOUND THEN
		BEGIN
			INSERT INTO rg_cash_flow (date_time
			,cash_location_id
			,total)				
			VALUES (CURRENT_BALANCE_DATE_TIME
			,in_cash_location_id
			,in_delta_total);
		EXCEPTION WHEN OTHERS THEN
			UPDATE rg_cash_flow
			SET
				total = total + in_delta_total
			WHERE 
				date_time=CURRENT_BALANCE_DATE_TIME
				AND cash_location_id = in_cash_location_id;
		END;
	END IF;					
	
END;
$BODY$;

ALTER FUNCTION public.rg_cash_flow_update_periods(timestamp without time zone, integer, numeric)
    OWNER TO glab;



-- ******************* update 22/04/2024 15:08:35 ******************
-- ADD
CREATE OR REPLACE FUNCTION ra_cash_flow_add_act(reg_act ra_cash_flow)
RETURNS void AS
$BODY$
	INSERT INTO ra_cash_flow
	(date_time,doc_type,doc_id
	,deb
	,cash_location_id
	,total				
	)
	VALUES (
	$1.date_time,$1.doc_type,$1.doc_id
	,$1.deb
	,$1.cash_location_id				
	,$1.total
	);
$BODY$
LANGUAGE sql VOLATILE STRICT COST 100;

ALTER FUNCTION ra_cash_flow_add_act(reg_act ra_cash_flow) OWNER TO glab;



-- ******************* update 22/04/2024 15:08:40 ******************
-- Function: public.cash_flow_in_process()

-- DROP FUNCTION public.cash_flow_in_process();

CREATE OR REPLACE FUNCTION public.cash_flow_in_process()
  RETURNS trigger AS
$BODY$
DECLARE
	reg_act ra_cash_flow%ROWTYPE;
BEGIN
	IF (TG_WHEN='BEFORE' AND TG_OP='INSERT') THEN
		--IF NEW.date_time < '2024-01-01T00:00:00'::timestamp THEN
		--	RAISE EXCEPTION 'Дата запрета редактирования: %', '2024-01-01T00:00:00'::timestamp;
		--END IF;
		
		RETURN NEW;
		
	ELSIF (TG_WHEN='AFTER') AND (TG_OP='INSERT' OR TG_OP='UPDATE') THEN					
		IF (TG_OP='INSERT') THEN						
			--log
			PERFORM doc_log_insert('cash_flow_in'::doc_types,NEW.id,NEW.date_time);
		END IF;

		--register actions ra_cash_flow
		reg_act.date_time		= NEW.date_time;
		reg_act.deb			= true;
		reg_act.doc_type  		= 'cash_flow_in'::doc_types;
		reg_act.doc_id  		= NEW.id;
		reg_act.cash_location_id	= NEW.cash_location_id;
		reg_act.total			= NEW.total;
		PERFORM ra_cash_flow_add_act(reg_act);	
		
		RETURN NEW;
		
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='UPDATE') THEN
		--IF NEW.date_time < '2024-01-01T00:00:00'::timestamp THEN
		--	RAISE EXCEPTION 'Дата запрета редактирования: %', '2024-01-01T00:00:00'::timestamp;
		--END IF;
	
		PERFORM ra_cash_flow_remove_acts('cash_flow_in'::doc_types,OLD.id);

		-- Временно!
		IF NEW.date_time<>OLD.date_time THEN
			PERFORM doc_log_update('cash_flow_in'::doc_types,NEW.id,NEW.date_time);
		END IF;
						
		RETURN NEW;
		
	ELSIF (TG_WHEN='AFTER' AND TG_OP='DELETE') THEN
	
		RETURN OLD;
		
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='DELETE') THEN
		--IF OLD.date_time < '2024-01-01T00:00:00'::timestamp THEN
		--	RAISE EXCEPTION 'Дата запрета редактирования: %', '2024-01-01T00:00:00'::timestamp;
		--END IF;
	
		--detail tables
		
		--register actions										
		PERFORM ra_cash_flow_remove_acts('cash_flow_in'::doc_types,OLD.id);
		
		--log
		PERFORM doc_log_delete('cash_flow_in'::doc_types,OLD.id);
		
		RETURN OLD;
	END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.cash_flow_in_process()
  OWNER TO glab;



-- ******************* update 22/04/2024 15:17:08 ******************
-- Function: public.cash_flow_out_process()

-- DROP FUNCTION public.cash_flow_out_process();

CREATE OR REPLACE FUNCTION public.cash_flow_out_process()
  RETURNS trigger AS
$BODY$
DECLARE
	reg_act ra_cash_flow%ROWTYPE;
BEGIN
	IF (TG_WHEN='BEFORE' AND TG_OP='INSERT') THEN
		--IF NEW.date_time < '2024-01-01T00:00:00'::timestamp THEN
		--	RAISE EXCEPTION 'Дата запрета редактирования: %', '2024-01-01T00:00:00'::timestamp;
		--END IF;
		
		RETURN NEW;
		
	ELSIF (TG_WHEN='AFTER') AND (TG_OP='INSERT' OR TG_OP='UPDATE') THEN					
		IF (TG_OP='INSERT') THEN						
			--log
			PERFORM doc_log_insert('cash_flow_out'::doc_types,NEW.id,NEW.date_time);
		END IF;

		--register actions ra_cash_flow
		reg_act.date_time		= NEW.date_time;
		reg_act.deb			= false;
		reg_act.doc_type  		= 'cash_flow_out'::doc_types;
		reg_act.doc_id  		= NEW.id;
		reg_act.cash_location_id	= NEW.cash_location_id;
		reg_act.total			= NEW.total;
		PERFORM ra_cash_flow_add_act(reg_act);	
		
		RETURN NEW;
		
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='UPDATE') THEN
		--IF NEW.date_time < '2024-01-01T00:00:00'::timestamp THEN
		--	RAISE EXCEPTION 'Дата запрета редактирования: %', '2024-01-01T00:00:00'::timestamp;
		--END IF;
	
		PERFORM ra_cash_flow_remove_acts('cash_flow_out'::doc_types,OLD.id);

		-- Временно!
		IF NEW.date_time<>OLD.date_time THEN
			PERFORM doc_log_update('cash_flow_out'::doc_types,NEW.id,NEW.date_time);
		END IF;
						
		RETURN NEW;
		
	ELSIF (TG_WHEN='AFTER' AND TG_OP='DELETE') THEN
	
		RETURN OLD;
		
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='DELETE') THEN
		--IF OLD.date_time < '2024-01-01T00:00:00'::timestamp THEN
		--	RAISE EXCEPTION 'Дата запрета редактирования: %', '2024-01-01T00:00:00'::timestamp;
		--END IF;
	
		--detail tables
		
		--register actions										
		PERFORM ra_cash_flow_remove_acts('cash_flow_out'::doc_types,OLD.id);
		
		--log
		PERFORM doc_log_delete('cash_flow_out'::doc_types,OLD.id);
		
		RETURN OLD;
	END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.cash_flow_out_process()
  OWNER TO glab;



-- ******************* update 22/04/2024 15:18:09 ******************
-- Trigger: cash_flow_out_before

-- DROP TRIGGER cash_flow_out_before ON public.cash_flow_out;

CREATE TRIGGER cash_flow_out_before
    BEFORE INSERT OR DELETE OR UPDATE 
    ON public.cash_flow_out
    FOR EACH ROW
    EXECUTE PROCEDURE public.cash_flow_out_process();
    
-- Trigger: cash_flow_out_after

--DROP TRIGGER cash_flow_out_after ON public.cash_flow_out;

CREATE TRIGGER cash_flow_out_after
    AFTER INSERT OR DELETE OR UPDATE 
    ON public.cash_flow_out
    FOR EACH ROW
    EXECUTE PROCEDURE public.cash_flow_out_process();    



-- ******************* update 22/04/2024 15:19:38 ******************
-- VIEW: public.fin_expence_types_list

--DROP VIEW public.fin_expence_types_list;

CREATE OR REPLACE VIEW public.fin_expense_types_list AS
	SELECT
		t.id
		,t.parent_id
		,t.name
		,t.deleted
	FROM public.fin_expense_types AS t
	
	ORDER BY name ASC
	;
	
ALTER VIEW public.fin_expense_types_list OWNER TO glab;


-- ******************* update 22/04/2024 15:45:05 ******************

	
	-- Adding menu item
	INSERT INTO views
	(id,c,f,t,section,descr,limited)
	VALUES (
	'50000',
	NULL,
	NULL,
	'RepCashFlow',
	'Отчеты',
	'Отчет по кассе',
	FALSE
	);
	
	

-- ******************* update 24/04/2024 06:25:43 ******************

	/*
	-- ********** Adding new table from model **********
	CREATE TABLE public.cash_flow_transfers
	(id serial NOT NULL,date_time timestampTZ
			DEFAULT CURRENT_TIMESTAMP NOT NULL,from_cahs_location_id int NOT NULL REFERENCES cash_locations(id),to_cash_location_id int NOT NULL REFERENCES cash_locations(id),comment_text text,user_id int NOT NULL REFERENCES users(id),total  numeric(15,2),CONSTRAINT cash_flow_transfers_pkey PRIMARY KEY (id)
	);
	
	CREATE INDEX cash_flow_transfers_date_idx
	ON cash_flow_transfers(date_time);
*/
	CREATE INDEX cash_flow_transfers_from_location_idx
	ON cash_flow_transfers(from_cahs_location_id);

	



-- ******************* update 24/04/2024 06:26:10 ******************

	/*
	-- ********** Adding new table from model **********
	CREATE TABLE public.cash_flow_transfers
	(id serial NOT NULL,date_time timestampTZ
			DEFAULT CURRENT_TIMESTAMP NOT NULL,from_cahs_location_id int NOT NULL REFERENCES cash_locations(id),to_cash_location_id int NOT NULL REFERENCES cash_locations(id),comment_text text,user_id int NOT NULL REFERENCES users(id),total  numeric(15,2),CONSTRAINT cash_flow_transfers_pkey PRIMARY KEY (id)
	);
	
	CREATE INDEX cash_flow_transfers_date_idx
	ON cash_flow_transfers(date_time);
*/
	CREATE INDEX cash_flow_transfers_to_location_idx
	ON cash_flow_transfers(to_cash_location_id);

	



-- ******************* update 24/04/2024 06:42:41 ******************

	
	-- Adding menu item
	INSERT INTO views
	(id,c,f,t,section,descr,limited)
	VALUES (
	'30003',
	'CashFlowTransfer_Controller',
	'get_list',
	'CashFlowTransferList',
	'Документы',
	'Перемещение денег',
	FALSE
	);
	
	

-- ******************* update 24/04/2024 06:52:13 ******************
/**
 * Andrey Mikhalevich 15/12/21
 * This file is part of the OSBE framework
 *
 * THIS FILE IS GENERATED FROM TEMPLATE build/templates/permissions/permissions.sql.tmpl
 * ALL DIRECT MODIFICATIONS WILL BE LOST WITH THE NEXT BUILD PROCESS!!!
 */

/*
-- If this is the first time you execute the script, uncomment these lines
-- to create table and insert row
CREATE TABLE IF NOT EXISTS permissions (
    rules json NOT NULL
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.permissions OWNER TO glab;

INSERT INTO permissions VALUES ('{"admin":{}}');
*/

UPDATE permissions SET rules = '{
	"admin":{
		"Event":{
			"subscribe":true
			,"unsubscribe":true
			,"publish":true
		}
		,"Constant":{
			"set_value":true
			,"get_list":true
			,"get_object":true
			,"get_values":true
		}
		,"Enum":{
			"get_enum_list":true
		}
		,"MainMenuConstructor":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MainMenuContent":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"View":{
			"get_list":true
			,"complete":true
			,"get_section_list":true
		}
		,"VariantStorage":{
			"insert":true
			,"upsert_filter_data":true
			,"upsert_col_visib_data":true
			,"upsert_col_order_data":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_filter_data":true
			,"get_col_visib_data":true
			,"get_col_order_data":true
		}
		,"About":{
			"get_object":true
		}
		,"Service":{
			"reload_config":true
			,"reload_version":true
		}
		,"User":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
			,"get_profile":true
			,"reset_pwd":true
			,"login":true
			,"login_refresh":true
			,"logout":true
			,"logout_html":true
			,"download_photo":true
			,"delete_photo":true
			,"password_recover":true
		}
		,"Login":{
			"get_list":true
			,"get_object":true
			,"logout":true
		}
		,"LoginDevice":{
			"get_list":true
			,"switch_banned":true
		}
		,"Captcha":{
			"get":true
		}
		,"LoginDeviceBan":{
			"insert":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"TimeZoneLocale":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Department":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Post":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Contact":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
			,"upsert":true
		}
		,"EntityContact":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ObjectModLog":{
			"get_list":true
			,"get_object":true
		}
		,"MailMessage":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MailMessageAttachment":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MailTemplate":{
			"insert":true
			,"update":true
			,"get_list":true
			,"get_object":true
		}
		,"Attachment":{
			"get_list":true
			,"get_object":true
			,"delete_file":true
			,"get_file":true
			,"add_file":true
		}
		,"AutoMake":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"AutoModel":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_make":true
			,"get_all_years":true
		}
		,"AutoModelGeneration":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_model":true
			,"gen_next_id":true
		}
		,"AutoType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"AutoBodyType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoBodyDoor":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoBody":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_model_generation":true
			,"complete_for_model":true
		}
		,"ItemFolder":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemFeature":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemFeatureValueList":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItemFeatureValueList":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFeatureGroupItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFolderFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItemFolderFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Item":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_item":true
			,"complete":true
			,"set_feature":true
			,"get_features_filter_list":true
		}
		,"Manufacturer":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ManufacturerBrand":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Supplier":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"VehicleType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemPriority":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"PopularityType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"import":true
			,"set_feature":true
			,"get_features_filter_list":true
		}
		,"ItemSearch":{
			"get_object":true
			,"find_items":true
		}
		,"ImportItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierStore":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_supplier":true
		}
		,"SupplierStoreValue":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoPriceCategory":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoToGlassMatchHead":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoToGlassMatchEurocode":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_body_list":true
		}
		,"AutoToGlassMatchOption":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_conf_form":true
		}
		,"AutoModelGenerationBody":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"BankCard":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Employee":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"EmployeeStatus":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"PersonDocument":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"PersonDocumentType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"CashLocation":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"FinExpenseType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"CashFlowIn":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_cash_flow_in_out_list":true
		}
		,"CashFlowOut":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"CashFlowTransfer":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
	}
	,"guest":{
		"User":{
			"login":true
		}
	}
}';


-- ******************* update 24/04/2024 06:59:43 ******************
alter table cash_flow_transfers drop column from_cahs_location_id;



-- ******************* update 24/04/2024 07:00:25 ******************
alter table cash_flow_transfers add column from_cash_location_id int references cash_locations(id);



-- ******************* update 24/04/2024 07:00:44 ******************
-- VIEW: public.cash_flow_transfer_list

--DROP VIEW public.cash_flow_transfer_list;

CREATE OR REPLACE VIEW public.cash_flow_transfer_list AS
	SELECT
		t.id
		,t.date_time
		,t.from_cash_location_id
		,cash_locations_ref(from_loc) as from_cash_locations_ref
		,t.to_cash_location_id
		,cash_locations_ref(to_loc) as to_cash_locations_ref
		,t.comment_text
		,users_ref(users_ref_t) AS users_ref
		,t.total
	FROM public.cash_flow_transfers AS t
	LEFT JOIN users AS users_ref_t ON users_ref_t.id = t.user_id
	LEFT JOIN cash_locations AS from_loc ON from_loc.id = t.from_cash_location_id
	LEFT JOIN cash_locations AS to_loc ON to_loc.id = t.to_cash_location_id
	ORDER BY date_time DESC
	;
	
ALTER VIEW public.cash_flow_transfer_list OWNER TO glab;


-- ******************* update 24/04/2024 07:06:33 ******************

					ALTER TYPE doc_types ADD VALUE 'cash_flow_transfers';
					
	/* type get function */
	CREATE OR REPLACE FUNCTION enum_doc_types_val(doc_types,locales)
	RETURNS text AS $$
		SELECT
		CASE
		WHEN $1='cash_flow_in'::doc_types AND $2='ru'::locales THEN 'ПКО'
		WHEN $1='cash_flow_out'::doc_types AND $2='ru'::locales THEN 'РКО'
		WHEN $1='cash_flow_transfers'::doc_types AND $2='ru'::locales THEN 'Перемещение денег'
		ELSE ''
		END;		
	$$ LANGUAGE sql;	
	ALTER FUNCTION enum_doc_types_val(doc_types,locales) OWNER TO glab;		
	

-- ******************* update 24/04/2024 07:07:42 ******************
-- Function: public.cash_flow_transfers_process()

-- DROP FUNCTION public.cash_flow_transfers_process();

CREATE OR REPLACE FUNCTION public.cash_flow_transfers_process()
  RETURNS trigger AS
$BODY$
DECLARE
	reg_act ra_cash_flow%ROWTYPE;
BEGIN
	IF (TG_WHEN='BEFORE' AND TG_OP='INSERT') THEN
		--IF NEW.date_time < '2024-01-01T00:00:00'::timestamp THEN
		--	RAISE EXCEPTION 'Дата запрета редактирования: %', '2024-01-01T00:00:00'::timestamp;
		--END IF;
		
		RETURN NEW;
		
	ELSIF (TG_WHEN='AFTER') AND (TG_OP='INSERT' OR TG_OP='UPDATE') THEN					
		IF (TG_OP='INSERT') THEN						
			--log
			PERFORM doc_log_insert('cash_flow_transfers'::doc_types,NEW.id,NEW.date_time);
		END IF;

		--register actions ra_cash_flow out
		reg_act.date_time		= NEW.date_time;
		reg_act.deb			= false;
		reg_act.doc_type  		= 'cash_flow_transfers'::doc_types;
		reg_act.doc_id  		= NEW.id;
		reg_act.cash_location_id	= NEW.from_cash_location_id;
		reg_act.total			= NEW.total;
		PERFORM ra_cash_flow_add_act(reg_act);	

		--register actions ra_cash_flow in
		reg_act.date_time		= NEW.date_time;
		reg_act.deb			= true;
		reg_act.doc_type  		= 'cash_flow_transfers'::doc_types;
		reg_act.doc_id  		= NEW.id;
		reg_act.cash_location_id	= NEW.to_cash_location_id;
		reg_act.total			= NEW.total;
		PERFORM ra_cash_flow_add_act(reg_act);	
		
		RETURN NEW;
		
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='UPDATE') THEN
		--IF NEW.date_time < '2024-01-01T00:00:00'::timestamp THEN
		--	RAISE EXCEPTION 'Дата запрета редактирования: %', '2024-01-01T00:00:00'::timestamp;
		--END IF;
	
		PERFORM ra_cash_flow_remove_acts('cash_flow_transfers'::doc_types,OLD.id);

		-- Временно!
		IF NEW.date_time<>OLD.date_time THEN
			PERFORM doc_log_update('cash_flow_transfers'::doc_types,NEW.id,NEW.date_time);
		END IF;
						
		RETURN NEW;
		
	ELSIF (TG_WHEN='AFTER' AND TG_OP='DELETE') THEN
	
		RETURN OLD;
		
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='DELETE') THEN
		--IF OLD.date_time < '2024-01-01T00:00:00'::timestamp THEN
		--	RAISE EXCEPTION 'Дата запрета редактирования: %', '2024-01-01T00:00:00'::timestamp;
		--END IF;
	
		--detail tables
		
		--register actions										
		PERFORM ra_cash_flow_remove_acts('cash_flow_transfers'::doc_types,OLD.id);
		
		--log
		PERFORM doc_log_delete('cash_flow_transfers'::doc_types,OLD.id);
		
		RETURN OLD;
	END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.cash_flow_transfers_process()
  OWNER TO glab;



-- ******************* update 24/04/2024 07:08:45 ******************
-- Trigger: cash_flow_transfers_before

-- DROP TRIGGER cash_flow_transfers_before ON public.cash_flow_transfers;

CREATE TRIGGER cash_flow_transfers_before
    BEFORE INSERT OR DELETE OR UPDATE 
    ON public.cash_flow_transfers
    FOR EACH ROW
    EXECUTE PROCEDURE public.cash_flow_transfers_process();
    
-- Trigger: cash_flow_transfers_after

--DROP TRIGGER cash_flow_transfers_after ON public.cash_flow_transfers;

CREATE TRIGGER cash_flow_transfers_after
    AFTER INSERT OR DELETE OR UPDATE 
    ON public.cash_flow_transfers
    FOR EACH ROW
    EXECUTE PROCEDURE public.cash_flow_transfers_process();    



-- ******************* update 24/04/2024 07:14:03 ******************
-- FUNCTION: public.fin_expense_types_ref(fin_expense_types)

-- DROP FUNCTION IF EXISTS public.fin_expense_types_ref(fin_expense_types);

CREATE OR REPLACE FUNCTION public.fin_expense_types_ref(
	fin_expense_types)
    RETURNS json
    LANGUAGE 'sql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
	SELECT json_build_object(
		'keys',json_build_object(
			  'id', $1.id  
			),	
		'descr',$1.name,
		'dataType','fin_expense_types'
	);
$BODY$;

ALTER FUNCTION public.fin_expense_types_ref(fin_expense_types)
    OWNER TO glab;



-- ******************* update 24/04/2024 10:03:03 ******************

-- Function: public.cash_flow_in_out_list(in_date date)

-- DROP FUNCTION public.cash_flow_in_out_list(in_date date);

CREATE OR REPLACE FUNCTION public.cash_flow_in_out_list(in_date date)
  RETURNS TABLE(
  	d date,
	cash_location_id int,
	cash_location_descr text,
	total_bal_start numeric(15, 2),
	total_kred numeric(15, 2),
	total_kred_out numeric(15, 2),
	fin_expense_types json,
	total_transfer_out numeric(15, 2),

	total_deb numeric(15, 2),
	total_deb_in numeric(15, 2),
	total_transfer_in numeric(15, 2),
	total_bal_end numeric(15, 2)  
  ) AS
$BODY$
	WITH
	per as (select ((in_date::date-'1 day'::interval) + '23:59:59.999999'::time)::timestamp as d1,
		(in_date::date + '23:59:59'::time)::timestamp as d2)
	
	SELECT
			dates.d::date as d,
			loc.id as cash_location_id,
			loc.name as cash_location_descr,
			coalesce(rg_beg.total, 0) as total_bal_start,
			coalesce(ra_kred.total, 0) as total_kred,
			coalesce(ra_kred.total_out, 0) as total_kred_out,
			ra_kred.fin_expense_types,
			coalesce(ra_kred.total_transfer, 0) as total_transfer_out,

			coalesce(ra_deb.total, 0) as total_deb,
			coalesce(ra_deb.total_in, 0) as total_deb_in,
			coalesce(ra_deb.total_transfer, 0) as total_transfer_in,

			coalesce(rg_beg.total, 0) as total_bal_end
			--coalesce(rg_beg.total, 0) + sum(coalesce(ra_deb.total,0) - coalesce(ra_kred.total,0)) OVER (ORDER BY dates.d,loc.name) total_bal_end
		
	FROM
		generate_series((SELECT d1 FROM per), (SELECT d2 FROM per), '24 hours') as dates (d)
	CROSS JOIN (
			SELECT
				id, name
			FROM cash_locations
			ORDER BY name
	) as loc
	LEFT JOIN (
		SELECT
			rg.cash_location_id,
			rg.total
		FROM
			rg_cash_flow_balance((select d1 from per), '{}') as rg
	) AS rg_beg on rg_beg.cash_location_id = loc.id
	LEFT JOIN (
		SELECT
			rg.cash_location_id,
			rg.total
		FROM
			rg_cash_flow_balance((select d2 from per), '{}') as rg
	) AS rg_end on rg_end.cash_location_id = loc.id
		
	LEFT JOIN (
		SELECT
			ra.date_time::date AS d,
			ra.cash_location_id,
			json_agg(
				json_build_object(
					'expense_type', fe.name,
					'total', c_out.total
				)
			) AS fin_expense_types,

			sum(c_out.total) as total_out,
			sum(c_tr.total) as total_transfer,
			sum(ra.total) as total
		FROM
			ra_cash_flow as ra	
		LEFT JOIN cash_flow_out as c_out on ra.doc_type = 'cash_flow_out' and c_out.id = ra.doc_id
		LEFT JOIN cash_flow_transfers as c_tr on ra.doc_type = 'cash_flow_transfers' and c_tr.id = ra.doc_id
		LEFT JOIN fin_expense_types as fe on fe.id = c_out.fin_expense_type1_id
		WHERE
			ra.deb = FALSE
		 	and ra.date_time BETWEEN (SELECT d1 FROM per) AND (SELECT d2 FROM per)
		GROUP BY
			ra.cash_location_id,
			ra.date_time::date,
			fe.name
		ORDER BY ra.date_time::date, fe.name
	) AS ra_kred on ra_kred.cash_location_id = loc.id AND ra_kred.d = dates.d::date
	LEFT JOIN (
		SELECT
			ra.date_time::date AS d,
			ra.cash_location_id,
			sum(c_in.total) as total_in,
			sum(c_tr.total) as total_transfer,
			sum(ra.total) as total
		FROM
			ra_cash_flow as ra	
		LEFT JOIN cash_flow_in as c_in on ra.doc_type = 'cash_flow_in' and c_in.id = ra.doc_id
		LEFT JOIN cash_flow_transfers as c_tr on ra.doc_type = 'cash_flow_transfers' and c_tr.id = ra.doc_id
		WHERE
			ra.deb = TRUE
			and ra.date_time BETWEEN (SELECT d1 FROM per) AND (SELECT d2 FROM per)
		GROUP BY
			ra.cash_location_id,
			ra.date_time::date
			
	) AS ra_deb on ra_deb.cash_location_id = loc.id AND ra_deb.d = dates.d::date
	;

$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION public.cash_flow_in_out_list(in_date date)
  OWNER TO glab;



-- ******************* update 25/04/2024 10:38:12 ******************

	
	-- ********** Adding new table from model **********
	CREATE TABLE public.firms
	(id serial NOT NULL,name text,inn  varchar(12),CONSTRAINT firms_pkey PRIMARY KEY (id)
	);
	
	DROP INDEX IF EXISTS firms_inn_idx;
	CREATE UNIQUE INDEX firms_inn_idx
	ON firms(inn);

	ALTER TABLE public.firms OWNER TO glab;
	
	

-- ******************* update 25/04/2024 11:03:40 ******************
	
	
	-- Adding menu item
	INSERT INTO views
	(id,c,f,t,section,descr,limited)
	VALUES (
	'10029',
	'Firm_Controller',
	'get_list',
	'FirmList',
	'Справочники',
	'Организации',
	FALSE
	);
	
	


-- ******************* update 25/04/2024 11:04:58 ******************
-- VIEW: public.firms_dialog

--DROP VIEW public.firms_dialog;

CREATE OR REPLACE VIEW public.firms_dialog AS
	SELECT
		t.id
		,t.name
		,t.inn
	FROM public.firms AS t
	;
	
ALTER VIEW public.firms_dialog OWNER TO glab;


-- ******************* update 25/04/2024 11:06:56 ******************
-- VIEW: public.firms_list

--DROP VIEW public.firms_list;

CREATE OR REPLACE VIEW public.firms_list AS
	SELECT
		t.id
		,t.name
		,t.inn
	FROM public.firms AS t
	
	ORDER BY name ASC
	;
	
ALTER VIEW public.firms_list OWNER TO glab;


-- ******************* update 25/04/2024 11:19:06 ******************
/**
 * Andrey Mikhalevich 15/12/21
 * This file is part of the OSBE framework
 *
 * THIS FILE IS GENERATED FROM TEMPLATE build/templates/permissions/permissions.sql.tmpl
 * ALL DIRECT MODIFICATIONS WILL BE LOST WITH THE NEXT BUILD PROCESS!!!
 */

/*
-- If this is the first time you execute the script, uncomment these lines
-- to create table and insert row
CREATE TABLE IF NOT EXISTS permissions (
    rules json NOT NULL
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.permissions OWNER TO glab;

INSERT INTO permissions VALUES ('{"admin":{}}');
*/

UPDATE permissions SET rules = '{
	"admin":{
		"Event":{
			"subscribe":true
			,"unsubscribe":true
			,"publish":true
		}
		,"Constant":{
			"set_value":true
			,"get_list":true
			,"get_object":true
			,"get_values":true
		}
		,"Enum":{
			"get_enum_list":true
		}
		,"MainMenuConstructor":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MainMenuContent":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"View":{
			"get_list":true
			,"complete":true
			,"get_section_list":true
		}
		,"VariantStorage":{
			"insert":true
			,"upsert_filter_data":true
			,"upsert_col_visib_data":true
			,"upsert_col_order_data":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_filter_data":true
			,"get_col_visib_data":true
			,"get_col_order_data":true
		}
		,"About":{
			"get_object":true
		}
		,"Service":{
			"reload_config":true
			,"reload_version":true
		}
		,"User":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
			,"get_profile":true
			,"reset_pwd":true
			,"login":true
			,"login_refresh":true
			,"logout":true
			,"logout_html":true
			,"download_photo":true
			,"delete_photo":true
			,"password_recover":true
		}
		,"Login":{
			"get_list":true
			,"get_object":true
			,"logout":true
		}
		,"LoginDevice":{
			"get_list":true
			,"switch_banned":true
		}
		,"Captcha":{
			"get":true
		}
		,"LoginDeviceBan":{
			"insert":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"TimeZoneLocale":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Department":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Post":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Contact":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
			,"upsert":true
		}
		,"EntityContact":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ObjectModLog":{
			"get_list":true
			,"get_object":true
		}
		,"MailMessage":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MailMessageAttachment":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MailTemplate":{
			"insert":true
			,"update":true
			,"get_list":true
			,"get_object":true
		}
		,"Attachment":{
			"get_list":true
			,"get_object":true
			,"delete_file":true
			,"get_file":true
			,"add_file":true
		}
		,"AutoMake":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"AutoModel":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_make":true
			,"get_all_years":true
		}
		,"AutoModelGeneration":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_model":true
			,"gen_next_id":true
		}
		,"AutoType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"AutoBodyType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoBodyDoor":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoBody":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_model_generation":true
			,"complete_for_model":true
		}
		,"ItemFolder":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemFeature":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemFeatureValueList":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItemFeatureValueList":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFeatureGroupItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFolderFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItemFolderFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Item":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_item":true
			,"complete":true
			,"set_feature":true
			,"get_features_filter_list":true
		}
		,"Manufacturer":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ManufacturerBrand":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Supplier":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"VehicleType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemPriority":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"PopularityType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"import":true
			,"set_feature":true
			,"get_features_filter_list":true
		}
		,"ItemSearch":{
			"get_object":true
			,"find_items":true
		}
		,"ImportItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierStore":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_supplier":true
		}
		,"SupplierStoreValue":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoPriceCategory":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoToGlassMatchHead":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoToGlassMatchEurocode":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_body_list":true
		}
		,"AutoToGlassMatchOption":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_conf_form":true
		}
		,"AutoModelGenerationBody":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"BankCard":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Employee":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"EmployeeStatus":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"PersonDocument":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"PersonDocumentType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"CashLocation":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"FinExpenseType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"CashFlowIn":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_cash_flow_in_out_list":true
		}
		,"CashFlowOut":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"CashFlowTransfer":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Firm":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
	}
	,"guest":{
		"User":{
			"login":true
		}
	}
}';


-- ******************* update 25/04/2024 11:57:51 ******************

	
	-- Adding menu item
	INSERT INTO views
	(id,c,f,t,section,descr,limited)
	VALUES (
	'10030',
	'Bank_Controller',
	'get_list',
	'BankList',
	'Справочники',
	'Банки',
	FALSE
	);
	
	

-- ******************* update 25/04/2024 11:59:29 ******************
/**
 * Andrey Mikhalevich 15/12/21
 * This file is part of the OSBE framework
 *
 * THIS FILE IS GENERATED FROM TEMPLATE build/templates/permissions/permissions.sql.tmpl
 * ALL DIRECT MODIFICATIONS WILL BE LOST WITH THE NEXT BUILD PROCESS!!!
 */

/*
-- If this is the first time you execute the script, uncomment these lines
-- to create table and insert row
CREATE TABLE IF NOT EXISTS permissions (
    rules json NOT NULL
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.permissions OWNER TO glab;

INSERT INTO permissions VALUES ('{"admin":{}}');
*/

UPDATE permissions SET rules = '{
	"admin":{
		"Event":{
			"subscribe":true
			,"unsubscribe":true
			,"publish":true
		}
		,"Constant":{
			"set_value":true
			,"get_list":true
			,"get_object":true
			,"get_values":true
		}
		,"Enum":{
			"get_enum_list":true
		}
		,"MainMenuConstructor":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MainMenuContent":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"View":{
			"get_list":true
			,"complete":true
			,"get_section_list":true
		}
		,"VariantStorage":{
			"insert":true
			,"upsert_filter_data":true
			,"upsert_col_visib_data":true
			,"upsert_col_order_data":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_filter_data":true
			,"get_col_visib_data":true
			,"get_col_order_data":true
		}
		,"About":{
			"get_object":true
		}
		,"Service":{
			"reload_config":true
			,"reload_version":true
		}
		,"User":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
			,"get_profile":true
			,"reset_pwd":true
			,"login":true
			,"login_refresh":true
			,"logout":true
			,"logout_html":true
			,"download_photo":true
			,"delete_photo":true
			,"password_recover":true
		}
		,"Login":{
			"get_list":true
			,"get_object":true
			,"logout":true
		}
		,"LoginDevice":{
			"get_list":true
			,"switch_banned":true
		}
		,"Captcha":{
			"get":true
		}
		,"LoginDeviceBan":{
			"insert":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"TimeZoneLocale":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Department":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Post":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Contact":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
			,"upsert":true
		}
		,"EntityContact":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ObjectModLog":{
			"get_list":true
			,"get_object":true
		}
		,"MailMessage":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MailMessageAttachment":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MailTemplate":{
			"insert":true
			,"update":true
			,"get_list":true
			,"get_object":true
		}
		,"Attachment":{
			"get_list":true
			,"get_object":true
			,"delete_file":true
			,"get_file":true
			,"add_file":true
		}
		,"AutoMake":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"AutoModel":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_make":true
			,"get_all_years":true
		}
		,"AutoModelGeneration":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_model":true
			,"gen_next_id":true
		}
		,"AutoType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"AutoBodyType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoBodyDoor":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoBody":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_model_generation":true
			,"complete_for_model":true
		}
		,"ItemFolder":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemFeature":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemFeatureValueList":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItemFeatureValueList":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFeatureGroupItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFolderFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItemFolderFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Item":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_item":true
			,"complete":true
			,"set_feature":true
			,"get_features_filter_list":true
		}
		,"Manufacturer":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ManufacturerBrand":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Supplier":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"VehicleType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemPriority":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"PopularityType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"import":true
			,"set_feature":true
			,"get_features_filter_list":true
		}
		,"ItemSearch":{
			"get_object":true
			,"find_items":true
		}
		,"ImportItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierStore":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_supplier":true
		}
		,"SupplierStoreValue":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoPriceCategory":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoToGlassMatchHead":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoToGlassMatchEurocode":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_body_list":true
		}
		,"AutoToGlassMatchOption":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_conf_form":true
		}
		,"AutoModelGenerationBody":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"BankCard":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Employee":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"EmployeeStatus":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"PersonDocument":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"PersonDocumentType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"CashLocation":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"FinExpenseType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"CashFlowIn":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_cash_flow_in_out_list":true
		}
		,"CashFlowOut":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"CashFlowTransfer":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Firm":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Bank":{
			"get_list":true
			,"get_object":true
			,"complete":true
		}
	}
	,"guest":{
		"User":{
			"login":true
		}
	}
}';


-- ******************* update 25/04/2024 12:15:10 ******************

	
	-- ********** Adding new table from model **********
	CREATE TABLE public.bank_accounts
	(id serial NOT NULL,parent_data_type data_types NOT NULL,parent_id int,name text,bank_acc  varchar(20),bank_bik  varchar(9),CONSTRAINT bank_accounts_pkey PRIMARY KEY (id)
	);
	
	DROP INDEX IF EXISTS bank_accounts_parent_idx;
	CREATE UNIQUE INDEX bank_accounts_parent_idx
	ON bank_accounts(parent_data_type,parent_id,name);

	ALTER TABLE public.bank_accounts OWNER TO glab;
	
	

-- ******************* update 25/04/2024 12:22:32 ******************
-- Function: banks.banks_ref(banks.banks)

-- DROP FUNCTION banks.banks_ref(banks.banks);

CREATE OR REPLACE FUNCTION banks.banks_ref(banks.banks)
  RETURNS json AS
$BODY$
	SELECT json_build_object(
		'keys',json_build_object(
			'bik',$1.bik   
			),	
		'descr',$1.bik||', '||$1.name||', '||$1.korshet,
		'dataType','banks'
	);
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION banks.banks_ref(banks.banks)
  OWNER TO glab;



-- ******************* update 25/04/2024 12:22:56 ******************
-- VIEW: public.bank_accounts_list

--DROP VIEW public.bank_accounts_list;

CREATE OR REPLACE VIEW public.bank_accounts_list AS
	SELECT
		t.id
		,t.parent_data_type
		,t.parent_id
		,t.name
		,t.bank_acc
		,banks.banks_ref(b) AS banks_ref
	FROM public.bank_accounts AS t
	LEFT JOIN banks.banks as b on b.bik = t.bank_bik
	ORDER BY t.name
	;
	
ALTER VIEW public.bank_accounts_list OWNER TO glab;


-- ******************* update 25/04/2024 12:41:02 ******************
--Refrerece type

CREATE OR REPLACE FUNCTION firms_ref(firms)
  RETURNS json AS
$$
	SELECT json_build_object(
		'keys',json_build_object(
			  'id', $1.id  
			),	
		'descr',$1.name,
		'dataType','firms'
	);
$$
  LANGUAGE sql VOLATILE COST 100;
ALTER FUNCTION firms_ref(firms) OWNER TO glab;	
	


-- ******************* update 25/04/2024 12:46:34 ******************

					ALTER TYPE data_types ADD VALUE 'firms';
					
	/* type get function */
	CREATE OR REPLACE FUNCTION enum_data_types_val(data_types,locales)
	RETURNS text AS $$
		SELECT
		CASE
		WHEN $1='users'::data_types AND $2='ru'::locales THEN 'Пользователи'
		WHEN $1='employees'::data_types AND $2='ru'::locales THEN 'Сотрудники'
		WHEN $1='bank_cards'::data_types AND $2='ru'::locales THEN 'Карты банков'
		WHEN $1='contacts'::data_types AND $2='ru'::locales THEN 'Контакты'
		WHEN $1='firms'::data_types AND $2='ru'::locales THEN 'Организации'
		ELSE ''
		END;		
	$$ LANGUAGE sql;	
	ALTER FUNCTION enum_data_types_val(data_types,locales) OWNER TO glab;		
	

-- ******************* update 25/04/2024 12:46:49 ******************
-- VIEW: public.bank_accounts_list

DROP VIEW public.bank_accounts_list;

CREATE OR REPLACE VIEW public.bank_accounts_list AS
	SELECT
		t.id
		,t.parent_data_type		
		,t.parent_id
		,CASE
			WHEN t.parent_data_type = 'firms' THEN firms_ref(f)
			ELSE '{"keys": null, "descr":""}'::json
		END AS parents_ref
		,t.name
		,t.bank_acc
		,banks.banks_ref(b) AS banks_ref
	FROM public.bank_accounts AS t
	LEFT JOIN banks.banks as b on b.bik = t.bank_bik
	LEFT JOIN firms as f on t.parent_data_type = 'firms' and f.id = t.parent_id
	ORDER BY t.name
	;
	
ALTER VIEW public.bank_accounts_list OWNER TO glab;


-- ******************* update 25/04/2024 13:51:25 ******************
/**
 * Andrey Mikhalevich 15/12/21
 * This file is part of the OSBE framework
 *
 * THIS FILE IS GENERATED FROM TEMPLATE build/templates/permissions/permissions.sql.tmpl
 * ALL DIRECT MODIFICATIONS WILL BE LOST WITH THE NEXT BUILD PROCESS!!!
 */

/*
-- If this is the first time you execute the script, uncomment these lines
-- to create table and insert row
CREATE TABLE IF NOT EXISTS permissions (
    rules json NOT NULL
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.permissions OWNER TO glab;

INSERT INTO permissions VALUES ('{"admin":{}}');
*/

UPDATE permissions SET rules = '{
	"admin":{
		"Event":{
			"subscribe":true
			,"unsubscribe":true
			,"publish":true
		}
		,"Constant":{
			"set_value":true
			,"get_list":true
			,"get_object":true
			,"get_values":true
		}
		,"Enum":{
			"get_enum_list":true
		}
		,"MainMenuConstructor":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MainMenuContent":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"View":{
			"get_list":true
			,"complete":true
			,"get_section_list":true
		}
		,"VariantStorage":{
			"insert":true
			,"upsert_filter_data":true
			,"upsert_col_visib_data":true
			,"upsert_col_order_data":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_filter_data":true
			,"get_col_visib_data":true
			,"get_col_order_data":true
		}
		,"About":{
			"get_object":true
		}
		,"Service":{
			"reload_config":true
			,"reload_version":true
		}
		,"User":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
			,"get_profile":true
			,"reset_pwd":true
			,"login":true
			,"login_refresh":true
			,"logout":true
			,"logout_html":true
			,"download_photo":true
			,"delete_photo":true
			,"password_recover":true
		}
		,"Login":{
			"get_list":true
			,"get_object":true
			,"logout":true
		}
		,"LoginDevice":{
			"get_list":true
			,"switch_banned":true
		}
		,"Captcha":{
			"get":true
		}
		,"LoginDeviceBan":{
			"insert":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"TimeZoneLocale":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Department":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Post":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Contact":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
			,"upsert":true
		}
		,"EntityContact":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ObjectModLog":{
			"get_list":true
			,"get_object":true
		}
		,"MailMessage":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MailMessageAttachment":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MailTemplate":{
			"insert":true
			,"update":true
			,"get_list":true
			,"get_object":true
		}
		,"Attachment":{
			"get_list":true
			,"get_object":true
			,"delete_file":true
			,"get_file":true
			,"add_file":true
		}
		,"AutoMake":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"AutoModel":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_make":true
			,"get_all_years":true
		}
		,"AutoModelGeneration":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_model":true
			,"gen_next_id":true
		}
		,"AutoType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"AutoBodyType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoBodyDoor":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoBody":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_model_generation":true
			,"complete_for_model":true
		}
		,"ItemFolder":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemFeature":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemFeatureValueList":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItemFeatureValueList":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFeatureGroupItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFolderFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItemFolderFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Item":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_item":true
			,"complete":true
			,"set_feature":true
			,"get_features_filter_list":true
		}
		,"Manufacturer":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ManufacturerBrand":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Supplier":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"VehicleType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemPriority":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"PopularityType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"import":true
			,"set_feature":true
			,"get_features_filter_list":true
		}
		,"ItemSearch":{
			"get_object":true
			,"find_items":true
		}
		,"ImportItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierStore":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_supplier":true
		}
		,"SupplierStoreValue":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoPriceCategory":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoToGlassMatchHead":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoToGlassMatchEurocode":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_body_list":true
		}
		,"AutoToGlassMatchOption":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_conf_form":true
		}
		,"AutoModelGenerationBody":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"BankCard":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Employee":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"EmployeeStatus":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"PersonDocument":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"PersonDocumentType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"CashLocation":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"FinExpenseType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"CashFlowIn":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_cash_flow_in_out_list":true
		}
		,"CashFlowOut":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"CashFlowTransfer":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Firm":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Bank":{
			"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"BankAccount":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
	}
	,"guest":{
		"User":{
			"login":true
		}
	}
}';


-- ******************* update 25/04/2024 15:36:33 ******************
--Refrerece type
CREATE OR REPLACE FUNCTION bank_accounts_ref(bank_accounts)
  RETURNS json AS
$$
	SELECT json_build_object(
		'keys',json_build_object(
			'id',$1.id    
			),	
		'descr',$1.name,
		'dataType','bank_accounts'
	);
$$
  LANGUAGE sql VOLATILE COST 100;
ALTER FUNCTION bank_accounts_ref(bank_accounts) OWNER TO glab;	
	


-- ******************* update 25/04/2024 15:39:06 ******************
-- VIEW: public.bank_flow_list

--DROP VIEW public.bank_flow_list;

CREATE OR REPLACE VIEW public.bank_flow_list AS
	SELECT
		t.id
		,t.bank_account_id
		,bank_accounts_ref(bank_accounts_ref_t) AS bank_accounts_ref
		,t.date_time
		,t.uploaded_date_time
		,t.client_descr
		,t.pay_comment
		,t.total_in
		,t.total_out
	FROM public.bank_flow AS t
	LEFT JOIN bank_accounts AS bank_accounts_ref_t ON bank_accounts_ref_t.id = t.bank_account_id
	ORDER BY t.date_time DESC, bank_accounts_ref_t.name
	;
	
ALTER VIEW public.bank_flow_list OWNER TO glab;


-- ******************* update 25/04/2024 15:52:53 ******************

	
	-- Adding menu item
	INSERT INTO views
	(id,c,f,t,section,descr,limited)
	VALUES (
	'30004',
	'BankFlow_Controller',
	'get_list',
	'BankFlowList',
	'Документы',
	'Банковские выписки',
	FALSE
	);
	
	

-- ******************* update 25/04/2024 16:27:04 ******************
/**
 * Andrey Mikhalevich 15/12/21
 * This file is part of the OSBE framework
 *
 * THIS FILE IS GENERATED FROM TEMPLATE build/templates/permissions/permissions.sql.tmpl
 * ALL DIRECT MODIFICATIONS WILL BE LOST WITH THE NEXT BUILD PROCESS!!!
 */

/*
-- If this is the first time you execute the script, uncomment these lines
-- to create table and insert row
CREATE TABLE IF NOT EXISTS permissions (
    rules json NOT NULL
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.permissions OWNER TO glab;

INSERT INTO permissions VALUES ('{"admin":{}}');
*/

UPDATE permissions SET rules = '{
	"admin":{
		"Event":{
			"subscribe":true
			,"unsubscribe":true
			,"publish":true
		}
		,"Constant":{
			"set_value":true
			,"get_list":true
			,"get_object":true
			,"get_values":true
		}
		,"Enum":{
			"get_enum_list":true
		}
		,"MainMenuConstructor":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MainMenuContent":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"View":{
			"get_list":true
			,"complete":true
			,"get_section_list":true
		}
		,"VariantStorage":{
			"insert":true
			,"upsert_filter_data":true
			,"upsert_col_visib_data":true
			,"upsert_col_order_data":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_filter_data":true
			,"get_col_visib_data":true
			,"get_col_order_data":true
		}
		,"About":{
			"get_object":true
		}
		,"Service":{
			"reload_config":true
			,"reload_version":true
		}
		,"User":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
			,"get_profile":true
			,"reset_pwd":true
			,"login":true
			,"login_refresh":true
			,"logout":true
			,"logout_html":true
			,"download_photo":true
			,"delete_photo":true
			,"password_recover":true
		}
		,"Login":{
			"get_list":true
			,"get_object":true
			,"logout":true
		}
		,"LoginDevice":{
			"get_list":true
			,"switch_banned":true
		}
		,"Captcha":{
			"get":true
		}
		,"LoginDeviceBan":{
			"insert":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"TimeZoneLocale":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Department":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Post":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Contact":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
			,"upsert":true
		}
		,"EntityContact":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ObjectModLog":{
			"get_list":true
			,"get_object":true
		}
		,"MailMessage":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MailMessageAttachment":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MailTemplate":{
			"insert":true
			,"update":true
			,"get_list":true
			,"get_object":true
		}
		,"Attachment":{
			"get_list":true
			,"get_object":true
			,"delete_file":true
			,"get_file":true
			,"add_file":true
		}
		,"AutoMake":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"AutoModel":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_make":true
			,"get_all_years":true
		}
		,"AutoModelGeneration":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_model":true
			,"gen_next_id":true
		}
		,"AutoType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"AutoBodyType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoBodyDoor":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoBody":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_model_generation":true
			,"complete_for_model":true
		}
		,"ItemFolder":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemFeature":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemFeatureValueList":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItemFeatureValueList":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFeatureGroupItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFolderFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItemFolderFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Item":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_item":true
			,"complete":true
			,"set_feature":true
			,"get_features_filter_list":true
		}
		,"Manufacturer":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ManufacturerBrand":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Supplier":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"VehicleType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemPriority":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"PopularityType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"import":true
			,"set_feature":true
			,"get_features_filter_list":true
		}
		,"ItemSearch":{
			"get_object":true
			,"find_items":true
		}
		,"ImportItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierStore":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_supplier":true
		}
		,"SupplierStoreValue":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoPriceCategory":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoToGlassMatchHead":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoToGlassMatchEurocode":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_body_list":true
		}
		,"AutoToGlassMatchOption":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_conf_form":true
		}
		,"AutoModelGenerationBody":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"BankCard":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Employee":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"EmployeeStatus":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"PersonDocument":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"PersonDocumentType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"CashLocation":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"FinExpenseType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"CashFlowIn":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_cash_flow_in_out_list":true
		}
		,"CashFlowOut":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"CashFlowTransfer":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Firm":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Bank":{
			"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"BankAccount":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"BankFlow":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
	}
	,"guest":{
		"User":{
			"login":true
		}
	}
}';


-- ******************* update 26/04/2024 08:34:20 ******************

					ALTER TYPE doc_types ADD VALUE 'bank_flow_in';
					
					ALTER TYPE doc_types ADD VALUE 'bank_flow_out';
					
	/* type get function */
	CREATE OR REPLACE FUNCTION enum_doc_types_val(doc_types,locales)
	RETURNS text AS $$
		SELECT
		CASE
		WHEN $1='cash_flow_in'::doc_types AND $2='ru'::locales THEN 'ПКО'
		WHEN $1='cash_flow_out'::doc_types AND $2='ru'::locales THEN 'РКО'
		WHEN $1='cash_flow_transfers'::doc_types AND $2='ru'::locales THEN 'Перемещение денег'
		WHEN $1='bank_flow_in'::doc_types AND $2='ru'::locales THEN 'Строка банка поступление'
		WHEN $1='bank_flow_out'::doc_types AND $2='ru'::locales THEN 'Строка банка списание'
		ELSE ''
		END;		
	$$ LANGUAGE sql;	
	ALTER FUNCTION enum_doc_types_val(doc_types,locales) OWNER TO glab;		
	
					ALTER TYPE reg_types ADD VALUE 'bank_flow';
					
	/* type get function */
	CREATE OR REPLACE FUNCTION enum_reg_types_val(reg_types,locales)
	RETURNS text AS $$
		SELECT
		CASE
		WHEN $1='cash_flow'::reg_types AND $2='ru'::locales THEN 'Остатки в кассе'
		WHEN $1='bank_flow'::reg_types AND $2='ru'::locales THEN 'Остатки на счетах'
		ELSE ''
		END;		
	$$ LANGUAGE sql;	
	ALTER FUNCTION enum_reg_types_val(reg_types,locales) OWNER TO glab;		
	

-- ******************* update 26/04/2024 08:42:12 ******************
drop TABLE public.bank_flow cascade;


-- ******************* update 26/04/2024 08:43:07 ******************
-- VIEW: public.bank_flow_in_list

--DROP VIEW public.bank_flow_in_list;

CREATE OR REPLACE VIEW public.bank_flow_in_list AS
	SELECT
		t.id
		,t.bank_account_id
		,bank_accounts_ref(bank_accounts_ref_t) AS bank_accounts_ref
		,t.date_time
		,t.uploaded_date_time
		,t.client_descr
		,t.pay_comment
		,t.total_in
		,t.total_out
	FROM public.bank_flow_in AS t
	LEFT JOIN bank_accounts AS bank_accounts_ref_t ON bank_accounts_ref_t.id = t.bank_account_id
	ORDER BY t.date_time DESC, bank_accounts_ref_t.name
	;
	
ALTER VIEW public.bank_flow_in_list OWNER TO glab;


-- ******************* update 26/04/2024 08:49:29 ******************

		UPDATE views SET
			c='BankFlowIn_Controller',
			f='get_list',
			t='BankFlowInList',
			section='Документы',
			descr='Строки банка приходы',
			limited=FALSE
		WHERE id='30004';
	
	
	-- Adding menu item
	INSERT INTO views
	(id,c,f,t,section,descr,limited)
	VALUES (
	'30005',
	'BankFlowOut_Controller',
	'get_list',
	'BankFlowOutList',
	'Документы',
	'Строки банка списания',
	FALSE
	);
	
	

-- ******************* update 26/04/2024 09:03:02 ******************

alter table bank_flow_in drop column total_in cascade;
/*
	DROP INDEX IF EXISTS bank_flow_in_bank_acc_idx;
	CREATE INDEX bank_flow_in_bank_acc_idx
	ON bank_flow_in(bank_accounts);

	DROP INDEX IF EXISTS bank_flow_in_date_idx;
	CREATE INDEX bank_flow_in_date_idx
	ON bank_flow_in(date_time);
*/



-- ******************* update 26/04/2024 09:03:39 ******************

alter table bank_flow_in add column total numeric(15,2);
/*
	DROP INDEX IF EXISTS bank_flow_in_bank_acc_idx;
	CREATE INDEX bank_flow_in_bank_acc_idx
	ON bank_flow_in(bank_accounts);

	DROP INDEX IF EXISTS bank_flow_in_date_idx;
	CREATE INDEX bank_flow_in_date_idx
	ON bank_flow_in(date_time);
*/



-- ******************* update 26/04/2024 09:04:06 ******************

alter table bank_flow_in drop column total_out;
/*
	DROP INDEX IF EXISTS bank_flow_in_bank_acc_idx;
	CREATE INDEX bank_flow_in_bank_acc_idx
	ON bank_flow_in(bank_accounts);

	DROP INDEX IF EXISTS bank_flow_in_date_idx;
	CREATE INDEX bank_flow_in_date_idx
	ON bank_flow_in(date_time);
*/



-- ******************* update 26/04/2024 09:04:09 ******************
-- VIEW: public.bank_flow_in_list

--DROP VIEW public.bank_flow_in_list;

CREATE OR REPLACE VIEW public.bank_flow_in_list AS
	SELECT
		t.id
		,t.bank_account_id
		,bank_accounts_ref(bank_accounts_ref_t) AS bank_accounts_ref
		,t.date_time
		,t.uploaded_date_time
		,t.client_descr
		,t.pay_comment
		,t.total
	FROM public.bank_flow_in AS t
	LEFT JOIN bank_accounts AS bank_accounts_ref_t ON bank_accounts_ref_t.id = t.bank_account_id
	ORDER BY t.date_time DESC, bank_accounts_ref_t.name
	;
	
ALTER VIEW public.bank_flow_in_list OWNER TO glab;


-- ******************* update 26/04/2024 09:25:43 ******************
/**
 * Andrey Mikhalevich 15/12/21
 * This file is part of the OSBE framework
 *
 * THIS FILE IS GENERATED FROM TEMPLATE build/templates/permissions/permissions.sql.tmpl
 * ALL DIRECT MODIFICATIONS WILL BE LOST WITH THE NEXT BUILD PROCESS!!!
 */

/*
-- If this is the first time you execute the script, uncomment these lines
-- to create table and insert row
CREATE TABLE IF NOT EXISTS permissions (
    rules json NOT NULL
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.permissions OWNER TO glab;

INSERT INTO permissions VALUES ('{"admin":{}}');
*/

UPDATE permissions SET rules = '{
	"admin":{
		"Event":{
			"subscribe":true
			,"unsubscribe":true
			,"publish":true
		}
		,"Constant":{
			"set_value":true
			,"get_list":true
			,"get_object":true
			,"get_values":true
		}
		,"Enum":{
			"get_enum_list":true
		}
		,"MainMenuConstructor":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MainMenuContent":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"View":{
			"get_list":true
			,"complete":true
			,"get_section_list":true
		}
		,"VariantStorage":{
			"insert":true
			,"upsert_filter_data":true
			,"upsert_col_visib_data":true
			,"upsert_col_order_data":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_filter_data":true
			,"get_col_visib_data":true
			,"get_col_order_data":true
		}
		,"About":{
			"get_object":true
		}
		,"Service":{
			"reload_config":true
			,"reload_version":true
		}
		,"User":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
			,"get_profile":true
			,"reset_pwd":true
			,"login":true
			,"login_refresh":true
			,"logout":true
			,"logout_html":true
			,"download_photo":true
			,"delete_photo":true
			,"password_recover":true
		}
		,"Login":{
			"get_list":true
			,"get_object":true
			,"logout":true
		}
		,"LoginDevice":{
			"get_list":true
			,"switch_banned":true
		}
		,"Captcha":{
			"get":true
		}
		,"LoginDeviceBan":{
			"insert":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"TimeZoneLocale":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Department":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Post":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Contact":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
			,"upsert":true
		}
		,"EntityContact":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ObjectModLog":{
			"get_list":true
			,"get_object":true
		}
		,"MailMessage":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MailMessageAttachment":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MailTemplate":{
			"insert":true
			,"update":true
			,"get_list":true
			,"get_object":true
		}
		,"Attachment":{
			"get_list":true
			,"get_object":true
			,"delete_file":true
			,"get_file":true
			,"add_file":true
		}
		,"AutoMake":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"AutoModel":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_make":true
			,"get_all_years":true
		}
		,"AutoModelGeneration":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_model":true
			,"gen_next_id":true
		}
		,"AutoType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"AutoBodyType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoBodyDoor":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoBody":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_model_generation":true
			,"complete_for_model":true
		}
		,"ItemFolder":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemFeature":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemFeatureValueList":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItemFeatureValueList":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFeatureGroupItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFolderFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItemFolderFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Item":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_item":true
			,"complete":true
			,"set_feature":true
			,"get_features_filter_list":true
		}
		,"Manufacturer":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ManufacturerBrand":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Supplier":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"VehicleType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemPriority":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"PopularityType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"import":true
			,"set_feature":true
			,"get_features_filter_list":true
		}
		,"ItemSearch":{
			"get_object":true
			,"find_items":true
		}
		,"ImportItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierStore":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_supplier":true
		}
		,"SupplierStoreValue":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoPriceCategory":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoToGlassMatchHead":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoToGlassMatchEurocode":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_body_list":true
		}
		,"AutoToGlassMatchOption":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_conf_form":true
		}
		,"AutoModelGenerationBody":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"BankCard":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Employee":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"EmployeeStatus":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"PersonDocument":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"PersonDocumentType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"CashLocation":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"FinExpenseType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"CashFlowIn":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_cash_flow_in_out_list":true
		}
		,"CashFlowOut":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"CashFlowTransfer":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Firm":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Bank":{
			"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"BankAccount":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"BankFlowIn":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"BankFlowOut":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
	}
	,"guest":{
		"User":{
			"login":true
		}
	}
}';


-- ******************* update 26/04/2024 09:30:33 ******************

-- VIEW: public.bank_flow_out_list

--DROP VIEW public.bank_flow_out_list;

CREATE OR REPLACE VIEW public.bank_flow_out_list AS
	SELECT
		t.id
		,t.bank_account_id
		,bank_accounts_ref(bank_accounts_ref_t) AS bank_accounts_ref
		,t.date_time
		,t.uploaded_date_time
		,t.client_descr
		,t.pay_comment
		,t.total
	FROM public.bank_flow_out AS t
	LEFT JOIN bank_accounts AS bank_accounts_ref_t ON bank_accounts_ref_t.id = t.bank_account_id
	ORDER BY t.date_time DESC, bank_accounts_ref_t.name
	;
	
ALTER VIEW public.bank_flow_out_list OWNER TO glab;


-- ******************* update 26/04/2024 09:35:49 ******************
--Populate with data
INSERT INTO rg_calc_periods VALUES

	('bank_flow'::reg_types,'2024-01-01 00:00:00'::timestamp without time zone)
;




-- ******************* update 26/04/2024 09:37:18 ******************
--TA balance

CREATE OR REPLACE FUNCTION rg_bank_flow_balance(
	
	IN in_bank_account_id_ar int[]
					
	)

  RETURNS TABLE(
	bank_account_id int
	,
	total  numeric(15,2)				
	) AS
$BODY$
	SELECT
		
		b.bank_account_id
		,b.total AS total				
	FROM rg_bank_flow AS b
	WHERE b.date_time=reg_current_balance_time()
		
		AND (in_bank_account_id_ar IS NULL OR ARRAY_LENGTH(in_bank_account_id_ar,1) IS NULL OR (b.bank_account_id=ANY(in_bank_account_id_ar)))
		
		AND(
		b.total<>0
		)
	ORDER BY
		
		b.bank_account_id;
$BODY$
  LANGUAGE sql VOLATILE CALLED ON NULL INPUT
  COST 100;

ALTER FUNCTION rg_bank_flow_balance(
	
	IN in_bank_account_id_ar int[]
					
	)
 OWNER TO glab;



-- ******************* update 26/04/2024 11:06:17 ******************

	
	-- ********** Adding new table from model **********
	CREATE TABLE public.ra_bank_flow
	(id serial NOT NULL,date_time timestamp NOT NULL,deb bool,doc_type doc_types NOT NULL,doc_id int,bank_account_id int NOT NULL REFERENCES bank_accounts(id),total  numeric(15,2),CONSTRAINT ra_bank_flow_pkey PRIMARY KEY (id)
	);
	
	DROP INDEX IF EXISTS ra_bank_flow_date_time_idx;
	CREATE INDEX ra_bank_flow_date_time_idx
	ON ra_bank_flow(date_time);

	DROP INDEX IF EXISTS ra_bank_flow_doc_idx;
	CREATE INDEX ra_bank_flow_doc_idx
	ON ra_bank_flow(doc_type,doc_id);

	DROP INDEX IF EXISTS ra_bank_flow_location_id_idx;
	CREATE INDEX ra_bank_flow_location_id_idx
	ON ra_bank_flow(bank_account_id);

	ALTER TABLE public.ra_bank_flow OWNER TO glab;
	



-- ******************* update 26/04/2024 11:06:21 ******************

CREATE OR REPLACE FUNCTION rg_bank_flow_balance(in_date_time timestamp,
	
	IN in_bank_account_id_ar int[]
					
	)

  RETURNS TABLE(
	bank_account_id int
	,
	total  numeric(15,2)				
	) AS
$BODY$
	WITH
	cur_per AS (SELECT rg_period('bank_flow'::reg_types, in_date_time) AS v ),
	
	act_forward AS (
		SELECT
			rg_period_balance('bank_flow'::reg_types,in_date_time) - in_date_time >
			(SELECT t.v FROM cur_per t) - in_date_time
			AS v
	),
	
	act_sg AS (SELECT CASE WHEN t.v THEN 1 ELSE -1 END AS v FROM act_forward t)

	SELECT 
	
	sub.bank_account_id
	,SUM(sub.total) AS total				
	FROM(
		(SELECT
		
		b.bank_account_id
		,b.total				
		FROM rg_bank_flow AS b
		WHERE
		
		(
			--date bigger than last calc period
			(in_date_time > rg_period_balance('bank_flow'::reg_types,rg_calc_period('bank_flow'::reg_types)) AND b.date_time = (SELECT rg_current_balance_time()))
			
			OR (
			--forward from previous period
			( (SELECT t.v FROM act_forward t) AND b.date_time = (SELECT t.v FROM cur_per t)-rg_calc_interval('bank_flow'::reg_types)
			)
			--backward from current
			OR			
			( NOT (SELECT t.v FROM act_forward t) AND b.date_time = (SELECT t.v FROM cur_per t)
			)
			
			)
		)	
		
				
		AND ( (in_bank_account_id_ar IS NULL OR ARRAY_LENGTH(in_bank_account_id_ar,1) IS NULL) OR (b.bank_account_id=ANY(in_bank_account_id_ar)))
		
		AND (
		b.total<>0
		)
		)
		
		UNION ALL
		
		(SELECT
		
		act.bank_account_id
		,CASE act.deb
			WHEN TRUE THEN act.total * (SELECT t.v FROM act_sg t)
			ELSE -act.total * (SELECT t.v FROM act_sg t)
		END AS quant
										
		FROM doc_log
		LEFT JOIN ra_bank_flow AS act ON act.doc_type=doc_log.doc_type AND act.doc_id=doc_log.doc_id
		WHERE
		(
			--forward from previous period
			( (SELECT t.v FROM act_forward t) AND
					act.date_time >= (SELECT t.v FROM cur_per t)
					AND act.date_time <= 
						(SELECT l.date_time FROM doc_log l
						WHERE date_trunc('second',l.date_time)<=date_trunc('second',in_date_time)
						ORDER BY l.date_time DESC LIMIT 1
						)
					
			)
			--backward from current
			OR			
			( NOT (SELECT t.v FROM act_forward t) AND
					act.date_time >= 
						(SELECT l.date_time FROM doc_log l
						WHERE date_trunc('second',l.date_time)>=date_trunc('second',in_date_time)
						ORDER BY l.date_time ASC LIMIT 1
						)			
					AND act.date_time <= (SELECT t.v FROM cur_per t)
			)
		)
			
		
		AND (in_bank_account_id_ar IS NULL OR ARRAY_LENGTH(in_bank_account_id_ar,1) IS NULL OR (act.bank_account_id=ANY(in_bank_account_id_ar)))
		
		AND (
		
		act.total<>0
		)
		ORDER BY doc_log.date_time,doc_log.id)
	) AS sub
	WHERE
	 (ARRAY_LENGTH(in_bank_account_id_ar,1) IS NULL OR (sub.bank_account_id=ANY(in_bank_account_id_ar)))
		
	GROUP BY
		
		sub.bank_account_id
	HAVING
		
		SUM(sub.total)<>0
						
	ORDER BY
		
		sub.bank_account_id;
$BODY$
  LANGUAGE sql VOLATILE CALLED ON NULL INPUT
  COST 100;

ALTER FUNCTION rg_bank_flow_balance(in_date_time timestamp,
	
	IN in_bank_account_id_ar int[]
					
	)
 OWNER TO glab;



-- ******************* update 26/04/2024 11:09:00 ******************
--process function
CREATE OR REPLACE FUNCTION ra_bank_flow_process()
  RETURNS trigger AS
$BODY$
DECLARE
	v_delta_total  numeric(15,2) DEFAULT 0;
	
	CALC_DATE_TIME timestamp;
	CURRENT_BALANCE_DATE_TIME timestamp;
	v_loop_rg_period timestamp;
	v_calc_interval interval;			  			
BEGIN
	IF (TG_WHEN='BEFORE' AND TG_OP='INSERT') THEN
		RETURN NEW;
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='UPDATE') THEN
		RETURN NEW;
	ELSIF (TG_WHEN='AFTER' AND (TG_OP='UPDATE' OR TG_OP='INSERT')) THEN

		CALC_DATE_TIME = rg_calc_period('bank_flow'::reg_types);

		IF (CALC_DATE_TIME IS NULL) OR (NEW.date_time::date > rg_period_balance('bank_flow'::reg_types, CALC_DATE_TIME)) THEN
			CALC_DATE_TIME = rg_period('bank_flow'::reg_types,NEW.date_time);
			PERFORM rg_bank_flow_set_custom_period(CALC_DATE_TIME);						
		END IF;
		
		IF TG_OP='UPDATE' THEN
			v_delta_total = OLD.total;
			
		ELSE
			v_delta_total = 0;
								
		END IF;
		v_delta_total = NEW.total - v_delta_total;
		
		IF NOT NEW.deb THEN
			v_delta_total = -1 * v_delta_total;
								
		END IF;
		
		v_loop_rg_period = CALC_DATE_TIME;
		v_calc_interval = rg_calc_interval('bank_flow'::reg_types);
		LOOP
			UPDATE rg_bank_flow
			SET
			total = total + v_delta_total
			WHERE 
				date_time=v_loop_rg_period
				
				AND bank_account_id = NEW.bank_account_id;
			IF NOT FOUND THEN
				BEGIN
					INSERT INTO rg_bank_flow (date_time
					
					,bank_account_id
					,total)				
					VALUES (v_loop_rg_period
					
					,NEW.bank_account_id
					,v_delta_total);
				EXCEPTION WHEN OTHERS THEN
					UPDATE rg_bank_flow
					SET
					total = total + v_delta_total
					WHERE date_time = v_loop_rg_period
					
					AND bank_account_id = NEW.bank_account_id;
				END;
			END IF;

			v_loop_rg_period = v_loop_rg_period + v_calc_interval;
			IF v_loop_rg_period > CALC_DATE_TIME THEN
				EXIT;  -- exit loop
			END IF;
		END LOOP;

		--Current balance
		CURRENT_BALANCE_DATE_TIME = reg_current_balance_time();
		UPDATE rg_bank_flow
		SET
		total = total + v_delta_total
		WHERE 
			date_time=CURRENT_BALANCE_DATE_TIME
			
			AND bank_account_id = NEW.bank_account_id;
		IF NOT FOUND THEN
			BEGIN
				INSERT INTO rg_bank_flow (date_time
				
				,bank_account_id
				,total)				
				VALUES (CURRENT_BALANCE_DATE_TIME
				
				,NEW.bank_account_id
				,v_delta_total);
			EXCEPTION WHEN OTHERS THEN
				UPDATE rg_bank_flow
				SET
				total = total + v_delta_total
				WHERE 
					date_time=CURRENT_BALANCE_DATE_TIME
					
					AND bank_account_id = NEW.bank_account_id;
			END;
		END IF;
		
		RETURN NEW;					
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='DELETE') THEN
		RETURN OLD;
	ELSIF (TG_WHEN='AFTER' AND TG_OP='DELETE') THEN
		
		CALC_DATE_TIME = rg_calc_period('bank_flow'::reg_types);

		IF (CALC_DATE_TIME IS NULL) OR (OLD.date_time::date > rg_period_balance('bank_flow'::reg_types, CALC_DATE_TIME)) THEN
			CALC_DATE_TIME = rg_period('bank_flow'::reg_types,OLD.date_time);
			PERFORM rg_bank_flow_set_custom_period(CALC_DATE_TIME);						
		END IF;
		
		v_delta_total = OLD.total;
							
		IF OLD.deb THEN
			v_delta_total = -1*v_delta_total;					
			
		END IF;
		
		
		PERFORM rg_bank_flow_update_periods(OLD.date_time
		
		,bank_account_id
		,v_delta_total);
		
		RETURN OLD;					
	END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;

ALTER FUNCTION ra_bank_flow_process() OWNER TO glab;



-- ******************* update 26/04/2024 11:10:09 ******************
-- before trigger
CREATE TRIGGER ra_bank_flow_before
	BEFORE INSERT OR UPDATE OR DELETE ON ra_bank_flow
	FOR EACH ROW EXECUTE PROCEDURE ra_bank_flow_process();
	
-- after trigger
CREATE TRIGGER ra_bank_flow_after
	AFTER INSERT OR UPDATE OR DELETE ON ra_bank_flow
	FOR EACH ROW EXECUTE PROCEDURE ra_bank_flow_process();



-- ******************* update 26/04/2024 11:10:55 ******************
-- ADD
CREATE OR REPLACE FUNCTION ra_bank_flow_add_act(reg_act ra_bank_flow)
RETURNS void AS
$BODY$
	INSERT INTO ra_bank_flow
	(date_time,doc_type,doc_id
	,deb
	,bank_account_id
	,total				
	)
	VALUES (
	$1.date_time,$1.doc_type,$1.doc_id
	,$1.deb
	,$1.bank_account_id
	,$1.total				
	);
$BODY$
LANGUAGE sql VOLATILE STRICT COST 100;

ALTER FUNCTION ra_bank_flow_add_act(reg_act ra_bank_flow) OWNER TO glab;



-- ******************* update 26/04/2024 11:11:41 ******************
-- REMOVE
CREATE OR REPLACE FUNCTION ra_bank_flow_remove_acts(in_doc_type doc_types,in_doc_id int)
RETURNS void AS
$BODY$
	DELETE FROM ra_bank_flow
	WHERE doc_type=$1 AND doc_id=$2;
$BODY$
LANGUAGE sql VOLATILE STRICT COST 100;

ALTER FUNCTION ra_bank_flow_remove_acts(in_doc_type doc_types,in_doc_id int) OWNER TO glab;




-- ******************* update 26/04/2024 11:13:54 ******************
--DROP VIEW ra_bank_flow_list_view;
CREATE OR REPLACE VIEW ra_bank_flow_list AS
	SELECT
		ra_bank_flow.id,
		ra_bank_flow.date_time,
		ra_bank_flow.deb,
		ra_bank_flow.doc_type,
		ra_bank_flow.doc_id,
		CASE ra_bank_flow.doc_type
			WHEN 'bank_flow_in' then 'Строка выписки приход'
			WHEN 'bank_flow_out' then 'Строка выписки расход'
			ELSE 'Не известнй документ'
		END AS doc_descr
	FROM ra_bank_flow
;

ALTER TABLE ra_bank_flow_list OWNER TO glab;



-- ******************* update 26/04/2024 11:18:52 ******************
-- Function: public.bank_flow_in_process()

-- DROP FUNCTION public.bank_flow_in_process();

CREATE OR REPLACE FUNCTION public.bank_flow_in_process()
  RETURNS trigger AS
$BODY$
DECLARE
	reg_act ra_bank_flow%ROWTYPE;
BEGIN
	IF (TG_WHEN='BEFORE' AND TG_OP='INSERT') THEN
		--IF NEW.date_time < '2024-01-01T00:00:00'::timestamp THEN
		--	RAISE EXCEPTION 'Дата запрета редактирования: %', '2024-01-01T00:00:00'::timestamp;
		--END IF;
		
		RETURN NEW;
		
	ELSIF (TG_WHEN='AFTER') AND (TG_OP='INSERT' OR TG_OP='UPDATE') THEN					
		IF (TG_OP='INSERT') THEN						
			--log
			PERFORM doc_log_insert('bank_flow_in'::doc_types,NEW.id,NEW.date_time);
		END IF;

		--register actions ra_bank_flow
		reg_act.date_time		= NEW.date_time;
		reg_act.deb			= true;
		reg_act.doc_type  		= 'bank_flow_in'::doc_types;
		reg_act.doc_id  		= NEW.id;
		reg_act.bank_account_id		= NEW.bank_account_id;
		reg_act.total			= NEW.total;
		PERFORM ra_bank_flow_add_act(reg_act);	
		
		RETURN NEW;
		
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='UPDATE') THEN
		--IF NEW.date_time < '2024-01-01T00:00:00'::timestamp THEN
		--	RAISE EXCEPTION 'Дата запрета редактирования: %', '2024-01-01T00:00:00'::timestamp;
		--END IF;
	
		PERFORM ra_bank_flow_remove_acts('bank_flow_in'::doc_types,OLD.id);

		-- Временно!
		IF NEW.date_time<>OLD.date_time THEN
			PERFORM doc_log_update('bank_flow_in'::doc_types,NEW.id,NEW.date_time);
		END IF;
						
		RETURN NEW;
		
	ELSIF (TG_WHEN='AFTER' AND TG_OP='DELETE') THEN
	
		RETURN OLD;
		
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='DELETE') THEN
		--IF OLD.date_time < '2024-01-01T00:00:00'::timestamp THEN
		--	RAISE EXCEPTION 'Дата запрета редактирования: %', '2024-01-01T00:00:00'::timestamp;
		--END IF;
	
		--detail tables
		
		--register actions										
		PERFORM ra_bank_flow_remove_acts('bank_flow_in'::doc_types,OLD.id);
		
		--log
		PERFORM doc_log_delete('bank_flow_in'::doc_types,OLD.id);
		
		RETURN OLD;
	END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.bank_flow_in_process()
  OWNER TO glab;



-- ******************* update 26/04/2024 11:18:57 ******************
-- Trigger: bank_flow_in_before

-- DROP TRIGGER bank_flow_in_before ON public.bank_flow_in;

CREATE TRIGGER bank_flow_in_before
    BEFORE INSERT OR DELETE OR UPDATE 
    ON public.bank_flow_in
    FOR EACH ROW
    EXECUTE PROCEDURE public.bank_flow_in_process();
    
-- Trigger: bank_flow_in_after

--DROP TRIGGER bank_flow_in_after ON public.bank_flow_in;

CREATE TRIGGER bank_flow_in_after
    AFTER INSERT OR DELETE OR UPDATE 
    ON public.bank_flow_in
    FOR EACH ROW
    EXECUTE PROCEDURE public.bank_flow_in_process();    



-- ******************* update 26/04/2024 11:19:01 ******************
-- Function: public.bank_flow_out_process()

-- DROP FUNCTION public.bank_flow_out_process();

CREATE OR REPLACE FUNCTION public.bank_flow_out_process()
  RETURNS trigger AS
$BODY$
DECLARE
	reg_act ra_bank_flow%ROWTYPE;
BEGIN
	IF (TG_WHEN='BEFORE' AND TG_OP='INSERT') THEN
		--IF NEW.date_time < '2024-01-01T00:00:00'::timestamp THEN
		--	RAISE EXCEPTION 'Дата запрета редактирования: %', '2024-01-01T00:00:00'::timestamp;
		--END IF;
		
		RETURN NEW;
		
	ELSIF (TG_WHEN='AFTER') AND (TG_OP='INSERT' OR TG_OP='UPDATE') THEN					
		IF (TG_OP='INSERT') THEN						
			--log
			PERFORM doc_log_insert('bank_flow_out'::doc_types,NEW.id,NEW.date_time);
		END IF;

		--register actions ra_bank_flow
		reg_act.date_time		= NEW.date_time;
		reg_act.deb			= false;
		reg_act.doc_type  		= 'bank_flow_out'::doc_types;
		reg_act.doc_id  		= NEW.id;
		reg_act.bank_account_id		= NEW.bank_account_id;
		reg_act.total			= NEW.total;
		PERFORM ra_bank_flow_add_act(reg_act);	
		
		RETURN NEW;
		
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='UPDATE') THEN
		--IF NEW.date_time < '2024-01-01T00:00:00'::timestamp THEN
		--	RAISE EXCEPTION 'Дата запрета редактирования: %', '2024-01-01T00:00:00'::timestamp;
		--END IF;
	
		PERFORM ra_bank_flow_remove_acts('bank_flow_out'::doc_types,OLD.id);

		-- Временно!
		IF NEW.date_time<>OLD.date_time THEN
			PERFORM doc_log_update('bank_flow_out'::doc_types,NEW.id,NEW.date_time);
		END IF;
						
		RETURN NEW;
		
	ELSIF (TG_WHEN='AFTER' AND TG_OP='DELETE') THEN
	
		RETURN OLD;
		
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='DELETE') THEN
		--IF OLD.date_time < '2024-01-01T00:00:00'::timestamp THEN
		--	RAISE EXCEPTION 'Дата запрета редактирования: %', '2024-01-01T00:00:00'::timestamp;
		--END IF;
	
		--detail tables
		
		--register actions										
		PERFORM ra_bank_flow_remove_acts('bank_flow_out'::doc_types,OLD.id);
		
		--log
		PERFORM doc_log_delete('bank_flow_out'::doc_types,OLD.id);
		
		RETURN OLD;
	END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.bank_flow_out_process()
  OWNER TO glab;



-- ******************* update 26/04/2024 11:19:05 ******************
-- Trigger: bank_flow_out_before

-- DROP TRIGGER bank_flow_out_before ON public.bank_flow_out;

CREATE TRIGGER bank_flow_out_before
    BEFORE INSERT OR DELETE OR UPDATE 
    ON public.bank_flow_out
    FOR EACH ROW
    EXECUTE PROCEDURE public.bank_flow_out_process();
    
-- Trigger: bank_flow_out_after

--DROP TRIGGER bank_flow_out_after ON public.bank_flow_out;

CREATE TRIGGER bank_flow_out_after
    AFTER INSERT OR DELETE OR UPDATE 
    ON public.bank_flow_out
    FOR EACH ROW
    EXECUTE PROCEDURE public.bank_flow_out_process();    



-- ******************* update 27/04/2024 06:48:46 ******************
-- Function: public.bank_flow_in_process()

-- DROP FUNCTION public.bank_flow_in_process();

CREATE OR REPLACE FUNCTION public.bank_flow_in_process()
  RETURNS trigger AS
$BODY$
DECLARE
	reg_act ra_bank_flow%ROWTYPE;
BEGIN
	IF (TG_WHEN='BEFORE' AND TG_OP='INSERT') THEN
		--IF NEW.date_time < '2024-01-01T00:00:00'::timestamp THEN
		--	RAISE EXCEPTION 'Дата запрета редактирования: %', '2024-01-01T00:00:00'::timestamp;
		--END IF;
		
		RETURN NEW;
		
	ELSIF (TG_WHEN='AFTER') AND (TG_OP='INSERT' OR TG_OP='UPDATE') THEN					
RAISE EXCEPTION 'NEW.bank_account_id=%', NEW.bank_account_id;	
		IF (TG_OP='INSERT') THEN						
			--log
			PERFORM doc_log_insert('bank_flow_in'::doc_types,NEW.id,NEW.date_time);
		END IF;

		--register actions ra_bank_flow
		reg_act.date_time		= NEW.date_time;
		reg_act.deb			= true;
		reg_act.doc_type  		= 'bank_flow_in'::doc_types;
		reg_act.doc_id  		= NEW.id;
		reg_act.bank_account_id		= NEW.bank_account_id;
		reg_act.total			= NEW.total;
		PERFORM ra_bank_flow_add_act(reg_act);	
		
		RETURN NEW;
		
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='UPDATE') THEN
		--IF NEW.date_time < '2024-01-01T00:00:00'::timestamp THEN
		--	RAISE EXCEPTION 'Дата запрета редактирования: %', '2024-01-01T00:00:00'::timestamp;
		--END IF;
	
		PERFORM ra_bank_flow_remove_acts('bank_flow_in'::doc_types,OLD.id);

		-- Временно!
		IF NEW.date_time<>OLD.date_time THEN
			PERFORM doc_log_update('bank_flow_in'::doc_types,NEW.id,NEW.date_time);
		END IF;
						
		RETURN NEW;
		
	ELSIF (TG_WHEN='AFTER' AND TG_OP='DELETE') THEN
	
		RETURN OLD;
		
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='DELETE') THEN
		--IF OLD.date_time < '2024-01-01T00:00:00'::timestamp THEN
		--	RAISE EXCEPTION 'Дата запрета редактирования: %', '2024-01-01T00:00:00'::timestamp;
		--END IF;
	
		--detail tables
		
		--register actions										
		PERFORM ra_bank_flow_remove_acts('bank_flow_in'::doc_types,OLD.id);
		
		--log
		PERFORM doc_log_delete('bank_flow_in'::doc_types,OLD.id);
		
		RETURN OLD;
	END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.bank_flow_in_process()
  OWNER TO glab;



-- ******************* update 27/04/2024 06:49:24 ******************
-- Function: public.bank_flow_in_process()

-- DROP FUNCTION public.bank_flow_in_process();

CREATE OR REPLACE FUNCTION public.bank_flow_in_process()
  RETURNS trigger AS
$BODY$
DECLARE
	reg_act ra_bank_flow%ROWTYPE;
BEGIN
	IF (TG_WHEN='BEFORE' AND TG_OP='INSERT') THEN
		--IF NEW.date_time < '2024-01-01T00:00:00'::timestamp THEN
		--	RAISE EXCEPTION 'Дата запрета редактирования: %', '2024-01-01T00:00:00'::timestamp;
		--END IF;
		
		RETURN NEW;
		
	ELSIF (TG_WHEN='AFTER') AND (TG_OP='INSERT' OR TG_OP='UPDATE') THEN					
--RAISE EXCEPTION 'NEW.bank_account_id=%', NEW.bank_account_id;	
		IF (TG_OP='INSERT') THEN						
			--log
			PERFORM doc_log_insert('bank_flow_in'::doc_types,NEW.id,NEW.date_time);
		END IF;

		--register actions ra_bank_flow
		reg_act.date_time		= NEW.date_time;
		reg_act.deb			= true;
		reg_act.doc_type  		= 'bank_flow_in'::doc_types;
		reg_act.doc_id  		= NEW.id;
		reg_act.bank_account_id		= NEW.bank_account_id;
		reg_act.total			= NEW.total;
		PERFORM ra_bank_flow_add_act(reg_act);	
		
		RETURN NEW;
		
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='UPDATE') THEN
		--IF NEW.date_time < '2024-01-01T00:00:00'::timestamp THEN
		--	RAISE EXCEPTION 'Дата запрета редактирования: %', '2024-01-01T00:00:00'::timestamp;
		--END IF;
	
		PERFORM ra_bank_flow_remove_acts('bank_flow_in'::doc_types,OLD.id);

		-- Временно!
		IF NEW.date_time<>OLD.date_time THEN
			PERFORM doc_log_update('bank_flow_in'::doc_types,NEW.id,NEW.date_time);
		END IF;
						
		RETURN NEW;
		
	ELSIF (TG_WHEN='AFTER' AND TG_OP='DELETE') THEN
	
		RETURN OLD;
		
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='DELETE') THEN
		--IF OLD.date_time < '2024-01-01T00:00:00'::timestamp THEN
		--	RAISE EXCEPTION 'Дата запрета редактирования: %', '2024-01-01T00:00:00'::timestamp;
		--END IF;
	
		--detail tables
		
		--register actions										
		PERFORM ra_bank_flow_remove_acts('bank_flow_in'::doc_types,OLD.id);
		
		--log
		PERFORM doc_log_delete('bank_flow_in'::doc_types,OLD.id);
		
		RETURN OLD;
	END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.bank_flow_in_process()
  OWNER TO glab;



-- ******************* update 27/04/2024 06:58:48 ******************
CREATE OR REPLACE FUNCTION rg_bank_flow_set_custom_period(IN in_new_period timestamp without time zone)
  RETURNS void AS
$BODY$
DECLARE
	NEW_PERIOD timestamp without time zone;
	v_prev_current_period timestamp without time zone;
	v_current_period timestamp without time zone;
	CURRENT_PERIOD timestamp without time zone;
	TA_PERIOD timestamp without time zone;
	REG_INTERVAL interval;
BEGIN
	NEW_PERIOD = rg_calc_period_start('bank_flow'::reg_types, in_new_period);
	SELECT date_time INTO CURRENT_PERIOD FROM rg_calc_periods WHERE reg_type = 'bank_flow'::reg_types;
	TA_PERIOD = reg_current_balance_time();
	--iterate through all periods between CURRENT_PERIOD and NEW_PERIOD
	REG_INTERVAL = rg_calc_interval('bank_flow'::reg_types);
	v_prev_current_period = CURRENT_PERIOD;		
	LOOP
		v_current_period = v_prev_current_period + REG_INTERVAL;
		IF v_current_period > NEW_PERIOD THEN
			EXIT;  -- exit loop
		END IF;
		
		--clear period
		DELETE FROM rg_bank_flow
		WHERE date_time = v_current_period;
		
		--new data
		INSERT INTO rg_bank_flow
		(date_time
		
		,bank_account_id
		,total						
		)
		(SELECT
				v_current_period
				
				,rg.bank_account_id
				,rg.total				
			FROM rg_bank_flow As rg
			WHERE (
			
			rg.total<>0
										
			)
			AND (rg.date_time=v_prev_current_period)
		);

		v_prev_current_period = v_current_period;
	END LOOP;

	--new TA data
	DELETE FROM rg_bank_flow
	WHERE date_time=TA_PERIOD;
	INSERT INTO rg_bank_flow
	(date_time
	
	,bank_account_id
	,total	
	)
	(SELECT
		TA_PERIOD
		
		,rg.bank_account_id
		,rg.total
		FROM rg_bank_flow AS rg
		WHERE (
		
		rg.total<>0
											
		)
		AND (rg.date_time=NEW_PERIOD-REG_INTERVAL)
	);

	DELETE FROM rg_bank_flow WHERE (date_time>NEW_PERIOD)
	AND (date_time<>TA_PERIOD);

	--set new period
	UPDATE rg_calc_periods SET date_time = NEW_PERIOD
	WHERE reg_type='bank_flow'::reg_types;		
END
$BODY$
LANGUAGE plpgsql VOLATILE COST 100;

ALTER FUNCTION rg_bank_flow_set_custom_period(IN in_new_period timestamp without time zone) OWNER TO glab;




-- ******************* update 27/04/2024 07:00:05 ******************
--process function
CREATE OR REPLACE FUNCTION ra_bank_flow_process()
  RETURNS trigger AS
$BODY$
DECLARE
	v_delta_total  numeric(15,2) DEFAULT 0;
	
	CALC_DATE_TIME timestamp;
	CURRENT_BALANCE_DATE_TIME timestamp;
	v_loop_rg_period timestamp;
	v_calc_interval interval;			  			
BEGIN
	IF (TG_WHEN='BEFORE' AND TG_OP='INSERT') THEN
		RETURN NEW;
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='UPDATE') THEN
		RETURN NEW;
	ELSIF (TG_WHEN='AFTER' AND (TG_OP='UPDATE' OR TG_OP='INSERT')) THEN

		CALC_DATE_TIME = rg_calc_period('bank_flow'::reg_types);
raise exception 'CALC_DATE_TIME=%', CALC_DATE_TIME;
		IF (CALC_DATE_TIME IS NULL) OR (NEW.date_time::date > rg_period_balance('bank_flow'::reg_types, CALC_DATE_TIME)) THEN
			CALC_DATE_TIME = rg_period('bank_flow'::reg_types, NEW.date_time);
			PERFORM rg_bank_flow_set_custom_period(CALC_DATE_TIME);						
		END IF;
		
		IF TG_OP='UPDATE' THEN
			v_delta_total = OLD.total;
			
		ELSE
			v_delta_total = 0;
								
		END IF;
		v_delta_total = NEW.total - v_delta_total;
		
		IF NOT NEW.deb THEN
			v_delta_total = -1 * v_delta_total;
								
		END IF;
		
		v_loop_rg_period = CALC_DATE_TIME;
		v_calc_interval = rg_calc_interval('bank_flow'::reg_types);
		LOOP
			UPDATE rg_bank_flow
			SET
			total = total + v_delta_total
			WHERE 
				date_time=v_loop_rg_period
				
				AND bank_account_id = NEW.bank_account_id;
			IF NOT FOUND THEN
				BEGIN
					INSERT INTO rg_bank_flow (date_time
					
					,bank_account_id
					,total)				
					VALUES (v_loop_rg_period
					
					,NEW.bank_account_id
					,v_delta_total);
				EXCEPTION WHEN OTHERS THEN
					UPDATE rg_bank_flow
					SET
					total = total + v_delta_total
					WHERE date_time = v_loop_rg_period
					
					AND bank_account_id = NEW.bank_account_id;
				END;
			END IF;

			v_loop_rg_period = v_loop_rg_period + v_calc_interval;
			IF v_loop_rg_period > CALC_DATE_TIME THEN
				EXIT;  -- exit loop
			END IF;
		END LOOP;

		--Current balance
		CURRENT_BALANCE_DATE_TIME = reg_current_balance_time();
		UPDATE rg_bank_flow
		SET
		total = total + v_delta_total
		WHERE 
			date_time=CURRENT_BALANCE_DATE_TIME
			
			AND bank_account_id = NEW.bank_account_id;
		IF NOT FOUND THEN
			BEGIN
				INSERT INTO rg_bank_flow (date_time
				
				,bank_account_id
				,total)				
				VALUES (CURRENT_BALANCE_DATE_TIME
				
				,NEW.bank_account_id
				,v_delta_total);
			EXCEPTION WHEN OTHERS THEN
				UPDATE rg_bank_flow
				SET
				total = total + v_delta_total
				WHERE 
					date_time=CURRENT_BALANCE_DATE_TIME
					
					AND bank_account_id = NEW.bank_account_id;
			END;
		END IF;
		
		RETURN NEW;					
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='DELETE') THEN
		RETURN OLD;
	ELSIF (TG_WHEN='AFTER' AND TG_OP='DELETE') THEN
		
		CALC_DATE_TIME = rg_calc_period('bank_flow'::reg_types);

		IF (CALC_DATE_TIME IS NULL) OR (OLD.date_time::date > rg_period_balance('bank_flow'::reg_types, CALC_DATE_TIME)) THEN
			CALC_DATE_TIME = rg_period('bank_flow'::reg_types,OLD.date_time);
			PERFORM rg_bank_flow_set_custom_period(CALC_DATE_TIME);						
		END IF;
		
		v_delta_total = OLD.total;
							
		IF OLD.deb THEN
			v_delta_total = -1*v_delta_total;					
			
		END IF;
		
		
		PERFORM rg_bank_flow_update_periods(OLD.date_time
		
		,bank_account_id
		,v_delta_total);
		
		RETURN OLD;					
	END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;

ALTER FUNCTION ra_bank_flow_process() OWNER TO glab;



-- ******************* update 27/04/2024 07:00:47 ******************
--process function
CREATE OR REPLACE FUNCTION ra_bank_flow_process()
  RETURNS trigger AS
$BODY$
DECLARE
	v_delta_total  numeric(15,2) DEFAULT 0;
	
	CALC_DATE_TIME timestamp;
	CURRENT_BALANCE_DATE_TIME timestamp;
	v_loop_rg_period timestamp;
	v_calc_interval interval;			  			
BEGIN
	IF (TG_WHEN='BEFORE' AND TG_OP='INSERT') THEN
		RETURN NEW;
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='UPDATE') THEN
		RETURN NEW;
	ELSIF (TG_WHEN='AFTER' AND (TG_OP='UPDATE' OR TG_OP='INSERT')) THEN

		CALC_DATE_TIME = rg_calc_period('bank_flow'::reg_types);

		IF (CALC_DATE_TIME IS NULL) OR (NEW.date_time::date > rg_period_balance('bank_flow'::reg_types, CALC_DATE_TIME)) THEN
			CALC_DATE_TIME = rg_period('bank_flow'::reg_types, NEW.date_time);
			PERFORM rg_bank_flow_set_custom_period(CALC_DATE_TIME);						
		END IF;
raise exception 'AFTER=%', CALC_DATE_TIME;		
		IF TG_OP='UPDATE' THEN
			v_delta_total = OLD.total;
			
		ELSE
			v_delta_total = 0;
								
		END IF;
		v_delta_total = NEW.total - v_delta_total;
		
		IF NOT NEW.deb THEN
			v_delta_total = -1 * v_delta_total;
								
		END IF;
		
		v_loop_rg_period = CALC_DATE_TIME;
		v_calc_interval = rg_calc_interval('bank_flow'::reg_types);
		LOOP
			UPDATE rg_bank_flow
			SET
			total = total + v_delta_total
			WHERE 
				date_time=v_loop_rg_period
				
				AND bank_account_id = NEW.bank_account_id;
			IF NOT FOUND THEN
				BEGIN
					INSERT INTO rg_bank_flow (date_time
					
					,bank_account_id
					,total)				
					VALUES (v_loop_rg_period
					
					,NEW.bank_account_id
					,v_delta_total);
				EXCEPTION WHEN OTHERS THEN
					UPDATE rg_bank_flow
					SET
					total = total + v_delta_total
					WHERE date_time = v_loop_rg_period
					
					AND bank_account_id = NEW.bank_account_id;
				END;
			END IF;

			v_loop_rg_period = v_loop_rg_period + v_calc_interval;
			IF v_loop_rg_period > CALC_DATE_TIME THEN
				EXIT;  -- exit loop
			END IF;
		END LOOP;

		--Current balance
		CURRENT_BALANCE_DATE_TIME = reg_current_balance_time();
		UPDATE rg_bank_flow
		SET
		total = total + v_delta_total
		WHERE 
			date_time=CURRENT_BALANCE_DATE_TIME
			
			AND bank_account_id = NEW.bank_account_id;
		IF NOT FOUND THEN
			BEGIN
				INSERT INTO rg_bank_flow (date_time
				
				,bank_account_id
				,total)				
				VALUES (CURRENT_BALANCE_DATE_TIME
				
				,NEW.bank_account_id
				,v_delta_total);
			EXCEPTION WHEN OTHERS THEN
				UPDATE rg_bank_flow
				SET
				total = total + v_delta_total
				WHERE 
					date_time=CURRENT_BALANCE_DATE_TIME
					
					AND bank_account_id = NEW.bank_account_id;
			END;
		END IF;
		
		RETURN NEW;					
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='DELETE') THEN
		RETURN OLD;
	ELSIF (TG_WHEN='AFTER' AND TG_OP='DELETE') THEN
		
		CALC_DATE_TIME = rg_calc_period('bank_flow'::reg_types);

		IF (CALC_DATE_TIME IS NULL) OR (OLD.date_time::date > rg_period_balance('bank_flow'::reg_types, CALC_DATE_TIME)) THEN
			CALC_DATE_TIME = rg_period('bank_flow'::reg_types,OLD.date_time);
			PERFORM rg_bank_flow_set_custom_period(CALC_DATE_TIME);						
		END IF;
		
		v_delta_total = OLD.total;
							
		IF OLD.deb THEN
			v_delta_total = -1*v_delta_total;					
			
		END IF;
		
		
		PERFORM rg_bank_flow_update_periods(OLD.date_time
		
		,bank_account_id
		,v_delta_total);
		
		RETURN OLD;					
	END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;

ALTER FUNCTION ra_bank_flow_process() OWNER TO glab;



-- ******************* update 27/04/2024 07:01:49 ******************
--********** Calc interval for a reginster ***************************************** 
CREATE OR REPLACE FUNCTION rg_calc_interval(in_reg_type reg_types)
  RETURNS interval AS
$BODY$
	SELECT
		CASE $1
						
		WHEN 'cash_flow'::reg_types THEN '1 month'::interval
		WHEN 'bank_flow'::reg_types THEN '1 month'::interval
		ELSE '1 month'::interval
		
		END;
$BODY$
  LANGUAGE sql IMMUTABLE COST 100;
ALTER FUNCTION rg_calc_interval(reg_types) OWNER TO glab;



-- ******************* update 27/04/2024 07:02:25 ******************
--process function
CREATE OR REPLACE FUNCTION ra_bank_flow_process()
  RETURNS trigger AS
$BODY$
DECLARE
	v_delta_total  numeric(15,2) DEFAULT 0;
	
	CALC_DATE_TIME timestamp;
	CURRENT_BALANCE_DATE_TIME timestamp;
	v_loop_rg_period timestamp;
	v_calc_interval interval;			  			
BEGIN
	IF (TG_WHEN='BEFORE' AND TG_OP='INSERT') THEN
		RETURN NEW;
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='UPDATE') THEN
		RETURN NEW;
	ELSIF (TG_WHEN='AFTER' AND (TG_OP='UPDATE' OR TG_OP='INSERT')) THEN

		CALC_DATE_TIME = rg_calc_period('bank_flow'::reg_types);

		IF (CALC_DATE_TIME IS NULL) OR (NEW.date_time::date > rg_period_balance('bank_flow'::reg_types, CALC_DATE_TIME)) THEN
			CALC_DATE_TIME = rg_period('bank_flow'::reg_types, NEW.date_time);
			PERFORM rg_bank_flow_set_custom_period(CALC_DATE_TIME);						
		END IF;

		IF TG_OP='UPDATE' THEN
			v_delta_total = OLD.total;
			
		ELSE
			v_delta_total = 0;
								
		END IF;
		v_delta_total = NEW.total - v_delta_total;
		
		IF NOT NEW.deb THEN
			v_delta_total = -1 * v_delta_total;
								
		END IF;
		
		v_loop_rg_period = CALC_DATE_TIME;
		v_calc_interval = rg_calc_interval('bank_flow'::reg_types);
		LOOP
			UPDATE rg_bank_flow
			SET
			total = total + v_delta_total
			WHERE 
				date_time=v_loop_rg_period
				
				AND bank_account_id = NEW.bank_account_id;
			IF NOT FOUND THEN
				BEGIN
					INSERT INTO rg_bank_flow (date_time
					
					,bank_account_id
					,total)				
					VALUES (v_loop_rg_period
					
					,NEW.bank_account_id
					,v_delta_total);
				EXCEPTION WHEN OTHERS THEN
					UPDATE rg_bank_flow
					SET
					total = total + v_delta_total
					WHERE date_time = v_loop_rg_period
					
					AND bank_account_id = NEW.bank_account_id;
				END;
			END IF;

			v_loop_rg_period = v_loop_rg_period + v_calc_interval;
			IF v_loop_rg_period > CALC_DATE_TIME THEN
				EXIT;  -- exit loop
			END IF;
		END LOOP;

		--Current balance
		CURRENT_BALANCE_DATE_TIME = reg_current_balance_time();
		UPDATE rg_bank_flow
		SET
		total = total + v_delta_total
		WHERE 
			date_time=CURRENT_BALANCE_DATE_TIME
			
			AND bank_account_id = NEW.bank_account_id;
		IF NOT FOUND THEN
			BEGIN
				INSERT INTO rg_bank_flow (date_time
				
				,bank_account_id
				,total)				
				VALUES (CURRENT_BALANCE_DATE_TIME
				
				,NEW.bank_account_id
				,v_delta_total);
			EXCEPTION WHEN OTHERS THEN
				UPDATE rg_bank_flow
				SET
				total = total + v_delta_total
				WHERE 
					date_time=CURRENT_BALANCE_DATE_TIME
					
					AND bank_account_id = NEW.bank_account_id;
			END;
		END IF;
		
		RETURN NEW;					
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='DELETE') THEN
		RETURN OLD;
	ELSIF (TG_WHEN='AFTER' AND TG_OP='DELETE') THEN
		
		CALC_DATE_TIME = rg_calc_period('bank_flow'::reg_types);

		IF (CALC_DATE_TIME IS NULL) OR (OLD.date_time::date > rg_period_balance('bank_flow'::reg_types, CALC_DATE_TIME)) THEN
			CALC_DATE_TIME = rg_period('bank_flow'::reg_types,OLD.date_time);
			PERFORM rg_bank_flow_set_custom_period(CALC_DATE_TIME);						
		END IF;
		
		v_delta_total = OLD.total;
							
		IF OLD.deb THEN
			v_delta_total = -1*v_delta_total;					
			
		END IF;
		
		
		PERFORM rg_bank_flow_update_periods(OLD.date_time
		
		,bank_account_id
		,v_delta_total);
		
		RETURN OLD;					
	END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;

ALTER FUNCTION ra_bank_flow_process() OWNER TO glab;



-- ******************* update 27/04/2024 07:16:18 ******************

-- Function: public.cash_flow_balance_list(in_date date)

-- DROP FUNCTION public.cash_flow_balance_list(in_date date);

CREATE OR REPLACE FUNCTION public.cash_flow_balance_list(in_date date)
  RETURNS TABLE(
  	d date,
	cash_location_id int,
	cash_location_descr text,
	total_bal_start numeric(15, 2),
	total_kred numeric(15, 2),
	total_kred_out numeric(15, 2),
	fin_expense_types json,
	total_transfer_out numeric(15, 2),

	total_deb numeric(15, 2),
	total_deb_in numeric(15, 2),
	total_transfer_in numeric(15, 2),
	total_bal_end numeric(15, 2)  
  ) AS
$BODY$
	WITH
	per as (select ((in_date::date-'1 day'::interval) + '23:59:59.999999'::time)::timestamp as d1,
		(in_date::date + '23:59:59'::time)::timestamp as d2)
	
	SELECT
			dates.d::date as d,
			loc.id as cash_location_id,
			loc.name as cash_location_descr,
			coalesce(rg_beg.total, 0) as total_bal_start,
			coalesce(ra_kred.total, 0) as total_kred,
			coalesce(ra_kred.total_out, 0) as total_kred_out,
			ra_kred.fin_expense_types,
			coalesce(ra_kred.total_transfer, 0) as total_transfer_out,

			coalesce(ra_deb.total, 0) as total_deb,
			coalesce(ra_deb.total_in, 0) as total_deb_in,
			coalesce(ra_deb.total_transfer, 0) as total_transfer_in,

			coalesce(rg_beg.total, 0) as total_bal_end
			--coalesce(rg_beg.total, 0) + sum(coalesce(ra_deb.total,0) - coalesce(ra_kred.total,0)) OVER (ORDER BY dates.d,loc.name) total_bal_end
		
	FROM
		generate_series((SELECT d1 FROM per), (SELECT d2 FROM per), '24 hours') as dates (d)
	CROSS JOIN (
			SELECT
				id, name
			FROM cash_locations
			ORDER BY name
	) as loc
	LEFT JOIN (
		SELECT
			rg.cash_location_id,
			rg.total
		FROM
			rg_cash_flow_balance((select d1 from per), '{}') as rg
	) AS rg_beg on rg_beg.cash_location_id = loc.id
	LEFT JOIN (
		SELECT
			rg.cash_location_id,
			rg.total
		FROM
			rg_cash_flow_balance((select d2 from per), '{}') as rg
	) AS rg_end on rg_end.cash_location_id = loc.id
		
	LEFT JOIN (
		SELECT
			ra.date_time::date AS d,
			ra.cash_location_id,
			json_agg(
				json_build_object(
					'expense_type', fe.name,
					'total', c_out.total
				)
			) AS fin_expense_types,

			sum(c_out.total) as total_out,
			sum(c_tr.total) as total_transfer,
			sum(ra.total) as total
		FROM
			ra_cash_flow as ra	
		LEFT JOIN cash_flow_out as c_out on ra.doc_type = 'cash_flow_out' and c_out.id = ra.doc_id
		LEFT JOIN cash_flow_transfers as c_tr on ra.doc_type = 'cash_flow_transfers' and c_tr.id = ra.doc_id
		LEFT JOIN fin_expense_types as fe on fe.id = c_out.fin_expense_type1_id
		WHERE
			ra.deb = FALSE
		 	and ra.date_time BETWEEN (SELECT d1 FROM per) AND (SELECT d2 FROM per)
		GROUP BY
			ra.cash_location_id,
			ra.date_time::date,
			fe.name
		ORDER BY ra.date_time::date, fe.name
	) AS ra_kred on ra_kred.cash_location_id = loc.id AND ra_kred.d = dates.d::date
	LEFT JOIN (
		SELECT
			ra.date_time::date AS d,
			ra.cash_location_id,
			sum(c_in.total) as total_in,
			sum(c_tr.total) as total_transfer,
			sum(ra.total) as total
		FROM
			ra_cash_flow as ra	
		LEFT JOIN cash_flow_in as c_in on ra.doc_type = 'cash_flow_in' and c_in.id = ra.doc_id
		LEFT JOIN cash_flow_transfers as c_tr on ra.doc_type = 'cash_flow_transfers' and c_tr.id = ra.doc_id
		WHERE
			ra.deb = TRUE
			and ra.date_time BETWEEN (SELECT d1 FROM per) AND (SELECT d2 FROM per)
		GROUP BY
			ra.cash_location_id,
			ra.date_time::date
			
	) AS ra_deb on ra_deb.cash_location_id = loc.id AND ra_deb.d = dates.d::date
	;

$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION public.cash_flow_balance_list(in_date date)
  OWNER TO glab;



-- ******************* update 08/05/2024 14:52:22 ******************
	
		ALTER TABLE public.fin_expense_types ADD COLUMN for_cash bool,ADD COLUMN for_bank bool;



-- ******************* update 08/05/2024 15:01:07 ******************

	
	-- ********** Adding new table from model **********
	CREATE TABLE public.fin_expense_type_match_rules
	(id serial NOT NULL,fin_expense_type_id int NOT NULL REFERENCES fin_expense_types(id),rule text,CONSTRAINT fin_expense_type_match_rules_pkey PRIMARY KEY (id)
	);
	
	DROP INDEX IF EXISTS expense_type_match_rules_rule_idx;
	CREATE INDEX expense_type_match_rules_rule_idx
	ON fin_expense_type_match_rules(fin_expense_type_id);

	ALTER TABLE public.fin_expense_type_match_rules OWNER TO glab;
	



-- ******************* update 08/05/2024 15:05:09 ******************
/**
 * Andrey Mikhalevich 15/12/21
 * This file is part of the OSBE framework
 *
 * THIS FILE IS GENERATED FROM TEMPLATE build/templates/permissions/permissions.sql.tmpl
 * ALL DIRECT MODIFICATIONS WILL BE LOST WITH THE NEXT BUILD PROCESS!!!
 */

/*
-- If this is the first time you execute the script, uncomment these lines
-- to create table and insert row
CREATE TABLE IF NOT EXISTS permissions (
    rules json NOT NULL
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.permissions OWNER TO glab;

INSERT INTO permissions VALUES ('{"admin":{}}');
*/

UPDATE permissions SET rules = '{
	"admin":{
		"Event":{
			"subscribe":true
			,"unsubscribe":true
			,"publish":true
		}
		,"Constant":{
			"set_value":true
			,"get_list":true
			,"get_object":true
			,"get_values":true
		}
		,"Enum":{
			"get_enum_list":true
		}
		,"MainMenuConstructor":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MainMenuContent":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"View":{
			"get_list":true
			,"complete":true
			,"get_section_list":true
		}
		,"VariantStorage":{
			"insert":true
			,"upsert_filter_data":true
			,"upsert_col_visib_data":true
			,"upsert_col_order_data":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_filter_data":true
			,"get_col_visib_data":true
			,"get_col_order_data":true
		}
		,"About":{
			"get_object":true
		}
		,"Service":{
			"reload_config":true
			,"reload_version":true
		}
		,"User":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
			,"get_profile":true
			,"reset_pwd":true
			,"login":true
			,"login_refresh":true
			,"logout":true
			,"logout_html":true
			,"download_photo":true
			,"delete_photo":true
			,"password_recover":true
		}
		,"Login":{
			"get_list":true
			,"get_object":true
			,"logout":true
		}
		,"LoginDevice":{
			"get_list":true
			,"switch_banned":true
		}
		,"Captcha":{
			"get":true
		}
		,"LoginDeviceBan":{
			"insert":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"TimeZoneLocale":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Department":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Post":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Contact":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
			,"upsert":true
		}
		,"EntityContact":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ObjectModLog":{
			"get_list":true
			,"get_object":true
		}
		,"MailMessage":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MailMessageAttachment":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MailTemplate":{
			"insert":true
			,"update":true
			,"get_list":true
			,"get_object":true
		}
		,"Attachment":{
			"get_list":true
			,"get_object":true
			,"delete_file":true
			,"get_file":true
			,"add_file":true
		}
		,"AutoMake":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"AutoModel":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_make":true
			,"get_all_years":true
		}
		,"AutoModelGeneration":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_model":true
			,"gen_next_id":true
		}
		,"AutoType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"AutoBodyType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoBodyDoor":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoBody":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_model_generation":true
			,"complete_for_model":true
		}
		,"ItemFolder":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemFeature":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemFeatureValueList":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItemFeatureValueList":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFeatureGroupItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFolderFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItemFolderFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Item":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_item":true
			,"complete":true
			,"set_feature":true
			,"get_features_filter_list":true
		}
		,"Manufacturer":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ManufacturerBrand":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Supplier":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"VehicleType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemPriority":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"PopularityType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"import":true
			,"set_feature":true
			,"get_features_filter_list":true
		}
		,"ItemSearch":{
			"get_object":true
			,"find_items":true
		}
		,"ImportItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierStore":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_supplier":true
		}
		,"SupplierStoreValue":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoPriceCategory":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoToGlassMatchHead":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoToGlassMatchEurocode":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_body_list":true
		}
		,"AutoToGlassMatchOption":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_conf_form":true
		}
		,"AutoModelGenerationBody":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"BankCard":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Employee":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"EmployeeStatus":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"PersonDocument":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"PersonDocumentType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"CashLocation":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"FinExpenseType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"CashFlowIn":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_cash_flow_balance_list":true
		}
		,"CashFlowOut":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"CashFlowTransfer":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Firm":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Bank":{
			"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"BankAccount":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"BankFlowIn":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"BankFlowOut":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"FinExpenseTypeMathchRule":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
	}
	,"guest":{
		"User":{
			"login":true
		}
	}
}';


-- ******************* update 08/05/2024 15:07:08 ******************
-- VIEW: public.fin_expense_types_list

--DROP VIEW public.fin_expense_types_list;

CREATE OR REPLACE VIEW public.fin_expense_types_list AS
	SELECT
		t.id
		,t.parent_id
		,t.name
		,t.deleted
		,t.for_cash
		,t.for_bank
	FROM public.fin_expense_types AS t
	
	ORDER BY name ASC
	;
	
ALTER VIEW public.fin_expense_types_list OWNER TO glab;


-- ******************* update 13/05/2024 08:22:06 ******************
	
		ALTER TABLE public.fin_expense_types ADD COLUMN bank_match_rule text;



-- ******************* update 13/05/2024 08:24:07 ******************
-- VIEW: public.fin_expense_types_dialog

--DROP VIEW public.fin_expense_types_dialog;

CREATE OR REPLACE VIEW public.fin_expense_types_dialog AS
	SELECT
		t.id
		,fin_expense_types_ref(p) AS parents_ref
		,t.name
		,t.for_cash
		,t.for_bank
		,t.bank_match_rule
		,t.deleted
	FROM public.fin_expense_types AS t
	LEFT JOIN fin_expense_types AS p ON p.id = t.parent_id
	;
	
ALTER VIEW public.fin_expense_types_dialog OWNER TO glab;


-- ******************* update 13/05/2024 11:25:05 ******************
alter table fin_expense_types alter column for_bank set default false;


-- ******************* update 13/05/2024 11:25:13 ******************
alter table fin_expense_types alter column for_cash set default false;


-- ******************* update 13/05/2024 11:25:18 ******************
alter table fin_expense_types alter column deleted set default false;


-- ******************* update 14/05/2024 12:21:13 ******************
--process function
CREATE OR REPLACE FUNCTION ra_bank_flow_process()
  RETURNS trigger AS
$BODY$
DECLARE
	v_delta_total  numeric(15,2) DEFAULT 0;
	
	CALC_DATE_TIME timestamp;
	CURRENT_BALANCE_DATE_TIME timestamp;
	v_loop_rg_period timestamp;
	v_calc_interval interval;			  			
BEGIN
	IF (TG_WHEN='BEFORE' AND TG_OP='INSERT') THEN
		RETURN NEW;
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='UPDATE') THEN
		RETURN NEW;
	ELSIF (TG_WHEN='AFTER' AND (TG_OP='UPDATE' OR TG_OP='INSERT')) THEN

		CALC_DATE_TIME = rg_calc_period('bank_flow'::reg_types);

		IF (CALC_DATE_TIME IS NULL) OR (NEW.date_time::date > rg_period_balance('bank_flow'::reg_types, CALC_DATE_TIME)) THEN
			CALC_DATE_TIME = rg_period('bank_flow'::reg_types, NEW.date_time);
			PERFORM rg_bank_flow_set_custom_period(CALC_DATE_TIME);						
		END IF;

		IF TG_OP='UPDATE' THEN
			v_delta_total = OLD.total;
			
		ELSE
			v_delta_total = 0;
								
		END IF;
		v_delta_total = NEW.total - v_delta_total;
		
		IF NOT NEW.deb THEN
			v_delta_total = -1 * v_delta_total;
								
		END IF;
		
		v_loop_rg_period = CALC_DATE_TIME;
		v_calc_interval = rg_calc_interval('bank_flow'::reg_types);
		LOOP
			UPDATE rg_bank_flow
			SET
			total = total + v_delta_total
			WHERE 
				date_time=v_loop_rg_period
				
				AND bank_account_id = NEW.bank_account_id;
			IF NOT FOUND THEN
				BEGIN
					INSERT INTO rg_bank_flow (date_time
					
					,bank_account_id
					,total)				
					VALUES (v_loop_rg_period
					
					,NEW.bank_account_id
					,v_delta_total);
				EXCEPTION WHEN OTHERS THEN
					UPDATE rg_bank_flow
					SET
					total = total + v_delta_total
					WHERE date_time = v_loop_rg_period
					
					AND bank_account_id = NEW.bank_account_id;
				END;
			END IF;

			v_loop_rg_period = v_loop_rg_period + v_calc_interval;
			IF v_loop_rg_period > CALC_DATE_TIME THEN
				EXIT;  -- exit loop
			END IF;
		END LOOP;

		--Current balance
		CURRENT_BALANCE_DATE_TIME = reg_current_balance_time();
		UPDATE rg_bank_flow
		SET
		total = total + v_delta_total
		WHERE 
			date_time=CURRENT_BALANCE_DATE_TIME
			
			AND bank_account_id = NEW.bank_account_id;
		IF NOT FOUND THEN
			BEGIN
				INSERT INTO rg_bank_flow (date_time
				
				,bank_account_id
				,total)				
				VALUES (CURRENT_BALANCE_DATE_TIME
				
				,NEW.bank_account_id
				,v_delta_total);
			EXCEPTION WHEN OTHERS THEN
				UPDATE rg_bank_flow
				SET
				total = total + v_delta_total
				WHERE 
					date_time=CURRENT_BALANCE_DATE_TIME
					
					AND bank_account_id = NEW.bank_account_id;
			END;
		END IF;
		
		RETURN NEW;					
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='DELETE') THEN
		RETURN OLD;
	ELSIF (TG_WHEN='AFTER' AND TG_OP='DELETE') THEN
		
		CALC_DATE_TIME = rg_calc_period('bank_flow'::reg_types);

		IF (CALC_DATE_TIME IS NULL) OR (OLD.date_time::date > rg_period_balance('bank_flow'::reg_types, CALC_DATE_TIME)) THEN
			CALC_DATE_TIME = rg_period('bank_flow'::reg_types,OLD.date_time);
			PERFORM rg_bank_flow_set_custom_period(CALC_DATE_TIME);						
		END IF;
		
		v_delta_total = OLD.total;
							
		IF OLD.deb THEN
			v_delta_total = -1*v_delta_total;					
			
		END IF;
		
		
		PERFORM rg_bank_flow_update_periods(OLD.date_time
		
		,OLD.bank_account_id
		,v_delta_total);
		
		RETURN OLD;					
	END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;

ALTER FUNCTION ra_bank_flow_process() OWNER TO glab;



-- ******************* update 14/05/2024 12:23:39 ******************
-- FUNCTION: public.rg_bank_flow_update_periods(timestamp without time zone, integer, numeric)

-- DROP FUNCTION IF EXISTS public.rg_bank_flow_update_periods(timestamp without time zone, integer, numeric);

CREATE OR REPLACE FUNCTION public.rg_bank_flow_update_periods(
	in_date_time timestamp without time zone,
	in_bank_account_id integer,
	in_delta_total numeric)
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
	v_loop_rg_period timestamp;
	v_calc_interval interval;			  			
	CURRENT_BALANCE_DATE_TIME timestamp;
	CALC_DATE_TIME timestamp;
BEGIN
	CALC_DATE_TIME = rg_calc_period('bank_flow'::reg_types);
	v_loop_rg_period = rg_period('bank_flow'::reg_types,in_date_time);
	v_calc_interval = rg_calc_interval('bank_flow'::reg_types);
	LOOP
		UPDATE rg_bank_flow
		SET
			total = total + in_delta_total
		WHERE 
			date_time=v_loop_rg_period
			AND bank_account_id = in_bank_account_id;
			
		IF NOT FOUND THEN
			BEGIN
				INSERT INTO rg_bank_flow (date_time
				,bank_account_id
				,total)				
				VALUES (v_loop_rg_period
				,in_bank_account_id
				,in_delta_total);
			EXCEPTION WHEN OTHERS THEN
				UPDATE rg_bank_flow
				SET
					total = total + in_delta_total
				WHERE date_time = v_loop_rg_period
				AND bank_account_id = in_bank_account_id;
			END;
		END IF;
		v_loop_rg_period = v_loop_rg_period + v_calc_interval;
		IF v_loop_rg_period > CALC_DATE_TIME THEN
			EXIT;  -- exit loop
		END IF;
	END LOOP;
	
	--Current balance
	CURRENT_BALANCE_DATE_TIME = reg_current_balance_time();
	UPDATE rg_bank_flow
	SET
		total = total + in_delta_total
	WHERE 
		date_time=CURRENT_BALANCE_DATE_TIME
		AND bank_account_id = in_bank_account_id;
		
	IF NOT FOUND THEN
		BEGIN
			INSERT INTO rg_bank_flow (date_time
			,bank_account_id
			,total)				
			VALUES (CURRENT_BALANCE_DATE_TIME
			,in_bank_account_id
			,in_delta_total);
		EXCEPTION WHEN OTHERS THEN
			UPDATE rg_bank_flow
			SET
				total = total + in_delta_total
			WHERE 
				date_time=CURRENT_BALANCE_DATE_TIME
				AND bank_account_id = in_bank_account_id;
		END;
	END IF;					
	
END;
$BODY$;

ALTER FUNCTION public.rg_bank_flow_update_periods(timestamp without time zone, integer, numeric)
    OWNER TO glab;



-- ******************* update 21/05/2024 11:09:32 ******************
-- Function: user_operations_process()

-- DROP FUNCTION user_operations_process();

CREATE OR REPLACE FUNCTION user_operations_process()
  RETURNS trigger AS
$BODY$
BEGIN

	IF TG_OP='UPDATE' AND (
		 (coalesce(OLD.status,'')<>'end' AND coalesce(NEW.status,'')='end')
		 OR NEW.status='progress'
	)
	THEN		
		--md5(NEW.user_id::text||
		PERFORM pg_notify(
			'UserOperation.'||NEW.operation_id
			,json_build_object(
				'params',json_build_object(
					'status', NEW.status,
					'res', coalesce(NEW.error_text,'')='',
					'operation_id', NEW.operation_id
				)
			)::text
		);
	END IF;
	
	RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION user_operations_process()
  OWNER TO glab;



-- ******************* update 21/05/2024 11:09:38 ******************
-- Trigger: user_operations_trigger_after on public.user_operations

-- DROP TRIGGER user_operations_trigger_after ON public.user_operations;


CREATE TRIGGER user_operations_trigger_after
  AFTER UPDATE
  ON public.user_operations
  FOR EACH ROW
  EXECUTE PROCEDURE public.user_operations_process();



-- ******************* update 21/05/2024 13:43:13 ******************
-- Function: user_operations_process()

-- DROP FUNCTION user_operations_process();

CREATE OR REPLACE FUNCTION user_operations_process()
  RETURNS trigger AS
$BODY$
BEGIN

	IF TG_OP='UPDATE' AND (
		 (coalesce(OLD.status,'')<>'end' AND coalesce(NEW.status,'')='end')
		 OR NEW.status='progress'
	)
	THEN		
		--md5(NEW.user_id::text||
		PERFORM pg_notify(
			'UserOperation.'||NEW.operation_id
			,json_build_object(
				'params',json_build_object(
					'status', NEW.status,
					'res', coalesce(NEW.error_text,'')='',
					'operation_id', NEW.operation_id
				)
			)::text
		);
	END IF;
	
	RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION user_operations_process()
  OWNER TO glab;



-- ******************* update 24/05/2024 08:01:47 ******************
	
		ALTER TABLE public.fin_expense_types ADD COLUMN bank_match_rule_cond text;



-- ******************* update 24/05/2024 08:59:00 ******************
/**
 * Andrey Mikhalevich 15/12/21
 * This file is part of the OSBE framework
 *
 * THIS FILE IS GENERATED FROM TEMPLATE build/templates/permissions/permissions.sql.tmpl
 * ALL DIRECT MODIFICATIONS WILL BE LOST WITH THE NEXT BUILD PROCESS!!!
 */

/*
-- If this is the first time you execute the script, uncomment these lines
-- to create table and insert row
CREATE TABLE IF NOT EXISTS permissions (
    rules json NOT NULL
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.permissions OWNER TO glab;

INSERT INTO permissions VALUES ('{"admin":{}}');
*/

UPDATE permissions SET rules = '{
	"admin":{
		"Event":{
			"subscribe":true
			,"unsubscribe":true
			,"publish":true
		}
		,"Constant":{
			"set_value":true
			,"get_list":true
			,"get_object":true
			,"get_values":true
		}
		,"Enum":{
			"get_enum_list":true
		}
		,"MainMenuConstructor":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MainMenuContent":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"View":{
			"get_list":true
			,"complete":true
			,"get_section_list":true
		}
		,"VariantStorage":{
			"insert":true
			,"upsert_filter_data":true
			,"upsert_col_visib_data":true
			,"upsert_col_order_data":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_filter_data":true
			,"get_col_visib_data":true
			,"get_col_order_data":true
		}
		,"About":{
			"get_object":true
		}
		,"Service":{
			"reload_config":true
			,"reload_version":true
		}
		,"User":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
			,"get_profile":true
			,"reset_pwd":true
			,"login":true
			,"login_refresh":true
			,"logout":true
			,"logout_html":true
			,"download_photo":true
			,"delete_photo":true
			,"password_recover":true
		}
		,"Login":{
			"get_list":true
			,"get_object":true
			,"logout":true
		}
		,"LoginDevice":{
			"get_list":true
			,"switch_banned":true
		}
		,"Captcha":{
			"get":true
		}
		,"LoginDeviceBan":{
			"insert":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"TimeZoneLocale":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Department":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Post":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Contact":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
			,"upsert":true
		}
		,"EntityContact":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ObjectModLog":{
			"get_list":true
			,"get_object":true
		}
		,"MailMessage":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MailMessageAttachment":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MailTemplate":{
			"insert":true
			,"update":true
			,"get_list":true
			,"get_object":true
		}
		,"Attachment":{
			"get_list":true
			,"get_object":true
			,"delete_file":true
			,"get_file":true
			,"add_file":true
		}
		,"AutoMake":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"AutoModel":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_make":true
			,"get_all_years":true
		}
		,"AutoModelGeneration":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_model":true
			,"gen_next_id":true
		}
		,"AutoType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"AutoBodyType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoBodyDoor":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoBody":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_model_generation":true
			,"complete_for_model":true
		}
		,"ItemFolder":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemFeature":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemFeatureValueList":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItemFeatureValueList":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFeatureGroupItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFolderFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItemFolderFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Item":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_item":true
			,"complete":true
			,"set_feature":true
			,"get_features_filter_list":true
		}
		,"Manufacturer":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ManufacturerBrand":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Supplier":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"VehicleType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemPriority":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"PopularityType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"import":true
			,"set_feature":true
			,"get_features_filter_list":true
		}
		,"ItemSearch":{
			"get_object":true
			,"find_items":true
		}
		,"ImportItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierStore":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_supplier":true
		}
		,"SupplierStoreValue":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoPriceCategory":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoToGlassMatchHead":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoToGlassMatchEurocode":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_body_list":true
		}
		,"AutoToGlassMatchOption":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_conf_form":true
		}
		,"AutoModelGenerationBody":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"BankCard":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Employee":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"EmployeeStatus":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"PersonDocument":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"PersonDocumentType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"CashLocation":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"FinExpenseType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
			,"verify_rule":true
		}
		,"CashFlowIn":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_cash_flow_balance_list":true
		}
		,"CashFlowOut":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"CashFlowTransfer":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Firm":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Bank":{
			"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"BankAccount":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"BankFlowIn":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"import_from_bank":true
		}
		,"BankFlowOut":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"UserOperation":{
			"get_object":true
			,"delete":true
		}
	}
	,"guest":{
		"User":{
			"login":true
		}
	}
}';


-- ******************* update 24/05/2024 10:15:44 ******************
﻿-- Function: bank_flow_out_find_expense_type(in_pay_comment text)

-- DROP FUNCTION bank_flow_out_find_expense_type(in_pay_comment text);

CREATE OR REPLACE FUNCTION bank_flow_out_find_expense_type(in_pay_comment text)
  RETURNS record AS
$BODY$
DECLARE
	exp_cursor CURSOR FOR
	        SELECT
	        	id,
	        	parent_id,
	        	bank_match_rule_cond
	        FROM fin_expense_types
	        WHERE bank_match_rule_cond IS NOT NULL;
	exp_row RECORD;
	is_match bool;
BEGIN

	OPEN exp_cursor;

	LOOP
		FETCH exp_cursor INTO exp_row;
		EXECUTE 'SELECT '||REPLACE(exp_row.bank_match_rule_cond, 'БАНК_КОММЕНТ', in_pay_comment) INTO is_match;
		IF is_match THEN
			CLOSE exp_cursor;
			RETURN exp_row;	
		END IF;
	END LOOP;
	
	CLOSE exp_cursor;
	RETURN NULL;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION bank_flow_out_find_expense_type(in_pay_comment text) OWNER TO glab;


-- ******************* update 24/05/2024 10:17:25 ******************
﻿-- Function: bank_flow_out_find_expense_type(in_pay_comment text)

-- DROP FUNCTION bank_flow_out_find_expense_type(in_pay_comment text);

CREATE OR REPLACE FUNCTION bank_flow_out_find_expense_type(in_pay_comment text)
  RETURNS record AS
$BODY$
DECLARE
	exp_cursor CURSOR FOR
	        SELECT
	        	id,
	        	parent_id,
	        	bank_match_rule_cond
	        FROM fin_expense_types
	        WHERE bank_match_rule_cond IS NOT NULL;
	exp_row RECORD;
	is_match bool;
BEGIN

	OPEN exp_cursor;

	LOOP
		FETCH exp_cursor INTO exp_row;
		raise notice 'exp_row.bank_match_rule_cond=%', exp_row.bank_match_rule_cond;
		
		EXECUTE 'SELECT '||REPLACE(exp_row.bank_match_rule_cond, 'БАНК_КОММЕНТ', in_pay_comment) INTO is_match;
		IF is_match THEN
			CLOSE exp_cursor;
			RETURN exp_row;	
		END IF;
	END LOOP;
	
	CLOSE exp_cursor;
	RETURN NULL;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION bank_flow_out_find_expense_type(in_pay_comment text) OWNER TO glab;


-- ******************* update 24/05/2024 10:17:56 ******************
﻿-- Function: bank_flow_out_find_expense_type(in_pay_comment text)

-- DROP FUNCTION bank_flow_out_find_expense_type(in_pay_comment text);

CREATE OR REPLACE FUNCTION bank_flow_out_find_expense_type(in_pay_comment text)
  RETURNS record AS
$BODY$
DECLARE
	exp_cursor CURSOR FOR
	        SELECT
	        	id,
	        	parent_id,
	        	bank_match_rule_cond
	        FROM fin_expense_types
	        WHERE coalesce(bank_match_rule_cond,'') <> '';
	exp_row RECORD;
	is_match bool;
BEGIN

	OPEN exp_cursor;

	LOOP
		FETCH exp_cursor INTO exp_row;
		raise notice 'exp_row.bank_match_rule_cond=%', exp_row.bank_match_rule_cond;
		
		EXECUTE 'SELECT '||REPLACE(exp_row.bank_match_rule_cond, 'БАНК_КОММЕНТ', in_pay_comment) INTO is_match;
		IF is_match THEN
			CLOSE exp_cursor;
			RETURN exp_row;	
		END IF;
	END LOOP;
	
	CLOSE exp_cursor;
	RETURN NULL;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION bank_flow_out_find_expense_type(in_pay_comment text) OWNER TO glab;


-- ******************* update 24/05/2024 10:19:13 ******************
﻿-- Function: bank_flow_out_find_expense_type(in_pay_comment text)

-- DROP FUNCTION bank_flow_out_find_expense_type(in_pay_comment text);

CREATE OR REPLACE FUNCTION bank_flow_out_find_expense_type(in_pay_comment text)
  RETURNS record AS
$BODY$
DECLARE
	exp_cursor CURSOR FOR
	        SELECT
	        	id,
	        	parent_id,
	        	bank_match_rule_cond
	        FROM fin_expense_types
	        WHERE coalesce(bank_match_rule_cond,'') <> '';
	exp_row RECORD;
	is_match bool;
BEGIN

	OPEN exp_cursor;

	LOOP
		FETCH exp_cursor INTO exp_row;
		raise notice 'SELECT %', REPLACE(exp_row.bank_match_rule_cond, 'БАНК_КОММЕНТ', in_pay_comment);
		
		EXECUTE 'SELECT '||REPLACE(exp_row.bank_match_rule_cond, 'БАНК_КОММЕНТ', in_pay_comment) INTO is_match;
		IF is_match THEN
			CLOSE exp_cursor;
			RETURN exp_row;	
		END IF;
	END LOOP;
	
	CLOSE exp_cursor;
	RETURN NULL;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION bank_flow_out_find_expense_type(in_pay_comment text) OWNER TO glab;


-- ******************* update 24/05/2024 10:22:13 ******************
﻿-- Function: bank_flow_out_find_expense_type(in_pay_comment text)

-- DROP FUNCTION bank_flow_out_find_expense_type(in_pay_comment text);

CREATE OR REPLACE FUNCTION bank_flow_out_find_expense_type(in_pay_comment text)
  RETURNS record AS
$BODY$
DECLARE
	exp_cursor CURSOR FOR
	        SELECT
	        	id,
	        	parent_id,
	        	bank_match_rule_cond
	        FROM fin_expense_types
	        WHERE coalesce(bank_match_rule_cond,'') <> '';
	exp_row RECORD;
	txt text;
	is_match bool;
BEGIN

	OPEN exp_cursor;

	LOOP
		FETCH exp_cursor INTO exp_row;
		txt := REPLACE(exp_row.bank_match_rule_cond, 'БАНК_КОММЕНТ', in_pay_comment);
		IF exp_row.bank_match_rule_cond IS NOT NULL THEN
			raise notice 'SELECT %', txt;
			
			EXECUTE 'SELECT '||txt INTO is_match;
			IF is_match THEN
				CLOSE exp_cursor;
				RETURN exp_row;	
			END IF;
		END IF;	
	END LOOP;
	
	CLOSE exp_cursor;
	RETURN NULL;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION bank_flow_out_find_expense_type(in_pay_comment text) OWNER TO glab;


-- ******************* update 24/05/2024 10:25:15 ******************
﻿-- Function: bank_flow_out_find_expense_type(in_pay_comment text)

-- DROP FUNCTION bank_flow_out_find_expense_type(in_pay_comment text);

CREATE OR REPLACE FUNCTION bank_flow_out_find_expense_type(in_pay_comment text)
  RETURNS record AS
$BODY$
DECLARE
	exp_cursor CURSOR FOR
	        SELECT
	        	id,
	        	parent_id,
	        	bank_match_rule_cond
	        FROM fin_expense_types
	        WHERE coalesce(bank_match_rule_cond,'') <> '';
	exp_row RECORD;
	txt text;
	is_match bool;
BEGIN

	OPEN exp_cursor;

	LOOP
		FETCH exp_cursor INTO exp_row;
		txt := REPLACE(exp_row.bank_match_rule_cond, 'БАНК_КОММЕНТ', in_pay_comment);
		raise notice 'SELECT %', txt;
		IF exp_row.bank_match_rule_cond IS NOT NULL THEN
			
			
			EXECUTE 'SELECT '||txt INTO is_match;
			IF is_match THEN
				CLOSE exp_cursor;
				RETURN exp_row;	
			END IF;
		END IF;	
	END LOOP;
	
	CLOSE exp_cursor;
	RETURN NULL;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION bank_flow_out_find_expense_type(in_pay_comment text) OWNER TO glab;


-- ******************* update 24/05/2024 10:25:40 ******************
﻿-- Function: bank_flow_out_find_expense_type(in_pay_comment text)

-- DROP FUNCTION bank_flow_out_find_expense_type(in_pay_comment text);

CREATE OR REPLACE FUNCTION bank_flow_out_find_expense_type(in_pay_comment text)
  RETURNS record AS
$BODY$
DECLARE
	exp_cursor CURSOR FOR
	        SELECT
	        	id,
	        	parent_id,
	        	bank_match_rule_cond
	        FROM fin_expense_types
	        WHERE coalesce(bank_match_rule_cond,'') <> '';
	exp_row RECORD;
	txt text;
	is_match bool;
BEGIN

	OPEN exp_cursor;

	LOOP
		FETCH exp_cursor INTO exp_row;
		txt := REPLACE(exp_row.bank_match_rule_cond, 'БАНК_КОММЕНТ', in_pay_comment);
		raise notice 'ID=%, SELECT %', exp_row.id, txt;
		IF exp_row.bank_match_rule_cond IS NOT NULL THEN
			
			
			EXECUTE 'SELECT '||txt INTO is_match;
			IF is_match THEN
				CLOSE exp_cursor;
				RETURN exp_row;	
			END IF;
		END IF;	
	END LOOP;
	
	CLOSE exp_cursor;
	RETURN NULL;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION bank_flow_out_find_expense_type(in_pay_comment text) OWNER TO glab;


-- ******************* update 24/05/2024 10:27:54 ******************
﻿-- Function: bank_flow_out_find_expense_type(in_pay_comment text)

-- DROP FUNCTION bank_flow_out_find_expense_type(in_pay_comment text);

CREATE OR REPLACE FUNCTION bank_flow_out_find_expense_type(in_pay_comment text)
  RETURNS record AS
$BODY$
DECLARE
	exp_cursor CURSOR FOR
	        SELECT
	        	id,
	        	parent_id,
	        	bank_match_rule_cond
	        FROM fin_expense_types
	        WHERE coalesce(bank_match_rule_cond,'') <> '';
	exp_row RECORD;
	txt text;
	is_match bool;
BEGIN

	OPEN exp_cursor;

	LOOP
		FETCH exp_cursor INTO exp_row;
		EXIT WHEN NOT FOUND;
		
		txt := REPLACE(exp_row.bank_match_rule_cond, 'БАНК_КОММЕНТ', in_pay_comment);
		raise notice 'ID=%, SELECT %', exp_row.id, txt;
		IF exp_row.bank_match_rule_cond IS NOT NULL THEN
			
			
			EXECUTE 'SELECT '||txt INTO is_match;
			IF is_match THEN
				CLOSE exp_cursor;
				RETURN exp_row;	
			END IF;
		END IF;	
	END LOOP;
	
	CLOSE exp_cursor;
	RETURN NULL;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION bank_flow_out_find_expense_type(in_pay_comment text) OWNER TO glab;


-- ******************* update 24/05/2024 10:28:31 ******************
﻿-- Function: bank_flow_out_find_expense_type(in_pay_comment text)

-- DROP FUNCTION bank_flow_out_find_expense_type(in_pay_comment text);

CREATE OR REPLACE FUNCTION bank_flow_out_find_expense_type(in_pay_comment text)
  RETURNS record AS
$BODY$
DECLARE
	exp_cursor CURSOR FOR
	        SELECT
	        	id,
	        	parent_id,
	        	bank_match_rule_cond
	        FROM fin_expense_types
	        WHERE coalesce(bank_match_rule_cond,'') <> '';
	exp_row RECORD;
	txt text;
	is_match bool;
BEGIN

	OPEN exp_cursor;

	LOOP
		FETCH exp_cursor INTO exp_row;
		EXIT WHEN NOT FOUND;
		
		txt := REPLACE(exp_row.bank_match_rule_cond, 'БАНК_КОММЕНТ', in_pay_comment);
		--raise notice 'ID=%, SELECT %', exp_row.id, txt;
		EXECUTE 'SELECT '||txt INTO is_match;
		IF is_match THEN
			CLOSE exp_cursor;
			RETURN exp_row;	
		END IF;
		
	END LOOP;
	
	CLOSE exp_cursor;
	RETURN NULL;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION bank_flow_out_find_expense_type(in_pay_comment text) OWNER TO glab;


-- ******************* update 24/05/2024 10:46:46 ******************
﻿-- Function: bank_flow_out_find_expense_type(in_pay_comment text)

 DROP FUNCTION bank_flow_out_find_expense_type(in_pay_comment text);

CREATE OR REPLACE FUNCTION bank_flow_out_find_expense_type(in_pay_comment text,
	OUT id int,
	OUT parent_id int
)
AS
$BODY$
DECLARE
	exp_cursor CURSOR FOR
	        SELECT
	        	exp_t.id,
	        	exp_t.parent_id,
	        	exp_t.bank_match_rule_cond
	        FROM fin_expense_types AS exp_t
	        WHERE coalesce(exp_t.bank_match_rule_cond,'') <> '';
	exp_row RECORD;
	txt text;
	is_match bool;
BEGIN

	OPEN exp_cursor;

	LOOP
		FETCH exp_cursor INTO exp_row;
		EXIT WHEN NOT FOUND;
		
		txt := REPLACE(exp_row.bank_match_rule_cond, 'БАНК_КОММЕНТ', in_pay_comment);
		--raise notice 'ID=%, SELECT %', exp_row.id, txt;
		EXECUTE 'SELECT '||txt INTO is_match;
		IF is_match THEN
			id = exp_row.id;
			parent_id = exp_row.parent_id;
			
			CLOSE exp_cursor;
			RETURN;
		END IF;
		
	END LOOP;
	
	CLOSE exp_cursor;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION bank_flow_out_find_expense_type(in_pay_comment text) OWNER TO glab;


-- ******************* update 24/05/2024 10:56:48 ******************

	DROP INDEX IF EXISTS bank_flow_in_bank_acc_idx;
	CREATE UNIQUE INDEX bank_flow_in_bank_acc_idx
	ON bank_flow_in(bank_account_id,date_time,pp_num,client_descr);



-- ******************* update 24/05/2024 10:57:25 ******************

	DROP INDEX IF EXISTS bank_flow_in_bank_acc_idx;
	CREATE UNIQUE INDEX bank_flow_in_bank_acc_idx
	ON bank_flow_in(bank_account_id,date_time,pp_num,client_descr);



-- ******************* update 24/05/2024 10:58:18 ******************

	DROP INDEX IF EXISTS bank_flow_out_bank_acc_idx;
	CREATE UNIQUE INDEX bank_flow_out_bank_acc_idx
	ON bank_flow_out(bank_account_id,date_time,pp_num,client_descr);



-- ******************* update 24/05/2024 11:11:51 ******************
-- VIEW: public.user_operations_dialog

--DROP VIEW public.user_operations_dialog;

CREATE OR REPLACE VIEW public.user_operations_dialog AS
	SELECT
		t.user_id
		,t.operation_id
		,t.operation
		,t.status
		,t.date_time
		,t.error_text
		,t.comment_text
		,t.date_time_end
		,t.end_wal_lsn
	FROM public.user_operations AS t
	
	
	;
	
ALTER VIEW public.user_operations_dialog OWNER TO glab;


-- ******************* update 24/05/2024 16:35:14 ******************
﻿-- Function: bank_flow_account_balance_list(in_firm_id int, in_bank_account_id int, in_date_time_from timestamp, in_date_time_to timestamp)

-- DROP FUNCTION bank_flow_account_balance_list();

CREATE OR REPLACE FUNCTION bank_flow_account_balance_list(in_firm_id int, in_bank_account_id int, in_date_time_from timestamp, in_date_time_to timestamp)
  RETURNS TABLE(
  	firm_id int,
  	firms_ref json,
  	bank_account_id int,
  	bank_accounts_ref json,
  	balance_start numeric(15,2),
  	total_in numeric(15,2),
  	total_out numeric(15,2),
  	balance_end numeric(15,2)
  ) AS
$$
	SELECT
		sub.firm_id,
		firms_ref(firms),	
		sub.bank_account_id,
		bank_accounts_ref(acc),
		coalesce(sub.b_start, 0),
		coalesce(sub.total_in, 0),
		coalesce(sub.total_out, 0),
		coalesce(sub.b_end, 0)
	FROM (
		SELECT
			rg_from.bank_account_id,
			firms.id AS firm_id,
			rg_from.total AS b_start,
			0 AS total_in,
			0 AS total_out,
			0 AS b_end
		FROM rg_bank_flow_balance(
			in_date_time_from,
			CASE
				WHEN in_bank_account_id = 0 THEN '{}'
				ELSE ARRAY[in_bank_account_id]
			END
		) AS rg_from
		LEFT JOIN bank_accounts AS bnk ON bnk.id = rg_from.bank_account_id
		LEFT JOIN firms ON firms.id = bnk.parent_id AND bnk.parent_data_type = 'firms'
		WHERE (in_firm_id = 0) OR in_firm_id = firms.id
	) AS sub
	LEFT JOIN firms ON firms.id = sub.firm_id
	LEFT JOIN bank_accounts AS acc ON acc.id = sub.bank_account_id
	;
$$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION bank_flow_account_balance_list(in_firm_id int, in_bank_account_id int, in_date_time_from timestamp, in_date_time_to timestamp) OWNER TO glab;


-- ******************* update 24/05/2024 16:37:10 ******************
﻿-- Function: bank_flow_account_balance_list(in_firm_id int, in_bank_account_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ)

-- DROP FUNCTION bank_flow_account_balance_list();

CREATE OR REPLACE FUNCTION bank_flow_account_balance_list(in_firm_id int, in_bank_account_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ)
  RETURNS TABLE(
  	firm_id int,
  	firms_ref json,
  	bank_account_id int,
  	bank_accounts_ref json,
  	balance_start numeric(15,2),
  	total_in numeric(15,2),
  	total_out numeric(15,2),
  	balance_end numeric(15,2)
  ) AS
$$
	SELECT
		sub.firm_id,
		firms_ref(firms),	
		sub.bank_account_id,
		bank_accounts_ref(acc),
		coalesce(sub.b_start, 0),
		coalesce(sub.total_in, 0),
		coalesce(sub.total_out, 0),
		coalesce(sub.b_end, 0)
	FROM (
		SELECT
			rg_from.bank_account_id,
			firms.id AS firm_id,
			rg_from.total AS b_start,
			0 AS total_in,
			0 AS total_out,
			0 AS b_end
		FROM rg_bank_flow_balance(
			in_date_time_from::timestamp,
			CASE
				WHEN in_bank_account_id = 0 THEN '{}'
				ELSE ARRAY[in_bank_account_id]
			END
		) AS rg_from
		LEFT JOIN bank_accounts AS bnk ON bnk.id = rg_from.bank_account_id
		LEFT JOIN firms ON firms.id = bnk.parent_id AND bnk.parent_data_type = 'firms'
		WHERE (in_firm_id = 0) OR in_firm_id = firms.id
	) AS sub
	LEFT JOIN firms ON firms.id = sub.firm_id
	LEFT JOIN bank_accounts AS acc ON acc.id = sub.bank_account_id
	;
$$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION bank_flow_account_balance_list(in_firm_id int, in_bank_account_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ) OWNER TO glab;


-- ******************* update 24/05/2024 16:38:37 ******************
﻿-- Function: bank_flow_account_balance_list(in_firm_id int, in_bank_account_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ)

-- DROP FUNCTION bank_flow_account_balance_list();

CREATE OR REPLACE FUNCTION bank_flow_account_balance_list(in_firm_id int, in_bank_account_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ)
  RETURNS TABLE(
  	firm_id int,
  	firms_ref json,
  	bank_account_id int,
  	bank_accounts_ref json,
  	balance_start numeric(15,2),
  	total_in numeric(15,2),
  	total_out numeric(15,2),
  	balance_end numeric(15,2)
  ) AS
$$
	SELECT
		sub.firm_id,
		firms_ref(firms),	
		sub.bank_account_id,
		bank_accounts_ref(acc),
		coalesce(sub.b_start, 0),
		coalesce(sub.total_in, 0),
		coalesce(sub.total_out, 0),
		coalesce(sub.b_end, 0)
	FROM (
		SELECT
			rg_from.bank_account_id,
			firms.id AS firm_id,
			rg_from.total AS b_start,
			0 AS total_in,
			0 AS total_out,
			0 AS b_end
		FROM rg_bank_flow_balance(			
			in_date_time_from::timestamp,
			CASE
				WHEN in_bank_account_id = 0 THEN '{}'
				ELSE ARRAY[in_bank_account_id]
			END		
		) AS rg_from
		LEFT JOIN bank_accounts AS bnk ON bnk.id = rg_from.bank_account_id
		LEFT JOIN firms ON firms.id = bnk.parent_id AND bnk.parent_data_type = 'firms'
		WHERE (in_firm_id = 0) OR in_firm_id = firms.id
	) AS sub
	LEFT JOIN firms ON firms.id = sub.firm_id
	LEFT JOIN bank_accounts AS acc ON acc.id = sub.bank_account_id
	;
$$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION bank_flow_account_balance_list(in_firm_id int, in_bank_account_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ) OWNER TO glab;


-- ******************* update 24/05/2024 16:59:19 ******************
﻿-- Function: bank_flow_account_balance_list(in_firm_id int, in_bank_account_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ)

-- DROP FUNCTION bank_flow_account_balance_list();

CREATE OR REPLACE FUNCTION bank_flow_account_balance_list(in_firm_id int, in_bank_account_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ)
  RETURNS TABLE(
  	firm_id int,
  	firms_ref json,
  	bank_account_id int,
  	bank_accounts_ref json,
  	balance_start numeric(15,2),
  	total_in numeric(15,2),
  	total_out numeric(15,2),
  	balance_end numeric(15,2)
  ) AS
$$
	SELECT
		sub.firm_id,
		firms_ref(firms),	
		sub.bank_account_id,
		bank_accounts_ref(acc),
		coalesce(sub.b_start, 0),
		coalesce(sub.total_in, 0),
		coalesce(sub.total_out, 0),
		coalesce(sub.b_start, 0) + coalesce(sub.total_in, 0) - coalesce(sub.total_out, 0)
	FROM (
		--start
		(SELECT
			rg.bank_account_id,
			firms.id AS firm_id,
			rg.total AS b_start,
			0 AS total_in,
			0 AS total_out,
			0 AS b_end
		FROM rg_bank_flow_balance(			
			in_date_time_from::timestamp,
			CASE
				WHEN in_bank_account_id = 0 THEN '{}'
				ELSE ARRAY[in_bank_account_id]
			END		
		) AS rg
		LEFT JOIN bank_accounts AS bnk ON bnk.id = rg.bank_account_id
		LEFT JOIN firms ON firms.id = bnk.parent_id AND bnk.parent_data_type = 'firms'
		WHERE (in_firm_id = 0) OR in_firm_id = firms.id)
		
		UNION ALL
		--total in/out
		(SELECT
			ra.bank_account_id,
			firms.id AS firm_id,
			0 AS b_start,
			CASE
				WHEN ra.deb THEN ra.total
				ELSE 0
			END AS total_in,
			CASE
				WHEN ra.deb = FALSE THEN ra.total
				ELSE 0
			END AS total_out,
			0 AS b_end
		FROM ra_bank_flow AS ra
		LEFT JOIN bank_accounts AS bnk ON bnk.id = ra.bank_account_id
		LEFT JOIN firms ON firms.id = bnk.parent_id AND bnk.parent_data_type = 'firms'
		WHERE (in_firm_id = 0 OR in_firm_id = firms.id)
			AND ra.date_time BETWEEN in_date_time_from AND in_date_time_to
		)
	) AS sub
	LEFT JOIN firms ON firms.id = sub.firm_id
	LEFT JOIN bank_accounts AS acc ON acc.id = sub.bank_account_id
	;
$$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION bank_flow_account_balance_list(in_firm_id int, in_bank_account_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ) OWNER TO glab;


-- ******************* update 24/05/2024 17:01:53 ******************
﻿-- Function: bank_flow_account_balance_list(in_firm_id int, in_bank_account_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ)

-- DROP FUNCTION bank_flow_account_balance_list();

CREATE OR REPLACE FUNCTION bank_flow_account_balance_list(in_firm_id int, in_bank_account_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ)
  RETURNS TABLE(
  	firm_id int,
  	firms_ref json,
  	bank_account_id int,
  	bank_accounts_ref json,
  	balance_start numeric(15,2),
  	total_in numeric(15,2),
  	total_out numeric(15,2),
  	balance_end numeric(15,2)
  ) AS
$$
	SELECT
		sub.firm_id,
		firms_ref(firms),	
		sub.bank_account_id,
		bank_accounts_ref(acc),
		SUM(coalesce(sub.b_start, 0)),
		SUM(coalesce(sub.total_in, 0)),
		SUM(coalesce(sub.total_out, 0)),
		SUM(coalesce(sub.b_start, 0)) + SUM(coalesce(sub.total_in, 0)) - SUM(coalesce(sub.total_out, 0))
	FROM (
		--start
		(SELECT
			rg.bank_account_id,
			firms.id AS firm_id,
			rg.total AS b_start,
			0 AS total_in,
			0 AS total_out,
			0 AS b_end
		FROM rg_bank_flow_balance(			
			in_date_time_from::timestamp,
			CASE
				WHEN in_bank_account_id = 0 THEN '{}'
				ELSE ARRAY[in_bank_account_id]
			END		
		) AS rg
		LEFT JOIN bank_accounts AS bnk ON bnk.id = rg.bank_account_id
		LEFT JOIN firms ON firms.id = bnk.parent_id AND bnk.parent_data_type = 'firms'
		WHERE (in_firm_id = 0) OR in_firm_id = firms.id)
		
		UNION ALL
		--total in/out
		(SELECT
			ra.bank_account_id,
			firms.id AS firm_id,
			0 AS b_start,
			CASE
				WHEN ra.deb THEN ra.total
				ELSE 0
			END AS total_in,
			CASE
				WHEN ra.deb = FALSE THEN ra.total
				ELSE 0
			END AS total_out,
			0 AS b_end
		FROM ra_bank_flow AS ra
		LEFT JOIN bank_accounts AS bnk ON bnk.id = ra.bank_account_id
		LEFT JOIN firms ON firms.id = bnk.parent_id AND bnk.parent_data_type = 'firms'
		WHERE (in_firm_id = 0 OR in_firm_id = firms.id)
			AND ra.date_time BETWEEN in_date_time_from AND in_date_time_to
		)
	) AS sub
	LEFT JOIN firms ON firms.id = sub.firm_id
	LEFT JOIN bank_accounts AS acc ON acc.id = sub.bank_account_id
	GROUP BY
		sub.firm_id,
		firms.*,	
		sub.bank_account_id,
		acc.*
	;
$$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION bank_flow_account_balance_list(in_firm_id int, in_bank_account_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ) OWNER TO glab;


-- ******************* update 24/05/2024 17:32:27 ******************
﻿-- Function: bank_flow_account_balance_list(in_firm_id int, in_bank_account_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ)

-- DROP FUNCTION bank_flow_account_balance_list(in_firm_id int, in_bank_account_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ);

CREATE OR REPLACE FUNCTION bank_flow_account_balance_list(in_firm_id int, in_bank_account_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ)
  RETURNS TABLE(
  	firm_id int,
  	firms_ref json,
  	bank_account_id int,
  	bank_account_num text,
  	bank_account_name text,
  	bank_name text,
  	bank_accounts_ref json,
  	balance_start numeric(15,2),
  	total_in numeric(15,2),
  	total_out numeric(15,2),
  	balance_end numeric(15,2)
  ) AS
$$
	SELECT
		sub.firm_id,
		firms_ref(firms),	
		sub.bank_account_id,		
		acc.bank_acc,
		acc.name,
		bank.name,
		bank_accounts_ref(acc),
		SUM(coalesce(sub.b_start, 0)),
		SUM(coalesce(sub.total_in, 0)),
		SUM(coalesce(sub.total_out, 0)),
		SUM(coalesce(sub.b_start, 0)) + SUM(coalesce(sub.total_in, 0)) - SUM(coalesce(sub.total_out, 0))
	FROM (
		--start
		(SELECT
			rg.bank_account_id,
			firms.id AS firm_id,
			rg.total AS b_start,
			0 AS total_in,
			0 AS total_out,
			0 AS b_end
		FROM rg_bank_flow_balance(			
			in_date_time_from::timestamp,
			CASE
				WHEN in_bank_account_id = 0 THEN '{}'
				ELSE ARRAY[in_bank_account_id]
			END		
		) AS rg
		LEFT JOIN bank_accounts AS bnk ON bnk.id = rg.bank_account_id
		LEFT JOIN firms ON firms.id = bnk.parent_id AND bnk.parent_data_type = 'firms'
		WHERE (in_firm_id = 0) OR in_firm_id = firms.id)
		
		UNION ALL
		--total in/out
		(SELECT
			ra.bank_account_id,
			firms.id AS firm_id,
			0 AS b_start,
			CASE
				WHEN ra.deb THEN ra.total
				ELSE 0
			END AS total_in,
			CASE
				WHEN ra.deb = FALSE THEN ra.total
				ELSE 0
			END AS total_out,
			0 AS b_end
		FROM ra_bank_flow AS ra
		LEFT JOIN bank_accounts AS bnk ON bnk.id = ra.bank_account_id
		LEFT JOIN firms ON firms.id = bnk.parent_id AND bnk.parent_data_type = 'firms'
		WHERE (in_firm_id = 0 OR in_firm_id = firms.id)
			AND ra.date_time BETWEEN in_date_time_from AND in_date_time_to
		)
	) AS sub
	LEFT JOIN firms ON firms.id = sub.firm_id
	LEFT JOIN bank_accounts AS acc ON acc.id = sub.bank_account_id
	LEFT JOIN banks.banks AS bank ON bank.bik = acc.bank_bik
	GROUP BY
		sub.firm_id,
		firms.*,	
		sub.bank_account_id,
		acc.*,
		acc.bank_acc,
		bank.name,
		acc.name
	;
$$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION bank_flow_account_balance_list(in_firm_id int, in_bank_account_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ) OWNER TO glab;


-- ******************* update 24/05/2024 17:33:40 ******************
﻿-- Function: bank_flow_account_balance_list(in_firm_id int, in_bank_account_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ)

 DROP FUNCTION bank_flow_account_balance_list(in_firm_id int, in_bank_account_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ);

CREATE OR REPLACE FUNCTION bank_flow_account_balance_list(in_firm_id int, in_bank_account_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ)
  RETURNS TABLE(
  	firm_id int,
  	firm_name text,
  	bank_account_id int,
  	bank_account_num text,
  	bank_account_name text,
  	bank_name text,
  	balance_start numeric(15,2),
  	total_in numeric(15,2),
  	total_out numeric(15,2),
  	balance_end numeric(15,2)
  ) AS
$$
	SELECT
		sub.firm_id,
		firms.name,	
		sub.bank_account_id,		
		acc.bank_acc,
		acc.name,
		bank.name,
		SUM(coalesce(sub.b_start, 0)),
		SUM(coalesce(sub.total_in, 0)),
		SUM(coalesce(sub.total_out, 0)),
		SUM(coalesce(sub.b_start, 0)) + SUM(coalesce(sub.total_in, 0)) - SUM(coalesce(sub.total_out, 0))
	FROM (
		--start
		(SELECT
			rg.bank_account_id,
			firms.id AS firm_id,
			rg.total AS b_start,
			0 AS total_in,
			0 AS total_out,
			0 AS b_end
		FROM rg_bank_flow_balance(			
			in_date_time_from::timestamp,
			CASE
				WHEN in_bank_account_id = 0 THEN '{}'
				ELSE ARRAY[in_bank_account_id]
			END		
		) AS rg
		LEFT JOIN bank_accounts AS bnk ON bnk.id = rg.bank_account_id
		LEFT JOIN firms ON firms.id = bnk.parent_id AND bnk.parent_data_type = 'firms'
		WHERE (in_firm_id = 0) OR in_firm_id = firms.id)
		
		UNION ALL
		--total in/out
		(SELECT
			ra.bank_account_id,
			firms.id AS firm_id,
			0 AS b_start,
			CASE
				WHEN ra.deb THEN ra.total
				ELSE 0
			END AS total_in,
			CASE
				WHEN ra.deb = FALSE THEN ra.total
				ELSE 0
			END AS total_out,
			0 AS b_end
		FROM ra_bank_flow AS ra
		LEFT JOIN bank_accounts AS bnk ON bnk.id = ra.bank_account_id
		LEFT JOIN firms ON firms.id = bnk.parent_id AND bnk.parent_data_type = 'firms'
		WHERE (in_firm_id = 0 OR in_firm_id = firms.id)
			AND ra.date_time BETWEEN in_date_time_from AND in_date_time_to
		)
	) AS sub
	LEFT JOIN firms ON firms.id = sub.firm_id
	LEFT JOIN bank_accounts AS acc ON acc.id = sub.bank_account_id
	LEFT JOIN banks.banks AS bank ON bank.bik = acc.bank_bik
	GROUP BY
		sub.firm_id,
		sub.bank_account_id,
		acc.bank_acc,
		bank.name,
		acc.name,
		firms.name
	;
$$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION bank_flow_account_balance_list(in_firm_id int, in_bank_account_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ) OWNER TO glab;


-- ******************* update 24/05/2024 17:35:55 ******************
﻿-- Function: bank_flow_account_out_list(in_firm_id int, in_bank_account_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ)

-- DROP FUNCTION bank_flow_account_out_list(in_firm_id int, in_bank_account_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ);

CREATE OR REPLACE FUNCTION bank_flow_account_out_list(in_firm_id int, in_bank_account_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ)
  RETURNS TABLE(
	bank_account_id int,
	fin_expense_type1_id int,
	fin_expense_type1_descr text,
	total_out numeric(15,2)
  )
   AS
$$
	SELECT
		bnk.bank_account_id,
		bnk.fin_expense_type1_id,
		exp_tp.name,
		bnk.total
	FROM bank_flow_out AS bnk
	LEFT JOIN fin_expense_types AS exp_tp ON exp_tp.id = bnk.fin_expense_type1_id
	LEFT JOIN bank_accounts AS acc ON acc.id = bnk.bank_account_id
	WHERE
		bnk.date_time BETWEEN in_date_time_from AND in_date_time_to
		AND (in_bank_account_id = 0 OR in_bank_account_id = bnk.bank_account_id)
		AND (in_firm_id = 0 OR (in_firm_id = acc.parent_id AND acc.parent_data_type = 'firms'))
	ORDER BY
		bnk.bank_account_id,
		exp_tp.name
	;
$$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION bank_flow_account_out_list(in_firm_id int, in_bank_account_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ) OWNER TO glab;


-- ******************* update 29/05/2024 13:34:22 ******************
﻿-- Function: bank_flow_account_balance_list(in_firm_id int, in_bank_account_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ)

-- DROP FUNCTION bank_flow_account_balance_list(in_firm_id int, in_bank_account_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ);

CREATE OR REPLACE FUNCTION bank_flow_account_balance_list(in_firm_id int, in_bank_account_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ)
  RETURNS TABLE(
  	firm_id int,
  	firm_name text,
  	bank_account_id int,
  	bank_account_num text,
  	bank_account_name text,
  	bank_name text,
  	balance_start numeric(15,2),
  	total_in numeric(15,2),
  	total_out numeric(15,2),
  	balance_end numeric(15,2)
  ) AS
$$
	SELECT
		sub.firm_id,
		firms.name,	
		sub.bank_account_id,		
		acc.bank_acc,
		acc.name,
		bank.name,
		SUM(coalesce(sub.b_start, 0)),
		SUM(coalesce(sub.total_in, 0)),
		SUM(coalesce(sub.total_out, 0)),
		SUM(coalesce(sub.b_start, 0)) + SUM(coalesce(sub.total_in, 0)) - SUM(coalesce(sub.total_out, 0))
	FROM (
		--start
		(SELECT
			rg.bank_account_id,
			firms.id AS firm_id,
			rg.total AS b_start,
			0 AS total_in,
			0 AS total_out,
			0 AS b_end
		FROM rg_bank_flow_balance(			
			in_date_time_from::timestamp,
			CASE
				WHEN coalesce(in_bank_account_id, 0) = 0 THEN '{}'
				ELSE ARRAY[in_bank_account_id]
			END		
		) AS rg
		LEFT JOIN bank_accounts AS bnk ON bnk.id = rg.bank_account_id
		LEFT JOIN firms ON firms.id = bnk.parent_id AND bnk.parent_data_type = 'firms'
		WHERE (coalesce(in_firm_id, 0) = 0) OR in_firm_id = firms.id)
		
		UNION ALL
		--total in/out
		(SELECT
			ra.bank_account_id,
			firms.id AS firm_id,
			0 AS b_start,
			CASE
				WHEN ra.deb THEN ra.total
				ELSE 0
			END AS total_in,
			CASE
				WHEN ra.deb = FALSE THEN ra.total
				ELSE 0
			END AS total_out,
			0 AS b_end
		FROM ra_bank_flow AS ra
		LEFT JOIN bank_accounts AS bnk ON bnk.id = ra.bank_account_id
		LEFT JOIN firms ON firms.id = bnk.parent_id AND bnk.parent_data_type = 'firms'
		WHERE (coalesce(in_firm_id, 0) = 0 OR in_firm_id = firms.id)
			AND ra.date_time BETWEEN in_date_time_from AND in_date_time_to
		)
	) AS sub
	LEFT JOIN firms ON firms.id = sub.firm_id
	LEFT JOIN bank_accounts AS acc ON acc.id = sub.bank_account_id
	LEFT JOIN banks.banks AS bank ON bank.bik = acc.bank_bik
	GROUP BY
		sub.firm_id,
		sub.bank_account_id,
		acc.bank_acc,
		bank.name,
		acc.name,
		firms.name
	;
$$
  LANGUAGE sql VOLATILE called on null input
  COST 100;
ALTER FUNCTION bank_flow_account_balance_list(in_firm_id int, in_bank_account_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ) OWNER TO glab;


-- ******************* update 29/05/2024 14:30:26 ******************
﻿-- Function: bank_flow_account_out_list(in_firm_id int, in_bank_account_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ)

-- DROP FUNCTION bank_flow_account_out_list(in_firm_id int, in_bank_account_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ);

CREATE OR REPLACE FUNCTION bank_flow_account_out_list(in_firm_id int, in_bank_account_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ)
  RETURNS TABLE(
	bank_account_id int,
	fin_expense_type1_id int,
	fin_expense_type1_descr text,
	total_out numeric(15,2)
  )
   AS
$$
	SELECT
		bnk.bank_account_id,
		bnk.fin_expense_type1_id,
		exp_tp.name,
		bnk.total
	FROM bank_flow_out AS bnk
	LEFT JOIN fin_expense_types AS exp_tp ON exp_tp.id = bnk.fin_expense_type1_id
	LEFT JOIN bank_accounts AS acc ON acc.id = bnk.bank_account_id
	WHERE
		bnk.date_time BETWEEN in_date_time_from AND in_date_time_to
		AND (in_bank_account_id = 0 OR in_bank_account_id = bnk.bank_account_id)
		AND (in_firm_id = 0 OR (in_firm_id = acc.parent_id AND acc.parent_data_type = 'firms'))
	ORDER BY
		bnk.bank_account_id,
		exp_tp.name
	;
$$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION bank_flow_account_out_list(in_firm_id int, in_bank_account_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ) OWNER TO glab;


-- ******************* update 29/05/2024 14:34:07 ******************
﻿-- Function: bank_flow_account_out_list(in_firm_id int, in_bank_account_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ)

-- DROP FUNCTION bank_flow_account_out_list(in_firm_id int, in_bank_account_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ);

CREATE OR REPLACE FUNCTION bank_flow_account_out_list(in_firm_id int, in_bank_account_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ)
  RETURNS TABLE(
	bank_account_id int,
	fin_expense_type1_id int,
	fin_expense_type1_descr text,
	total_out numeric(15,2)
  )
   AS
$$
	SELECT
		bnk.bank_account_id,
		bnk.fin_expense_type1_id,
		exp_tp.name,
		bnk.total
	FROM bank_flow_out AS bnk
	LEFT JOIN fin_expense_types AS exp_tp ON exp_tp.id = bnk.fin_expense_type1_id
	LEFT JOIN bank_accounts AS acc ON acc.id = bnk.bank_account_id
	WHERE
		bnk.date_time BETWEEN in_date_time_from AND in_date_time_to
		AND (coalesce(in_bank_account_id, 0) = 0 OR in_bank_account_id = bnk.bank_account_id)
		AND (coalesce(in_firm_id, 0) = 0 OR (in_firm_id = acc.parent_id AND acc.parent_data_type = 'firms'))
	ORDER BY
		bnk.bank_account_id,
		exp_tp.name
	;
$$
  LANGUAGE sql VOLATILE called on null input
  COST 100;
ALTER FUNCTION bank_flow_account_out_list(in_firm_id int, in_bank_account_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ) OWNER TO glab;


-- ******************* update 29/05/2024 15:19:58 ******************
﻿-- Function: bank_flow_account_out_list(in_firm_id int, in_bank_account_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ)

-- DROP FUNCTION bank_flow_account_out_list(in_firm_id int, in_bank_account_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ);

CREATE OR REPLACE FUNCTION bank_flow_account_out_list(in_firm_id int, in_bank_account_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ)
  RETURNS TABLE(
	bank_account_id int,
	fin_expense_type1_id int,
	fin_expense_type1_descr text,
	total_out numeric(15,2)
  )
   AS
$$
	SELECT
		bnk.bank_account_id,
		coalesce(bnk.fin_expense_type1_id, 0),
		coalesce(exp_tp.name, ''),
		bnk.total
	FROM bank_flow_out AS bnk
	LEFT JOIN fin_expense_types AS exp_tp ON exp_tp.id = bnk.fin_expense_type1_id
	LEFT JOIN bank_accounts AS acc ON acc.id = bnk.bank_account_id
	WHERE
		bnk.date_time BETWEEN in_date_time_from AND in_date_time_to
		AND (coalesce(in_bank_account_id, 0) = 0 OR in_bank_account_id = bnk.bank_account_id)
		AND (coalesce(in_firm_id, 0) = 0 OR (in_firm_id = acc.parent_id AND acc.parent_data_type = 'firms'))
	ORDER BY
		bnk.bank_account_id,
		exp_tp.name
	;
$$
  LANGUAGE sql VOLATILE called on null input
  COST 100;
ALTER FUNCTION bank_flow_account_out_list(in_firm_id int, in_bank_account_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ) OWNER TO glab;


-- ******************* update 29/05/2024 15:30:47 ******************
﻿-- Function: format_period_rus(in_date_from date, in_date_to date, in_date_format text)

-- DROP FUNCTION format_period_rus(in_date_from date, in_date_to date, in_date_format text);

CREATE OR REPLACE FUNCTION format_period_rus(in_date_from date, in_date_to date, in_date_format text)
  RETURNS text AS
$$
	WITH
	def_format AS (
		SELECT
			'с '||
			CASE WHEN in_date_format IS NULL THEN to_char(in_date_from,'DD/MM/YY') ELSE to_char(in_date_from,in_date_format) END
			||' по '||
			CASE WHEN in_date_format IS NULL THEN to_char(in_date_to,'DD/MM/YY') ELSE to_char(in_date_to,in_date_format) END
		AS per	
	)
	SELECT
		--Same month, same year
		CASE WHEN extract(day FROM in_date_from)=1 AND last_month_day(in_date_to)=in_date_to THEN			
			CASE
				--1 month
				WHEN
				extract(month FROM in_date_from)=extract(month FROM in_date_to) AND extract(year FROM in_date_from)=extract(year FROM in_date_to) THEN
				--'за '||lower(to_char(in_date_to,'TMMonth'))||' '||to_char(in_date_to,'YYYY')||'г.'
				'за '||
				(ARRAY['январь','февраль','март','апрель','май','июнь','июль','август','сентябрь','октябрь','ноябрь','декабрь'])[extract(month FROM in_date_from)]||
				' '||to_char(in_date_to,'YYYY')||'г.'

				--first quarter
				WHEN
				extract(month FROM in_date_from)=1 AND extract(year FROM in_date_from)=extract(year FROM in_date_to)
				AND extract(month FROM in_date_to)=3 THEN
				'за 1 квартал '||to_char(in_date_to,'YYYY')||'г.'

				--second quarter
				WHEN
				extract(month FROM in_date_from)=4 AND extract(year FROM in_date_from)=extract(year FROM in_date_to)
				AND extract(month FROM in_date_to)=6 THEN
				'за 2 квартал '||to_char(in_date_to,'YYYY')||'г.'

				--third quarter
				WHEN
				extract(month FROM in_date_from)=7 AND extract(year FROM in_date_from)=extract(year FROM in_date_to)
				AND extract(month FROM in_date_to)=9 THEN
				'за 3 квартал '||to_char(in_date_to,'YYYY')||'г.'

				--forth quarter
				WHEN
				extract(month FROM in_date_from)=10 AND extract(year FROM in_date_from)=extract(year FROM in_date_to)
				AND extract(month FROM in_date_to)=12 THEN
				'за 4 квартал '||to_char(in_date_to,'YYYY')||'г.'

				--6 months
				WHEN
				extract(month FROM in_date_from)=1 AND extract(year FROM in_date_from)=extract(year FROM in_date_to)
				AND extract(month FROM in_date_to)=6 THEN
				'за первое полугодие '||to_char(in_date_to,'YYYY')||'г.'

				--9 months
				WHEN
				extract(month FROM in_date_from)=1 AND extract(year FROM in_date_from)=extract(year FROM in_date_to)
				AND extract(month FROM in_date_to)=9 THEN
				'за 9 месяцев '||to_char(in_date_to,'YYYY')||'г.'
				
				--second half
				WHEN
				extract(month FROM in_date_from)=7 AND extract(year FROM in_date_from)=extract(year FROM in_date_to)
				AND extract(month FROM in_date_to)=12 THEN
				'за второе полугодие '||to_char(in_date_to,'YYYY')||'г.'
				
				--year
				WHEN
				extract(month FROM in_date_from)=1 AND extract(year FROM in_date_from)=extract(year FROM in_date_to)
				AND extract(month FROM in_date_to)=12 THEN
				'за '||to_char(in_date_to,'YYYY')||' год'
				
				ELSE
				(SELECT per FROM def_format)
			END
		--Default
		ELSE
			(SELECT per FROM def_format)
		END
	;
$$
  LANGUAGE sql IMMUTABLE CALLED ON NULL INPUT
  COST 100;
ALTER FUNCTION format_period_rus(in_date_from date, in_date_to date, in_date_format text) OWNER TO glab;


-- ******************* update 30/05/2024 08:55:35 ******************
﻿-- Function: cash_flow_location_balance_list(in_cash_location_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ)

-- DROP FUNCTION cash_flow_location_balance_list(in_cash_location_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ);

CREATE OR REPLACE FUNCTION cash_flow_location_balance_list(in_cash_location_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ)
  RETURNS TABLE(
  	cash_location_id int,
  	cash_location_name text,
  	balance_start numeric(15,2),
  	total_in numeric(15,2),
  	total_transfer_in numeric(15,2),
  	total_out numeric(15,2),
  	total_transfer_out numeric(15,2),
  	balance_end numeric(15,2)
  ) AS
$$
	SELECT
		sub.cash_location_id,
		cash_locations.name AS cash_location_name,	
		SUM(coalesce(sub.b_start, 0)),
		SUM(coalesce(sub.total_in, 0)),
		SUM(coalesce(sub.total_transfer_in, 0)),
		SUM(coalesce(sub.total_out, 0)),
		SUM(coalesce(sub.total_transfer_out, 0)),
		SUM(coalesce(sub.b_start, 0)) + SUM(coalesce(sub.total_in, 0)) - SUM(coalesce(sub.total_out, 0))
	FROM (
		--start
		(SELECT
			rg.cash_location_id,
			rg.total AS b_start,
			0 AS total_in,
			0 AS total_transfer_in,
			0 AS total_out,
			0 AS total_transfer_out,
			0 AS b_end
		FROM rg_cash_flow_balance(			
			in_date_time_from::timestamp,
			CASE
				WHEN coalesce(in_cash_location_id, 0) = 0 THEN '{}'
				ELSE ARRAY[in_cash_location_id]
			END		
		) AS rg
		)
		
		UNION ALL
		--total in/out
		(SELECT
			ra.cash_location_id,
			0 AS b_start,
			CASE
				WHEN ra.deb THEN ra.total
				ELSE 0
			END AS total_in,
			CASE
				WHEN ra.deb AND ra.doc_type = 'cash_flow_transfers' THEN ra.total
				ELSE 0
			END AS total_transfer_in,
			
			CASE
				WHEN ra.deb = FALSE THEN ra.total
				ELSE 0
			END AS total_out,
			CASE
				WHEN ra.deb = FALSE AND ra.doc_type = 'cash_flow_transfers' THEN ra.total				
				ELSE 0
			END AS total_transfer_out,
			
			0 AS b_end
		FROM ra_cash_flow AS ra
		WHERE (coalesce(in_cash_location_id, 0) = 0 OR in_cash_location_id = ra.cash_location_id)
			AND ra.date_time BETWEEN in_date_time_from AND in_date_time_to
		)
		
	) AS sub
	LEFT JOIN cash_locations ON cash_locations.id = sub.cash_location_id
	GROUP BY
		sub.cash_location_id,
		cash_locations.name
	;
$$
  LANGUAGE sql VOLATILE called on null input
  COST 100;
ALTER FUNCTION cash_flow_location_balance_list(in_cash_location_id int, in_date_time_from timestampTZ, in_date_time_to timestampTZ) OWNER TO glab;


-- ******************* update 03/06/2024 08:22:13 ******************
-- VIEW: public.fin_expense_types_items_list

--DROP VIEW public.fin_expense_types_items_list;

CREATE OR REPLACE VIEW public.fin_expense_types_items_list AS
	SELECT
		item.id,
		par1.id AS parent1_id,
		par2.id AS parent2_id,
		fin_expense_types_ref(par1) AS parents1_ref,
		fin_expense_types_ref(par2) AS parents2_ref,
		item.name
	FROM fin_expense_types AS item
	LEFT JOIN fin_expense_types AS par2 ON par2.id = item.parent_id
	LEFT JOIN fin_expense_types AS par1 ON par1.id = par2.parent_id
	WHERE par1.id IS NOT NULL
	ORDER BY item.name
	;
	
ALTER VIEW public.fin_expense_types_items_list OWNER TO glab;


-- ******************* update 03/06/2024 08:56:47 ******************

	
	-- Adding menu item
	INSERT INTO views
	(id,c,f,t,section,descr,limited)
	VALUES (
	'10031',
	'FinExpenseType_Controller',
	'get_list',
	'FinExpenseTypeItemList',
	'Справочники',
	'Элементы расходов',
	FALSE
	);
	
	


-- ******************* update 03/06/2024 09:24:58 ******************
/**
 * Andrey Mikhalevich 15/12/21
 * This file is part of the OSBE framework
 *
 * THIS FILE IS GENERATED FROM TEMPLATE build/templates/permissions/permissions.sql.tmpl
 * ALL DIRECT MODIFICATIONS WILL BE LOST WITH THE NEXT BUILD PROCESS!!!
 */

/*
-- If this is the first time you execute the script, uncomment these lines
-- to create table and insert row
CREATE TABLE IF NOT EXISTS permissions (
    rules json NOT NULL
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.permissions OWNER TO glab;

INSERT INTO permissions VALUES ('{"admin":{}}');
*/

UPDATE permissions SET rules = '{
	"admin":{
		"Event":{
			"subscribe":true
			,"unsubscribe":true
			,"publish":true
		}
		,"Constant":{
			"set_value":true
			,"get_list":true
			,"get_object":true
			,"get_values":true
		}
		,"Enum":{
			"get_enum_list":true
		}
		,"MainMenuConstructor":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MainMenuContent":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"View":{
			"get_list":true
			,"complete":true
			,"get_section_list":true
		}
		,"VariantStorage":{
			"insert":true
			,"upsert_filter_data":true
			,"upsert_col_visib_data":true
			,"upsert_col_order_data":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_filter_data":true
			,"get_col_visib_data":true
			,"get_col_order_data":true
		}
		,"About":{
			"get_object":true
		}
		,"Service":{
			"reload_config":true
			,"reload_version":true
		}
		,"User":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
			,"get_profile":true
			,"reset_pwd":true
			,"login":true
			,"login_refresh":true
			,"logout":true
			,"logout_html":true
			,"download_photo":true
			,"delete_photo":true
			,"password_recover":true
		}
		,"Login":{
			"get_list":true
			,"get_object":true
			,"logout":true
		}
		,"LoginDevice":{
			"get_list":true
			,"switch_banned":true
		}
		,"Captcha":{
			"get":true
		}
		,"LoginDeviceBan":{
			"insert":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"TimeZoneLocale":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Department":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Post":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Contact":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
			,"upsert":true
		}
		,"EntityContact":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ObjectModLog":{
			"get_list":true
			,"get_object":true
		}
		,"MailMessage":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MailMessageAttachment":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MailTemplate":{
			"insert":true
			,"update":true
			,"get_list":true
			,"get_object":true
		}
		,"Attachment":{
			"get_list":true
			,"get_object":true
			,"delete_file":true
			,"get_file":true
			,"add_file":true
		}
		,"AutoMake":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"AutoModel":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_make":true
			,"get_all_years":true
		}
		,"AutoModelGeneration":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_model":true
			,"gen_next_id":true
		}
		,"AutoType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"AutoBodyType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoBodyDoor":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoBody":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_model_generation":true
			,"complete_for_model":true
		}
		,"ItemFolder":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemFeature":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemFeatureValueList":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItemFeatureValueList":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFeatureGroupItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFolderFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItemFolderFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Item":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_item":true
			,"complete":true
			,"set_feature":true
			,"get_features_filter_list":true
		}
		,"Manufacturer":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ManufacturerBrand":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Supplier":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"VehicleType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemPriority":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"PopularityType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"import":true
			,"set_feature":true
			,"get_features_filter_list":true
		}
		,"ItemSearch":{
			"get_object":true
			,"find_items":true
		}
		,"ImportItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierStore":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_supplier":true
		}
		,"SupplierStoreValue":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoPriceCategory":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoToGlassMatchHead":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoToGlassMatchEurocode":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_body_list":true
		}
		,"AutoToGlassMatchOption":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_conf_form":true
		}
		,"AutoModelGenerationBody":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"BankCard":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Employee":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"EmployeeStatus":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"PersonDocument":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"PersonDocumentType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"CashLocation":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"FinExpenseType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_item_list":true
			,"get_object":true
			,"complete":true
			,"verify_rule":true
		}
		,"CashFlowIn":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_report":true
		}
		,"CashFlowOut":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"CashFlowTransfer":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Firm":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Bank":{
			"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"BankAccount":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"BankFlowIn":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"import_from_bank":true
			,"get_report":true
		}
		,"BankFlowOut":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"UserOperation":{
			"get_object":true
			,"delete":true
		}
	}
	,"guest":{
		"User":{
			"login":true
		}
	}
}';


-- ******************* update 03/06/2024 09:26:41 ******************
	
	-- Adding menu item
	update views set f='get_item_list' where id='10031'



-- ******************* update 03/06/2024 09:35:27 ******************

	-- Adding new type
	CREATE TYPE cash_flow_income_type AS ENUM (
	
		'cash'			
	,
		'bank'			
				
	);
	ALTER TYPE cash_flow_income_type OWNER TO glab;
		
	/* type get function */
	CREATE OR REPLACE FUNCTION enum_cash_flow_income_type_val(cash_flow_income_type,locales)
	RETURNS text AS $$
		SELECT
		CASE
		WHEN $1='cash'::cash_flow_income_type AND $2='ru'::locales THEN 'нал'
		WHEN $1='bank'::cash_flow_income_type AND $2='ru'::locales THEN 'безнал'
		ELSE ''
		END;		
	$$ LANGUAGE sql;	
	ALTER FUNCTION enum_cash_flow_income_type_val(cash_flow_income_type,locales) OWNER TO glab;		
	

-- ******************* update 03/06/2024 09:38:03 ******************
drop type cash_flow_income_type cascade;
/*
	-- Adding new type
	CREATE TYPE cash_flow_income_types AS ENUM (
	
		'cash'			
	,
		'bank'			
				
	);
	ALTER TYPE cash_flow_income_type OWNER TO glab;
		
	/* type get function */
	CREATE OR REPLACE FUNCTION enum_cash_flow_income_type_val(cash_flow_income_type,locales)
	RETURNS text AS $$
		SELECT
		CASE
		WHEN $1='cash'::cash_flow_income_type AND $2='ru'::locales THEN 'нал'
		WHEN $1='bank'::cash_flow_income_type AND $2='ru'::locales THEN 'безнал'
		ELSE ''
		END;		
	$$ LANGUAGE sql;	
	ALTER FUNCTION enum_cash_flow_income_type_val(cash_flow_income_type,locales) OWNER TO glab;		
	*/


-- ******************* update 03/06/2024 09:42:46 ******************
	/* type get function */
	CREATE OR REPLACE FUNCTION enum_cash_flow_income_types_val(cash_flow_income_types,locales)
	RETURNS text AS $$
		SELECT
		CASE
		WHEN $1='cash'::cash_flow_income_types AND $2='ru'::locales THEN 'нал'
		WHEN $1='bank'::cash_flow_income_types AND $2='ru'::locales THEN 'безнал'
		ELSE ''
		END;		
	$$ LANGUAGE sql;	
	ALTER FUNCTION enum_cash_flow_income_types_val(cash_flow_income_types,locales) OWNER TO glab;		
	


-- ******************* update 03/06/2024 09:51:25 ******************
	
		ALTER TABLE public.cash_flow_in ADD COLUMN cash_flow_income_type cash_flow_income_types NOT NULL,ADD COLUMN income_source text;



-- ******************* update 03/06/2024 09:51:32 ******************
-- VIEW: public.cash_flow_in_list

--DROP VIEW public.cash_flow_in_list;

CREATE OR REPLACE VIEW public.cash_flow_in_list AS
	SELECT
		t.id
		,t.date_time
		,t.cash_location_id
		,cash_locations_ref(cash_locations_ref_t) AS cash_locations_ref
		,t.comment_text
		,users_ref(users_ref_t) AS users_ref
		,t.total
		,t.cash_flow_income_type
		,t.income_source
	FROM public.cash_flow_in AS t
	LEFT JOIN cash_locations AS cash_locations_ref_t ON cash_locations_ref_t.id = t.cash_location_id
	LEFT JOIN users AS users_ref_t ON users_ref_t.id = t.user_id
	ORDER BY t.date_time DESC
	;
	
ALTER VIEW public.cash_flow_in_list OWNER TO glab;


-- ******************* update 03/06/2024 14:30:48 ******************
﻿-- Function: bank_flow_out_apply_rules()

-- DROP FUNCTION bank_flow_out_apply_rules();

CREATE OR REPLACE FUNCTION bank_flow_out_apply_rules()
  RETURNS void AS
$$
DECLARE
	doc_cursor CURSOR FOR
	        SELECT
	        	id,
	        	pay_comment
	        FROM bank_flow_out
	        WHERE fin_expense_type1_id IS NULL;
	doc_row RECORD;
	exp_id int;
	exp_parent_id int;
BEGIN
	OPEN doc_cursor;

	LOOP
		FETCH doc_cursor INTO doc_row;
		EXIT WHEN NOT FOUND;
		
		SELECT
			id,
			parent_id
		INTO
			exp_id,
			exp_parent_id
		FROM bank_flow_out_find_expense_type(doc_row.pay_comment);
		
		IF exp_id IS NOT NULL THEN
			UPDATE bank_flow_out
			SET
				fin_expense_type1_id = exp_parent_id,
				fin_expense_type2_id = exp_id
			WHERE id = doc_row.id;
		END IF;
	END LOOP;
	
	CLOSE doc_cursor;

END;
$$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION bank_flow_out_apply_rules() OWNER TO glab;


-- ******************* update 03/06/2024 14:32:03 ******************
﻿-- Function: bank_flow_out_apply_rules()

-- DROP FUNCTION bank_flow_out_apply_rules();

CREATE OR REPLACE FUNCTION bank_flow_out_apply_rules()
  RETURNS int AS
$$
DECLARE
	doc_cursor CURSOR FOR
	        SELECT
	        	id,
	        	pay_comment
	        FROM bank_flow_out
	        WHERE fin_expense_type1_id IS NULL;
	doc_row RECORD;
	exp_id int;
	exp_parent_id int;
	cnt int;
BEGIN
	OPEN doc_cursor;

	LOOP
		FETCH doc_cursor INTO doc_row;
		EXIT WHEN NOT FOUND;
		
		SELECT
			id,
			parent_id
		INTO
			exp_id,
			exp_parent_id
		FROM bank_flow_out_find_expense_type(doc_row.pay_comment);
		
		IF exp_id IS NOT NULL THEN
			UPDATE bank_flow_out
			SET
				fin_expense_type1_id = exp_parent_id,
				fin_expense_type2_id = exp_id
			WHERE id = doc_row.id;
			cnt = cnt + 1;
		END IF;
	END LOOP;
	
	CLOSE doc_cursor;

END;
$$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION bank_flow_out_apply_rules() OWNER TO glab;


-- ******************* update 03/06/2024 14:32:29 ******************
﻿-- Function: bank_flow_out_apply_rules()

-- DROP FUNCTION bank_flow_out_apply_rules();

CREATE OR REPLACE FUNCTION bank_flow_out_apply_rules()
  RETURNS int AS
$$
DECLARE
	doc_cursor CURSOR FOR
	        SELECT
	        	id,
	        	pay_comment
	        FROM bank_flow_out
	        WHERE fin_expense_type1_id IS NULL;
	doc_row RECORD;
	exp_id int;
	exp_parent_id int;
	cnt int;
BEGIN
	cnt = 0;
	
	OPEN doc_cursor;
	LOOP
		FETCH doc_cursor INTO doc_row;
		EXIT WHEN NOT FOUND;
		
		SELECT
			id,
			parent_id
		INTO
			exp_id,
			exp_parent_id
		FROM bank_flow_out_find_expense_type(doc_row.pay_comment);
		
		IF exp_id IS NOT NULL THEN
			UPDATE bank_flow_out
			SET
				fin_expense_type1_id = exp_parent_id,
				fin_expense_type2_id = exp_id
			WHERE id = doc_row.id;
			cnt = cnt + 1;
		END IF;
	END LOOP;
	
	CLOSE doc_cursor;

	RETURN cnt;
END;
$$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION bank_flow_out_apply_rules() OWNER TO glab;


-- ******************* update 04/06/2024 09:24:34 ******************
/**
 * Andrey Mikhalevich 15/12/21
 * This file is part of the OSBE framework
 *
 * THIS FILE IS GENERATED FROM TEMPLATE build/templates/permissions/permissions.sql.tmpl
 * ALL DIRECT MODIFICATIONS WILL BE LOST WITH THE NEXT BUILD PROCESS!!!
 */

/*
-- If this is the first time you execute the script, uncomment these lines
-- to create table and insert row
CREATE TABLE IF NOT EXISTS permissions (
    rules json NOT NULL
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.permissions OWNER TO glab;

INSERT INTO permissions VALUES ('{"admin":{}}');
*/

UPDATE permissions SET rules = '{
	"admin":{
		"Event":{
			"subscribe":true
			,"unsubscribe":true
			,"publish":true
		}
		,"Constant":{
			"set_value":true
			,"get_list":true
			,"get_object":true
			,"get_values":true
		}
		,"Enum":{
			"get_enum_list":true
		}
		,"MainMenuConstructor":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MainMenuContent":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"View":{
			"get_list":true
			,"complete":true
			,"get_section_list":true
		}
		,"VariantStorage":{
			"insert":true
			,"upsert_filter_data":true
			,"upsert_col_visib_data":true
			,"upsert_col_order_data":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_filter_data":true
			,"get_col_visib_data":true
			,"get_col_order_data":true
		}
		,"About":{
			"get_object":true
		}
		,"Service":{
			"reload_config":true
			,"reload_version":true
		}
		,"User":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
			,"get_profile":true
			,"reset_pwd":true
			,"login":true
			,"login_refresh":true
			,"logout":true
			,"logout_html":true
			,"download_photo":true
			,"delete_photo":true
			,"password_recover":true
		}
		,"Login":{
			"get_list":true
			,"get_object":true
			,"logout":true
		}
		,"LoginDevice":{
			"get_list":true
			,"switch_banned":true
		}
		,"Captcha":{
			"get":true
		}
		,"LoginDeviceBan":{
			"insert":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"TimeZoneLocale":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Department":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Post":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Contact":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
			,"upsert":true
		}
		,"EntityContact":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ObjectModLog":{
			"get_list":true
			,"get_object":true
		}
		,"MailMessage":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MailMessageAttachment":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MailTemplate":{
			"insert":true
			,"update":true
			,"get_list":true
			,"get_object":true
		}
		,"Attachment":{
			"get_list":true
			,"get_object":true
			,"delete_file":true
			,"get_file":true
			,"add_file":true
		}
		,"AutoMake":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"AutoModel":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_make":true
			,"get_all_years":true
		}
		,"AutoModelGeneration":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_model":true
			,"gen_next_id":true
		}
		,"AutoType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"AutoBodyType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoBodyDoor":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoBody":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_model_generation":true
			,"complete_for_model":true
		}
		,"ItemFolder":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemFeature":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemFeatureValueList":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItemFeatureValueList":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFeatureGroupItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFolderFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItemFolderFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Item":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_item":true
			,"complete":true
			,"set_feature":true
			,"get_features_filter_list":true
		}
		,"Manufacturer":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ManufacturerBrand":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Supplier":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"VehicleType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemPriority":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"PopularityType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"import":true
			,"set_feature":true
			,"get_features_filter_list":true
		}
		,"ItemSearch":{
			"get_object":true
			,"find_items":true
		}
		,"ImportItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierStore":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_supplier":true
		}
		,"SupplierStoreValue":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoPriceCategory":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoToGlassMatchHead":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoToGlassMatchEurocode":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_body_list":true
		}
		,"AutoToGlassMatchOption":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_conf_form":true
		}
		,"AutoModelGenerationBody":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"BankCard":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Employee":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"EmployeeStatus":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"PersonDocument":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"PersonDocumentType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"CashLocation":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"FinExpenseType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_item_list":true
			,"get_object":true
			,"complete":true
			,"verify_rule":true
		}
		,"CashFlowIn":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_report":true
		}
		,"CashFlowOut":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"CashFlowTransfer":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Firm":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Bank":{
			"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"BankAccount":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"BankFlowIn":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"import_from_bank":true
			,"get_report":true
			,"apply_rules":true
		}
		,"BankFlowOut":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"UserOperation":{
			"get_object":true
			,"delete":true
		}
	}
	,"guest":{
		"User":{
			"login":true
		}
	}
}';


-- ******************* update 04/06/2024 10:19:11 ******************

		UPDATE views SET
			c=NULL,
			f=NULL,
			t='BankUpload',
			section='Формы',
			descr='Импорт выписки',
			limited=FALSE
		WHERE id='20003';
	
	
	-- Adding menu item
	INSERT INTO views
	(id,c,f,t,section,descr,limited)
	VALUES (
	'20004',
	NULL,
	NULL,
	'CashFlowInOut',
	'Формы',
	'Касса',
	FALSE
	);
	
	

-- ******************* update 05/06/2024 11:41:52 ******************

					ALTER TYPE role_types ADD VALUE 'accountant';
					
	/* type get function */
	CREATE OR REPLACE FUNCTION enum_role_types_val(role_types,locales)
	RETURNS text AS $$
		SELECT
		CASE
		WHEN $1='admin'::role_types AND $2='ru'::locales THEN 'Администратор'
		WHEN $1='accountant'::role_types AND $2='ru'::locales THEN 'Бухгалтер'
		ELSE ''
		END;		
	$$ LANGUAGE sql;	
	ALTER FUNCTION enum_role_types_val(role_types,locales) OWNER TO glab;		
	

-- ******************* update 05/06/2024 11:42:27 ******************
/**
 * Andrey Mikhalevich 15/12/21
 * This file is part of the OSBE framework
 *
 * THIS FILE IS GENERATED FROM TEMPLATE build/templates/permissions/permissions.sql.tmpl
 * ALL DIRECT MODIFICATIONS WILL BE LOST WITH THE NEXT BUILD PROCESS!!!
 */

/*
-- If this is the first time you execute the script, uncomment these lines
-- to create table and insert row
CREATE TABLE IF NOT EXISTS permissions (
    rules json NOT NULL
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.permissions OWNER TO glab;

INSERT INTO permissions VALUES ('{"admin":{}}');
*/

UPDATE permissions SET rules = '{
	"admin":{
		"Event":{
			"subscribe":true
			,"unsubscribe":true
			,"publish":true
		}
		,"Constant":{
			"set_value":true
			,"get_list":true
			,"get_object":true
			,"get_values":true
		}
		,"Enum":{
			"get_enum_list":true
		}
		,"MainMenuConstructor":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MainMenuContent":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"View":{
			"get_list":true
			,"complete":true
			,"get_section_list":true
		}
		,"VariantStorage":{
			"insert":true
			,"upsert_filter_data":true
			,"upsert_col_visib_data":true
			,"upsert_col_order_data":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_filter_data":true
			,"get_col_visib_data":true
			,"get_col_order_data":true
		}
		,"About":{
			"get_object":true
		}
		,"Service":{
			"reload_config":true
			,"reload_version":true
		}
		,"User":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
			,"get_profile":true
			,"reset_pwd":true
			,"login":true
			,"login_refresh":true
			,"logout":true
			,"logout_html":true
			,"download_photo":true
			,"delete_photo":true
			,"password_recover":true
		}
		,"Login":{
			"get_list":true
			,"get_object":true
			,"logout":true
		}
		,"LoginDevice":{
			"get_list":true
			,"switch_banned":true
		}
		,"Captcha":{
			"get":true
		}
		,"LoginDeviceBan":{
			"insert":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"TimeZoneLocale":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Department":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Post":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Contact":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
			,"upsert":true
		}
		,"EntityContact":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ObjectModLog":{
			"get_list":true
			,"get_object":true
		}
		,"MailMessage":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MailMessageAttachment":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MailTemplate":{
			"insert":true
			,"update":true
			,"get_list":true
			,"get_object":true
		}
		,"Attachment":{
			"get_list":true
			,"get_object":true
			,"delete_file":true
			,"get_file":true
			,"add_file":true
		}
		,"AutoMake":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"AutoModel":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_make":true
			,"get_all_years":true
		}
		,"AutoModelGeneration":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_model":true
			,"gen_next_id":true
		}
		,"AutoType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"AutoBodyType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoBodyDoor":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoBody":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_model_generation":true
			,"complete_for_model":true
		}
		,"ItemFolder":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemFeature":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemFeatureValueList":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItemFeatureValueList":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFeatureGroupItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFolderFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItemFolderFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Item":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_item":true
			,"complete":true
			,"set_feature":true
			,"get_features_filter_list":true
		}
		,"Manufacturer":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ManufacturerBrand":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Supplier":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"VehicleType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemPriority":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"PopularityType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"import":true
			,"set_feature":true
			,"get_features_filter_list":true
		}
		,"ItemSearch":{
			"get_object":true
			,"find_items":true
		}
		,"ImportItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierStore":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_supplier":true
		}
		,"SupplierStoreValue":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoPriceCategory":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoToGlassMatchHead":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoToGlassMatchEurocode":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_body_list":true
		}
		,"AutoToGlassMatchOption":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_conf_form":true
		}
		,"AutoModelGenerationBody":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"BankCard":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Employee":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"EmployeeStatus":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"PersonDocument":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"PersonDocumentType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"CashLocation":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"FinExpenseType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_item_list":true
			,"get_object":true
			,"complete":true
			,"verify_rule":true
		}
		,"CashFlowIn":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_report":true
		}
		,"CashFlowOut":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"CashFlowTransfer":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Firm":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Bank":{
			"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"BankAccount":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"BankFlowIn":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"import_from_bank":true
			,"get_report":true
			,"apply_rules":true
		}
		,"BankFlowOut":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"UserOperation":{
			"get_object":true
			,"delete":true
		}
	}
	,"accountant":{
		"Event":{
			"subscribe":true
			,"unsubscribe":true
			,"publish":true
		}
		,"Constant":{
			"set_value":true
			,"get_list":true
			,"get_object":true
			,"get_values":true
		}
		,"Enum":{
			"get_enum_list":true
		}
		,"MainMenuConstructor":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MainMenuContent":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"View":{
			"get_list":true
			,"complete":true
			,"get_section_list":true
		}
		,"VariantStorage":{
			"insert":true
			,"upsert_filter_data":true
			,"upsert_col_visib_data":true
			,"upsert_col_order_data":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_filter_data":true
			,"get_col_visib_data":true
			,"get_col_order_data":true
		}
		,"About":{
			"get_object":true
		}
		,"Service":{
			"reload_config":true
			,"reload_version":true
		}
		,"User":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
			,"get_profile":true
			,"reset_pwd":true
			,"login":true
			,"login_refresh":true
			,"logout":true
			,"logout_html":true
			,"download_photo":true
			,"delete_photo":true
			,"password_recover":true
		}
		,"Login":{
			"get_list":true
			,"get_object":true
			,"logout":true
		}
		,"LoginDevice":{
			"get_list":true
			,"switch_banned":true
		}
		,"Captcha":{
			"get":true
		}
		,"LoginDeviceBan":{
			"insert":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"TimeZoneLocale":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Department":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Post":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Contact":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
			,"upsert":true
		}
		,"EntityContact":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ObjectModLog":{
			"get_list":true
			,"get_object":true
		}
		,"MailMessage":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MailMessageAttachment":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MailTemplate":{
			"insert":true
			,"update":true
			,"get_list":true
			,"get_object":true
		}
		,"Attachment":{
			"get_list":true
			,"get_object":true
			,"delete_file":true
			,"get_file":true
			,"add_file":true
		}
		,"AutoMake":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"AutoModel":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_make":true
			,"get_all_years":true
		}
		,"AutoModelGeneration":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_model":true
			,"gen_next_id":true
		}
		,"AutoType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"AutoBodyType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoBodyDoor":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoBody":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_model_generation":true
			,"complete_for_model":true
		}
		,"ItemFolder":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemFeature":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemFeatureValueList":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItemFeatureValueList":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFeatureGroupItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFolderFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItemFolderFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Item":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_item":true
			,"complete":true
			,"set_feature":true
			,"get_features_filter_list":true
		}
		,"Manufacturer":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ManufacturerBrand":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Supplier":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"VehicleType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemPriority":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"PopularityType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"import":true
			,"set_feature":true
			,"get_features_filter_list":true
		}
		,"ItemSearch":{
			"get_object":true
			,"find_items":true
		}
		,"ImportItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierStore":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_supplier":true
		}
		,"SupplierStoreValue":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoPriceCategory":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoToGlassMatchHead":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoToGlassMatchEurocode":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_body_list":true
		}
		,"AutoToGlassMatchOption":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_conf_form":true
		}
		,"AutoModelGenerationBody":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"BankCard":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Employee":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"EmployeeStatus":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"PersonDocument":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"PersonDocumentType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"CashLocation":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"FinExpenseType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_item_list":true
			,"get_object":true
			,"complete":true
			,"verify_rule":true
		}
		,"CashFlowIn":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_report":true
		}
		,"CashFlowOut":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"CashFlowTransfer":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Firm":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Bank":{
			"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"BankAccount":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"BankFlowIn":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"import_from_bank":true
			,"get_report":true
			,"apply_rules":true
		}
		,"BankFlowOut":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"UserOperation":{
			"get_object":true
			,"delete":true
		}
	}
	,"guest":{
		"User":{
			"login":true
		}
	}
}';


-- ******************* update 13/06/2024 08:09:24 ******************

	
	-- ********** Adding new table from model **********
	CREATE TABLE public.cash_income_sources
	(id serial NOT NULL,name text,cash_location_id int REFERENCES cash_locations(id),CONSTRAINT cash_income_sources_pkey PRIMARY KEY (id)
	);
	
	ALTER TABLE public.cash_income_sources OWNER TO glab;



-- ******************* update 13/06/2024 08:10:39 ******************

	
	-- Adding menu item
	INSERT INTO views
	(id,c,f,t,section,descr,limited)
	VALUES (
	'10032',
	'CashIncomeSource_Controller',
	'get_list',
	'CashIncomeSourceList',
	'Справочники',
	'Источники поступлений наличных',
	FALSE
	);
	
	

-- ******************* update 13/06/2024 08:29:16 ******************
/**
 * Andrey Mikhalevich 15/12/21
 * This file is part of the OSBE framework
 *
 * THIS FILE IS GENERATED FROM TEMPLATE build/templates/permissions/permissions.sql.tmpl
 * ALL DIRECT MODIFICATIONS WILL BE LOST WITH THE NEXT BUILD PROCESS!!!
 */

/*
-- If this is the first time you execute the script, uncomment these lines
-- to create table and insert row
CREATE TABLE IF NOT EXISTS permissions (
    rules json NOT NULL
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.permissions OWNER TO glab;

INSERT INTO permissions VALUES ('{"admin":{}}');
*/

UPDATE permissions SET rules = '{
	"admin":{
		"Event":{
			"subscribe":true
			,"unsubscribe":true
			,"publish":true
		}
		,"Constant":{
			"set_value":true
			,"get_list":true
			,"get_object":true
			,"get_values":true
		}
		,"Enum":{
			"get_enum_list":true
		}
		,"MainMenuConstructor":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MainMenuContent":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"View":{
			"get_list":true
			,"complete":true
			,"get_section_list":true
		}
		,"VariantStorage":{
			"insert":true
			,"upsert_filter_data":true
			,"upsert_col_visib_data":true
			,"upsert_col_order_data":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_filter_data":true
			,"get_col_visib_data":true
			,"get_col_order_data":true
		}
		,"About":{
			"get_object":true
		}
		,"Service":{
			"reload_config":true
			,"reload_version":true
		}
		,"User":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
			,"get_profile":true
			,"reset_pwd":true
			,"login":true
			,"login_refresh":true
			,"logout":true
			,"logout_html":true
			,"download_photo":true
			,"delete_photo":true
			,"password_recover":true
		}
		,"Login":{
			"get_list":true
			,"get_object":true
			,"logout":true
		}
		,"LoginDevice":{
			"get_list":true
			,"switch_banned":true
		}
		,"Captcha":{
			"get":true
		}
		,"LoginDeviceBan":{
			"insert":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"TimeZoneLocale":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Department":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Post":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Contact":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
			,"upsert":true
		}
		,"EntityContact":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ObjectModLog":{
			"get_list":true
			,"get_object":true
		}
		,"MailMessage":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MailMessageAttachment":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MailTemplate":{
			"insert":true
			,"update":true
			,"get_list":true
			,"get_object":true
		}
		,"Attachment":{
			"get_list":true
			,"get_object":true
			,"delete_file":true
			,"get_file":true
			,"add_file":true
		}
		,"AutoMake":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"AutoModel":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_make":true
			,"get_all_years":true
		}
		,"AutoModelGeneration":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_model":true
			,"gen_next_id":true
		}
		,"AutoType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"AutoBodyType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoBodyDoor":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoBody":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_model_generation":true
			,"complete_for_model":true
		}
		,"ItemFolder":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemFeature":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemFeatureValueList":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItemFeatureValueList":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFeatureGroupItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFolderFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItemFolderFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Item":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_item":true
			,"complete":true
			,"set_feature":true
			,"get_features_filter_list":true
		}
		,"Manufacturer":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ManufacturerBrand":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Supplier":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"VehicleType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemPriority":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"PopularityType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"import":true
			,"set_feature":true
			,"get_features_filter_list":true
		}
		,"ItemSearch":{
			"get_object":true
			,"find_items":true
		}
		,"ImportItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierStore":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_supplier":true
		}
		,"SupplierStoreValue":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoPriceCategory":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoToGlassMatchHead":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoToGlassMatchEurocode":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_body_list":true
		}
		,"AutoToGlassMatchOption":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_conf_form":true
		}
		,"AutoModelGenerationBody":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"BankCard":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Employee":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"EmployeeStatus":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"PersonDocument":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"PersonDocumentType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"CashLocation":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"FinExpenseType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_item_list":true
			,"get_object":true
			,"complete":true
			,"verify_rule":true
		}
		,"CashFlowIn":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_report":true
		}
		,"CashIncomeSource":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"CashFlowOut":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"CashFlowTransfer":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Firm":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Bank":{
			"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"BankAccount":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"BankFlowIn":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"import_from_bank":true
			,"get_report":true
			,"apply_rules":true
		}
		,"BankFlowOut":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"UserOperation":{
			"get_object":true
			,"delete":true
		}
	}
	,"accountant":{
		"Event":{
			"subscribe":true
			,"unsubscribe":true
			,"publish":true
		}
		,"Constant":{
			"set_value":true
			,"get_list":true
			,"get_object":true
			,"get_values":true
		}
		,"Enum":{
			"get_enum_list":true
		}
		,"MainMenuConstructor":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MainMenuContent":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"View":{
			"get_list":true
			,"complete":true
			,"get_section_list":true
		}
		,"VariantStorage":{
			"insert":true
			,"upsert_filter_data":true
			,"upsert_col_visib_data":true
			,"upsert_col_order_data":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_filter_data":true
			,"get_col_visib_data":true
			,"get_col_order_data":true
		}
		,"About":{
			"get_object":true
		}
		,"Service":{
			"reload_config":true
			,"reload_version":true
		}
		,"User":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
			,"get_profile":true
			,"reset_pwd":true
			,"login":true
			,"login_refresh":true
			,"logout":true
			,"logout_html":true
			,"download_photo":true
			,"delete_photo":true
			,"password_recover":true
		}
		,"Login":{
			"get_list":true
			,"get_object":true
			,"logout":true
		}
		,"LoginDevice":{
			"get_list":true
			,"switch_banned":true
		}
		,"Captcha":{
			"get":true
		}
		,"LoginDeviceBan":{
			"insert":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"TimeZoneLocale":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Department":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Post":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Contact":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
			,"upsert":true
		}
		,"EntityContact":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ObjectModLog":{
			"get_list":true
			,"get_object":true
		}
		,"MailMessage":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MailMessageAttachment":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"MailTemplate":{
			"insert":true
			,"update":true
			,"get_list":true
			,"get_object":true
		}
		,"Attachment":{
			"get_list":true
			,"get_object":true
			,"delete_file":true
			,"get_file":true
			,"add_file":true
		}
		,"AutoMake":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"AutoModel":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_make":true
			,"get_all_years":true
		}
		,"AutoModelGeneration":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_model":true
			,"gen_next_id":true
		}
		,"AutoType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"AutoBodyType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoBodyDoor":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoBody":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_model_generation":true
			,"complete_for_model":true
		}
		,"ItemFolder":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemFeature":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemFeatureValueList":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItemFeatureValueList":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFeatureGroupItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"ItemFolderFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItemFolderFeatureGroup":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Item":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_item":true
			,"complete":true
			,"set_feature":true
			,"get_features_filter_list":true
		}
		,"Manufacturer":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ManufacturerBrand":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"Supplier":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"VehicleType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"ItemPriority":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"PopularityType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"import":true
			,"set_feature":true
			,"get_features_filter_list":true
		}
		,"ItemSearch":{
			"get_object":true
			,"find_items":true
		}
		,"ImportItem":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"SupplierStore":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete_for_supplier":true
		}
		,"SupplierStoreValue":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoPriceCategory":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoToGlassMatchHead":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"AutoToGlassMatchEurocode":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_body_list":true
		}
		,"AutoToGlassMatchOption":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_conf_form":true
		}
		,"AutoModelGenerationBody":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"BankCard":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Employee":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"EmployeeStatus":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"PersonDocument":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"PersonDocumentType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"CashLocation":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"FinExpenseType":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_item_list":true
			,"get_object":true
			,"complete":true
			,"verify_rule":true
		}
		,"CashFlowIn":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"get_report":true
		}
		,"CashIncomeSource":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"CashFlowOut":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"CashFlowTransfer":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Firm":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"Bank":{
			"get_list":true
			,"get_object":true
			,"complete":true
		}
		,"BankAccount":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"BankFlowIn":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
			,"import_from_bank":true
			,"get_report":true
			,"apply_rules":true
		}
		,"BankFlowOut":{
			"insert":true
			,"update":true
			,"delete":true
			,"get_list":true
			,"get_object":true
		}
		,"UserOperation":{
			"get_object":true
			,"delete":true
		}
	}
	,"guest":{
		"User":{
			"login":true
		}
	}
}';


-- ******************* update 13/06/2024 08:39:45 ******************
CREATE OR REPLACE FUNCTION cash_income_sources_ref(cash_income_sources)
  RETURNS json AS
$$
	SELECT json_build_object(
		'keys',json_build_object(
			'id',$1.id    
			),	
		'descr',$1.name,
		'dataType','cash_income_sources'
	);
$$
  LANGUAGE sql VOLATILE COST 100;
ALTER FUNCTION cash_income_sources_ref(cash_income_sources) OWNER TO glab;	
	



-- ******************* update 13/06/2024 08:40:17 ******************
-- VIEW: public.cash_flow_in_list

DROP VIEW public.cash_flow_in_list;

CREATE OR REPLACE VIEW public.cash_flow_in_list AS
	SELECT
		t.id
		,t.date_time
		,t.cash_location_id
		,cash_income_sources_ref(cash_income_sources_ref_t) AS cash_income_sources_ref
		,t.comment_text
		,users_ref(users_ref_t) AS users_ref
		,t.total
		,t.cash_flow_income_type
		,t.income_source
	FROM public.cash_flow_in AS t
	LEFT JOIN cash_income_sources AS cash_income_sources_ref_t ON cash_income_sources_ref_t.id = t.cash_location_id
	LEFT JOIN users AS users_ref_t ON users_ref_t.id = t.user_id
	ORDER BY t.date_time DESC
	;
	
ALTER VIEW public.cash_flow_in_list OWNER TO glab;


-- ******************* update 13/06/2024 08:50:16 ******************
-- VIEW: public.cash_flow_in_list

DROP VIEW public.cash_flow_in_list;

CREATE OR REPLACE VIEW public.cash_flow_in_list AS
	SELECT
		t.id
		,t.date_time
		,t.cash_location_id
		,cash_locations_ref(cash_locations_ref_t) AS cash_locations_ref
		,t.comment_text
		,users_ref(users_ref_t) AS users_ref
		,t.total
		,t.cash_flow_income_type
		,cash_income_sources_ref(cash_income_sources_ref_t) AS cash_income_sources_ref
	FROM public.cash_flow_in AS t
	LEFT JOIN cash_locations AS cash_locations_ref_t ON cash_locations_ref_t.id = t.cash_location_id
	LEFT JOIN cash_income_sources AS cash_income_sources_ref_t ON cash_income_sources_ref_t.id = t.cash_location_id
	LEFT JOIN users AS users_ref_t ON users_ref_t.id = t.user_id
	ORDER BY t.date_time DESC
	;
	
ALTER VIEW public.cash_flow_in_list OWNER TO glab;


-- ******************* update 13/06/2024 09:46:34 ******************
-- VIEW: public.cash_flow_in_list

DROP VIEW public.cash_flow_in_list;

CREATE OR REPLACE VIEW public.cash_flow_in_list AS
	SELECT
		t.id
		,t.date_time
		,t.cash_location_id
		,cash_locations_ref(cash_locations_ref_t) AS cash_locations_ref
		,t.comment_text
		,users_ref(users_ref_t) AS users_ref
		,t.total
		,t.cash_flow_income_type
		,cash_income_sources_ref(cash_income_sources_ref_t) AS cash_income_sources_ref
	FROM public.cash_flow_in AS t
	LEFT JOIN cash_locations AS cash_locations_ref_t ON cash_locations_ref_t.id = t.cash_location_id
	LEFT JOIN cash_income_sources AS cash_income_sources_ref_t ON cash_income_sources_ref_t.id = t.cash_income_source_id
	LEFT JOIN users AS users_ref_t ON users_ref_t.id = t.user_id
	ORDER BY t.date_time DESC
	;
	
ALTER VIEW public.cash_flow_in_list OWNER TO glab;


-- ******************* update 13/06/2024 10:17:00 ******************
-- Function: public.cash_flow_in_process()

-- DROP FUNCTION public.cash_flow_in_process();

CREATE OR REPLACE FUNCTION public.cash_flow_in_process()
  RETURNS trigger AS
$BODY$
DECLARE
	reg_act ra_cash_flow%ROWTYPE;
	v_cash_location_id int;
BEGIN
	IF (TG_WHEN='BEFORE' AND TG_OP='INSERT') THEN
		--IF NEW.date_time < '2024-01-01T00:00:00'::timestamp THEN
		--	RAISE EXCEPTION 'Дата запрета редактирования: %', '2024-01-01T00:00:00'::timestamp;
		--END IF;
		
		RETURN NEW;
		
	ELSIF (TG_WHEN='AFTER') AND (TG_OP='INSERT' OR TG_OP='UPDATE') THEN					
		IF (TG_OP='INSERT') THEN						
			--log
			PERFORM doc_log_insert('cash_flow_in'::doc_types,NEW.id,NEW.date_time);
		END IF;

		--register actions ra_cash_flow
		reg_act.date_time		= NEW.date_time;
		reg_act.deb			= true;
		reg_act.doc_type  		= 'cash_flow_in'::doc_types;
		reg_act.doc_id  		= NEW.id;
		reg_act.cash_location_id	= NEW.cash_location_id;
		reg_act.total			= NEW.total;
		PERFORM ra_cash_flow_add_act(reg_act);	
		
		--if source location is defined - make out movements
		SELECT
			src.cash_location_id
		INTO
			v_cash_location_id
		FROM cash_income_sources AS src
		WHERE src.id = NEW.cash_income_source;
		
		IF v_cash_location_id IS NOT NULL THEN
			reg_act.date_time		= NEW.date_time;
			reg_act.deb			= false;
			reg_act.doc_type  		= 'cash_flow_in'::doc_types;
			reg_act.doc_id  		= NEW.id;
			reg_act.cash_location_id	= v_cash_location_id;
			reg_act.total			= NEW.total;
			PERFORM ra_cash_flow_add_act(reg_act);			
		END IF;
		
		RETURN NEW;
		
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='UPDATE') THEN
		--IF NEW.date_time < '2024-01-01T00:00:00'::timestamp THEN
		--	RAISE EXCEPTION 'Дата запрета редактирования: %', '2024-01-01T00:00:00'::timestamp;
		--END IF;
	
		PERFORM ra_cash_flow_remove_acts('cash_flow_in'::doc_types,OLD.id);

		-- Временно!
		IF NEW.date_time<>OLD.date_time THEN
			PERFORM doc_log_update('cash_flow_in'::doc_types,NEW.id,NEW.date_time);
		END IF;
						
		RETURN NEW;
		
	ELSIF (TG_WHEN='AFTER' AND TG_OP='DELETE') THEN
	
		RETURN OLD;
		
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='DELETE') THEN
		--IF OLD.date_time < '2024-01-01T00:00:00'::timestamp THEN
		--	RAISE EXCEPTION 'Дата запрета редактирования: %', '2024-01-01T00:00:00'::timestamp;
		--END IF;
	
		--detail tables
		
		--register actions										
		PERFORM ra_cash_flow_remove_acts('cash_flow_in'::doc_types,OLD.id);
		
		--log
		PERFORM doc_log_delete('cash_flow_in'::doc_types,OLD.id);
		
		RETURN OLD;
	END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.cash_flow_in_process()
  OWNER TO glab;



-- ******************* update 13/06/2024 10:17:41 ******************
-- Function: public.cash_flow_in_process()

-- DROP FUNCTION public.cash_flow_in_process();

CREATE OR REPLACE FUNCTION public.cash_flow_in_process()
  RETURNS trigger AS
$BODY$
DECLARE
	reg_act ra_cash_flow%ROWTYPE;
	v_cash_location_id int;
BEGIN
	IF (TG_WHEN='BEFORE' AND TG_OP='INSERT') THEN
		--IF NEW.date_time < '2024-01-01T00:00:00'::timestamp THEN
		--	RAISE EXCEPTION 'Дата запрета редактирования: %', '2024-01-01T00:00:00'::timestamp;
		--END IF;
		
		RETURN NEW;
		
	ELSIF (TG_WHEN='AFTER') AND (TG_OP='INSERT' OR TG_OP='UPDATE') THEN					
		IF (TG_OP='INSERT') THEN						
			--log
			PERFORM doc_log_insert('cash_flow_in'::doc_types,NEW.id,NEW.date_time);
		END IF;

		--register actions ra_cash_flow
		reg_act.date_time		= NEW.date_time;
		reg_act.deb			= true;
		reg_act.doc_type  		= 'cash_flow_in'::doc_types;
		reg_act.doc_id  		= NEW.id;
		reg_act.cash_location_id	= NEW.cash_location_id;
		reg_act.total			= NEW.total;
		PERFORM ra_cash_flow_add_act(reg_act);	
		
		--if source location is defined - make out movements
		SELECT
			src.cash_location_id
		INTO
			v_cash_location_id
		FROM cash_income_sources AS src
		WHERE src.id = NEW.cash_income_source_id;
		
		IF v_cash_location_id IS NOT NULL THEN
			reg_act.date_time		= NEW.date_time;
			reg_act.deb			= false;
			reg_act.doc_type  		= 'cash_flow_in'::doc_types;
			reg_act.doc_id  		= NEW.id;
			reg_act.cash_location_id	= v_cash_location_id;
			reg_act.total			= NEW.total;
			PERFORM ra_cash_flow_add_act(reg_act);			
		END IF;
		
		RETURN NEW;
		
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='UPDATE') THEN
		--IF NEW.date_time < '2024-01-01T00:00:00'::timestamp THEN
		--	RAISE EXCEPTION 'Дата запрета редактирования: %', '2024-01-01T00:00:00'::timestamp;
		--END IF;
	
		PERFORM ra_cash_flow_remove_acts('cash_flow_in'::doc_types,OLD.id);

		-- Временно!
		IF NEW.date_time<>OLD.date_time THEN
			PERFORM doc_log_update('cash_flow_in'::doc_types,NEW.id,NEW.date_time);
		END IF;
						
		RETURN NEW;
		
	ELSIF (TG_WHEN='AFTER' AND TG_OP='DELETE') THEN
	
		RETURN OLD;
		
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='DELETE') THEN
		--IF OLD.date_time < '2024-01-01T00:00:00'::timestamp THEN
		--	RAISE EXCEPTION 'Дата запрета редактирования: %', '2024-01-01T00:00:00'::timestamp;
		--END IF;
	
		--detail tables
		
		--register actions										
		PERFORM ra_cash_flow_remove_acts('cash_flow_in'::doc_types,OLD.id);
		
		--log
		PERFORM doc_log_delete('cash_flow_in'::doc_types,OLD.id);
		
		RETURN OLD;
	END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.cash_flow_in_process()
  OWNER TO glab;



-- ******************* update 02/07/2024 10:10:49 ******************
-- FUNCTION: public.rg_cash_flow_update_periods(timestamp without time zone, integer, numeric)

-- DROP FUNCTION IF EXISTS public.rg_cash_flow_update_periods(timestamp without time zone, integer, numeric);

CREATE OR REPLACE FUNCTION public.rg_cash_flow_update_periods(
	in_date_time timestamp without time zone,
	in_cash_location_id integer,
	in_delta_total numeric)
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
	v_loop_rg_period timestamp;
	v_calc_interval interval;			  			
	CURRENT_BALANCE_DATE_TIME timestamp;
	CALC_DATE_TIME timestamp;
BEGIN
	CALC_DATE_TIME = rg_calc_period('cash_flow'::reg_types);
	v_loop_rg_period = rg_period('cash_flow'::reg_types,in_date_time);
	v_calc_interval = rg_calc_interval('cash_flow'::reg_types);
	raise exception 'rg_cash_flow_update_periods';
	LOOP
		UPDATE rg_cash_flow
		SET
			total = total + in_delta_total
		WHERE 
			date_time=v_loop_rg_period
			AND cash_location_id = in_cash_location_id;
			
		IF NOT FOUND THEN
			BEGIN
				INSERT INTO rg_cash_flow (date_time
				,cash_location_id
				,total)				
				VALUES (v_loop_rg_period
				,in_cash_location_id
				,in_delta_total);
			EXCEPTION WHEN OTHERS THEN
				UPDATE rg_cash_flow
				SET
					total = total + in_delta_total
				WHERE date_time = v_loop_rg_period
				AND cash_location_id = in_cash_location_id;
			END;
		END IF;
		v_loop_rg_period = v_loop_rg_period + v_calc_interval;
		IF v_loop_rg_period > CALC_DATE_TIME THEN
			EXIT;  -- exit loop
		END IF;
	END LOOP;
	
	--Current balance
	CURRENT_BALANCE_DATE_TIME = reg_current_balance_time();
	UPDATE rg_cash_flow
	SET
		total = total + in_delta_total
	WHERE 
		date_time=CURRENT_BALANCE_DATE_TIME
		AND cash_location_id = in_cash_location_id;
		
	IF NOT FOUND THEN
		BEGIN
			INSERT INTO rg_cash_flow (date_time
			,cash_location_id
			,total)				
			VALUES (CURRENT_BALANCE_DATE_TIME
			,in_cash_location_id
			,in_delta_total);
		EXCEPTION WHEN OTHERS THEN
			UPDATE rg_cash_flow
			SET
				total = total + in_delta_total
			WHERE 
				date_time=CURRENT_BALANCE_DATE_TIME
				AND cash_location_id = in_cash_location_id;
		END;
	END IF;					
	
END;
$BODY$;

ALTER FUNCTION public.rg_cash_flow_update_periods(timestamp without time zone, integer, numeric)
    OWNER TO glab;



-- ******************* update 02/07/2024 10:11:27 ******************
-- FUNCTION: public.rg_cash_flow_update_periods(timestamp without time zone, integer, numeric)

-- DROP FUNCTION IF EXISTS public.rg_cash_flow_update_periods(timestamp without time zone, integer, numeric);

CREATE OR REPLACE FUNCTION public.rg_cash_flow_update_periods(
	in_date_time timestamp without time zone,
	in_cash_location_id integer,
	in_delta_total numeric)
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
	v_loop_rg_period timestamp;
	v_calc_interval interval;			  			
	CURRENT_BALANCE_DATE_TIME timestamp;
	CALC_DATE_TIME timestamp;
BEGIN
	CALC_DATE_TIME = rg_calc_period('cash_flow'::reg_types);
	v_loop_rg_period = rg_period('cash_flow'::reg_types,in_date_time);
	v_calc_interval = rg_calc_interval('cash_flow'::reg_types);
	--raise exception 'rg_cash_flow_update_periods';
	LOOP
		UPDATE rg_cash_flow
		SET
			total = total + in_delta_total
		WHERE 
			date_time=v_loop_rg_period
			AND cash_location_id = in_cash_location_id;
			
		IF NOT FOUND THEN
			BEGIN
				INSERT INTO rg_cash_flow (date_time
				,cash_location_id
				,total)				
				VALUES (v_loop_rg_period
				,in_cash_location_id
				,in_delta_total);
			EXCEPTION WHEN OTHERS THEN
				UPDATE rg_cash_flow
				SET
					total = total + in_delta_total
				WHERE date_time = v_loop_rg_period
				AND cash_location_id = in_cash_location_id;
			END;
		END IF;
		v_loop_rg_period = v_loop_rg_period + v_calc_interval;
		IF v_loop_rg_period > CALC_DATE_TIME THEN
			EXIT;  -- exit loop
		END IF;
	END LOOP;
	
	--Current balance
	CURRENT_BALANCE_DATE_TIME = reg_current_balance_time();
	UPDATE rg_cash_flow
	SET
		total = total + in_delta_total
	WHERE 
		date_time=CURRENT_BALANCE_DATE_TIME
		AND cash_location_id = in_cash_location_id;
		
	IF NOT FOUND THEN
		BEGIN
			INSERT INTO rg_cash_flow (date_time
			,cash_location_id
			,total)				
			VALUES (CURRENT_BALANCE_DATE_TIME
			,in_cash_location_id
			,in_delta_total);
		EXCEPTION WHEN OTHERS THEN
			UPDATE rg_cash_flow
			SET
				total = total + in_delta_total
			WHERE 
				date_time=CURRENT_BALANCE_DATE_TIME
				AND cash_location_id = in_cash_location_id;
		END;
	END IF;					
	
END;
$BODY$;

ALTER FUNCTION public.rg_cash_flow_update_periods(timestamp without time zone, integer, numeric)
    OWNER TO glab;



-- ******************* update 03/09/2024 13:59:55 ******************
	
		ALTER TABLE public.fin_expense_types ADD COLUMN lev int;



-- ******************* update 03/09/2024 14:29:31 ******************
-- VIEW: public.fin_expense_types_list

--DROP VIEW public.fin_expense_types_list;

CREATE OR REPLACE VIEW public.fin_expense_types_list AS
	SELECT
		t.id
		,t.parent_id
		,t.name
		,t.deleted
		,t.for_cash
		,t.for_bank
		,t.lev
		
	FROM public.fin_expense_types AS t
	
	ORDER BY name ASC
	;
	
ALTER VIEW public.fin_expense_types_list OWNER TO glab;

