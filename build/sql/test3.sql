select
	doc_log.*,
	act.*
from doc_log
LEFT JOIN ra_cash_flow AS act ON act.doc_type=doc_log.doc_type AND act.doc_id=doc_log.doc_id
where date_time between '2024-08-01T00:00:00' and '2024-08-01T23:59:59'


select * from ra_cash_flow AS act
where date_time between '2024-08-01T00:00:00' and '2024-08-02T23:59:59'
