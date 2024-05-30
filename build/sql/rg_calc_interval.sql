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
ALTER FUNCTION rg_calc_interval(reg_types) OWNER TO ;

