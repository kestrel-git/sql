with 
temp_01 as (
	select date_trunc('day', order_date)::date as d_day
		, sum(amount) as sum_amount
	from nw.orders a
		join nw.order_items b on a.order_id = b.order_id
	where order_date >= to_date('1996-07-08', 'yyyy-mm-dd')
	group by date_trunc('day', order_date)::date
),
temp_02 as (
	select *,
		avg(sum_amount) over (order by d_day rows between 4 preceding and current row) as m_avg_5day,
		row_number() over (order by d_day) as rnum
	from temp_01
)
select
	d_day,
	sum_amount,
	case when rnum < 5 then Null
		 else m_avg_5day end as m_avg_5day
from temp_02;
