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
			on oi1.order_id = oi2.order_id 		  -- 동일 주문끼리 결합
			and oi1.product_id != oi2.product_id  -- 동일 상품 제외
		group by
			prod_01, prod_02					  -- 동일 주문 내 상품쌍 그룹화
	)
select 
	prod_01,
	prod_02,
	cnt
from 
	temp_01
where rnum = 1	-- 특정 상품을 기준으로 함께 가장 많이 주문된 상품만 조회
;



