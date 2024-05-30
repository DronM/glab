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

