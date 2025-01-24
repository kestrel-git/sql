-- 1. Recency, Frequency, Monetary 각각에 5분위(5 ntile)로 등급을 매겨 사용자별 RFM 구하기
--   * recency는 2016년 11월 1일을 기준 날짜로 하여 계산 (주어진 데이터에서 가장 최근 날짜가 2016년 10월 31일이어서)
--   * ntile의 문제: 데이터가 정규분포보다는 어느 한쪽에 몰려 있는(skewed) 경우가 많아서 단순히 분위수로 구분할 경우 변별력이 떨어짐
with
	rfm as (
		select
			o.user_id,
			to_date('20161101', 'yyyymmdd') - date_trunc('day', max(o.order_time))::date as recency,
			count(distinct o.order_id) as frequency,
			sum(oi.prod_revenue) as monetary
		from
			ga.orders as o
		join
			ga.order_items as oi  -- 주문 매출 금액을 가져오기 위해 (prod_revenue 컬럼)
			on o.order_id = oi.order_id 
		group by
			user_id  -- 사용자를 기준으로 함
	)
select 
	*,
	ntile(5) over (order by recency asc) as recency_rank,
	ntile(5) over (order by frequency desc) as frequency_rank,
	ntile(5) over (order by monetary desc) as monetary_rank
from
	rfm
;



-- 2. Recency, Frequency, Monetary 각각에 대해서 자체 기준을 만들어 사용자별 RFM 구하기
--   * recency는 2016년 11월 1일을 기준 날짜로 하여 계산 (주어진 데이터에서 가장 최근 날짜가 2016년 10월 31일이어서)
with
	rfm as (  -- rfm 계산 
		select
			o.user_id,
			to_date('20161101', 'yyyymmdd') - date_trunc('day', max(o.order_time))::date as recency,
			count(distinct o.order_id) as frequency,
			sum(oi.prod_revenue) as monetary
		from
			ga.orders as o
		join
			ga.order_items as oi  -- 주문 매출 금액을 가져오기 위해 (prod_revenue 컬럼)
			on o.order_id = oi.order_id 
		group by
			user_id  -- 사용자를 기준으로 함
	),
	rfm_grade as (  -- 자체 rfm 등급 기준 
		select 
			'A' as grade, 1 as from_rec, 14 as to_rec, 5 as from_freq, 9999 as to_freq, 100.0 as from_mon, 999999.0 as to_mon
		union all
		select 
			'B', 15, 50, 3, 4, 50.0, 99.999
		union all
		select 
			'C', 51, 99999, 1, 2, 0.0, 49.999
	),
	rfm_grade_calc as (  -- rfm 등급 계산 
		select 
			t.*,
			rg.grade as recency_grade,
			fg.grade as frequency_grade,
			mg.grade as monetary_grade
		from
			rfm as t
		left join
			rfm_grade as rg
			on t.recency between rg.from_rec and rg.to_rec
		left join
			rfm_grade as fg
			on t.frequency between fg.from_freq and fg.to_freq
		left join 
			rfm_grade as mg
			on t.monetary between mg.from_mon and mg.to_mon
	)
select  -- rfm 자체 종합 등급 계산 
	*,
	case when recency_grade = 'A' and frequency_grade in ('A', 'B') and monetary_grade = 'A' then 'A'
		 when recency_grade = 'B' and frequency_grade = 'A' and monetary_grade = 'A' then 'A'
         when recency_grade = 'B' and frequency_grade in ('A', 'B', 'C') and monetary_grade = 'B' then 'B'
         when recency_grade = 'C' and frequency_grade in ('A', 'B') and monetary_grade = 'B' then 'B'
         when recency_grade = 'C' and frequency_grade = 'C' and monetary_grade = 'A' then 'B'
         when recency_grade = 'C' and frequency_grade = 'C' and monetary_grade in ('B', 'C') then 'C'
         when recency_grade in ('B', 'C') and monetary_grade = 'C' then 'C'
         else 'C' end as total_grade
from rfm_grade_calc
;

