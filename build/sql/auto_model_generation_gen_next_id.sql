-- Function: auto_mode_generations_gen_next_id(in_auto_model_id int, in_eurocode text)

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
ALTER FUNCTION auto_mode_generations_gen_next_id(in_auto_model_id int, in_eurocode text) OWNER TO ;
