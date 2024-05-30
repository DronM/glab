select * from cash_flow_location_balance_list(null, now()::date-'1 day'::interval, now()::date)
