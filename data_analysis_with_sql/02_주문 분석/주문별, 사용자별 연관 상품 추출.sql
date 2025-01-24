-- 1. 주문별 연관 상품
--   * 특정 상품 주문 시 함께 가장 많이 주문된 다른 상품 추출
with
	temp_01 as (  -- 동일 주문 내 같이 등장한 횟수 계산
		select 
			oi1.product_id as prod_01,
			oi2.product_id as prod_02,
			count(*) as cnt,
			row_number () over (partition by oi1.product_id order by count(*) desc) as rnum
		from
			ga.order_items oi1
		join
			ga.order_items oi2 
			on oi1.order_id = oi2.order_id  -- 동일 주문끼리 결합
			and oi1.product_id != oi2.product_id  -- 동일 상품 제외
		group by
			prod_01, prod_02  -- 동일 주문 내 상품쌍 그룹화
	)
select 
	prod_01,
	prod_02,
	cnt
from 
	temp_01
where rnum = 1	-- 특정 상품을 기준으로 함께 가장 많이 주문된 상품만 조회
;



-- 2. 사용자별 연관 상품
--   * 사용자별 특정 상품 주문 시 함께 가장 많이 주문된 다른 상품 추출
with
	order_items_w_uid as (
		select 
			o.user_id,
			oi.order_id,
			oi.product_id
		from 
			ga.order_items oi
		join
			ga.orders o
			on oi.order_id = o.order_id  -- 사용자 ID(user_id)를 가져오기 위해 테이블 결합	
	),
	order_items_agg as (
		select 
			oi1.product_id as prod_01,
			oi2.product_id as prod_02,
			count(*) as cnt,  -- 같이 주문된 횟수 계산
			row_number() over (partition by oi1.product_id order by count(*) desc) as rnum  -- 함께 주문한 횟수 순위
		from
			order_items_w_uid as oi1
		join
			order_items_w_uid as oi2
			on oi1.user_id = oi2.user_id  -- 동일 사용자 결합 (사용자를 기준으로 같이 주문된 상품 파악)
			and oi1.product_id != oi2.product_id  -- 동일 상품 제외
		group by
			prod_01, prod_02
	)
select 
	prod_01,
	prod_02, 
	cnt
from 
	order_items_agg
where
	rnum = 1  -- 함께 가장 많이 주문된 상품만 조회
;
