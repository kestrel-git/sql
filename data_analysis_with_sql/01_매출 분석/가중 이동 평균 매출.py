/*
 * 5일 가중 이동 평균 매출
 *   - 가중치
 *      - 4일 전: 0.5
 *      - 1~3일 전: 1
 *      - 당일: 1.5
 *   - 5일이 안 되는 경우 NULL로 표시
 *   - 토, 일요일 데이터가 없어서, 월요일을 시작(7월 8일)으로 하는 5일 이동 평균을 구함
 * */
with
	daily_table as (
		select
			o.order_date,
			sum(amount) as daily_amount,
			row_number() over (order by order_date) as rnum
		from
			nw.orders as o
		join
			nw.order_items as oi
			on o.order_id = oi.order_id 
		where
			order_date >= to_date('1996-07-08', 'yyyy-mm-dd')  -- 7월 8일 월요일 이후 데이터만 활용
		group by
			o.order_date
		order by
			o.order_date
	)
select
	dt1.order_date,
	case when max(dt1.rnum) < 5 then null
		 else
			(sum(case when dt1.rnum - dt2.rnum = 4 then 0.5 * dt2.daily_amount
					 when dt1.rnum - dt2.rnum in (1, 2, 3) then dt2.daily_amount
					 when dt1.rnum = dt2.rnum then 1.5 * dt2.daily_amount
				 end) / 5)
	end as weighted_ma_5days
from
	daily_table as dt1
join
	daily_table as dt2 
	on dt1.rnum between dt2.rnum and dt2.rnum + 4
group by
	dt1.order_date
order by
	dt1.order_date
;
