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

ALTER TABLE ra_bank_flow_list OWNER TO ;

