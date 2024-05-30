-- Function: auto_model_generations_name(auto_model_generations)

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
ALTER FUNCTION auto_model_generations_name(auto_model_generations) OWNER TO ;
