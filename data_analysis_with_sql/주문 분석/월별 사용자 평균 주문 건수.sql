with
	orders_mon as (
		select 
			date_trunc('month', order_date)::date as order_month,
			count(*) as order_cnt
		from
			nw.orders
		group by
			order_month,
			customer_id
	)
select 
	order_month,
	avg(order_cnt),
	min(order_cnt),
	max(order_cnt)
from 
	orders_mon
group by
	order_month
order by 
	order_month;
