/*
 * 5일 이동 평균 매출
 *   - 5일이 안 되는 경우 NULL로 표시
 *   - 토, 일요일 데이터가 없어서, 월요일을 시작으로 하는 5일 이동 평균을 구함
 * */
with
	daily_table as (  -- 일자별 매출액 계산
		select
			o.order_date,
			sum(oi.amount) as daily_amount  -- 일별 매출
		from 
			nw.orders as o
		join 
			nw.order_items as oi on o.order_id = oi.order_id
		where
			order_date >= to_date('1996-07-08', 'yyyy-mm-dd')  -- 7월 8일 월요일 이후 데이터만 활용
		group by
			o.order_date
	),
	ma_table as (  -- 5일 이동평균 계산
		select
			order_date,
			round(avg(daily_amount) over (order by daily_amount rows between 4 preceding and current row), 2) as ma_5_days
		from
			daily_table
	)
select
	order_date,
	case when order_date <= to_date('1996-07-11', 'yyyy-mm-dd')  -- 5일이 안 되는 7월 8일~7월 11일은 null 출력
		 	then null
		 	else ma_5_days
	end
from
	ma_table
order by
	order_date
;
