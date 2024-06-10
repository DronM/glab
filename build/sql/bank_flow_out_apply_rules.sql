-- Function: bank_flow_out_apply_rules()

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
ALTER FUNCTION bank_flow_out_apply_rules() OWNER TO ;
