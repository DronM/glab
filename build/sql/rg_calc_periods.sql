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


