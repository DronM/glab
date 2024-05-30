-- View: public.variant_storages_list

-- DROP VIEW public.variant_storages_list;

CREATE OR REPLACE VIEW public.variant_storages_list
AS
	SELECT
		variant_storages.user_id,
		variant_storages.storage_name,
		variant_storages.variant_name
	FROM variant_storages;

ALTER TABLE public.variant_storages_list
    OWNER TO ;


