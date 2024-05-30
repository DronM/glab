-- Function: bank_flow_out_find_expense_type(in_pay_comment text)

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
ALTER FUNCTION bank_flow_out_find_expense_type(in_pay_comment text) OWNER TO ;
