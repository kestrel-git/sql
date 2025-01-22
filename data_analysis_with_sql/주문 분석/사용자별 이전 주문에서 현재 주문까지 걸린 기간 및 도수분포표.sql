-- 1. 주문 테이블에서 사용자별로 이전 주문 이후 걸린 기간 구하기
SELECT
	order_id,
	customer_id,
	order_date,
	LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) AS prev_order_date,
	order_date - LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) AS days_since_prev_order
FROM
	nw.orders;



-- 2. 이전 주문 이후 걸린 기간에 대한 도수분포표 그리기 (bin: 10)
WITH
	orders1 AS (
		SELECT
			order_id,
			customer_id,
			order_date,
			LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) AS prev_order_date,
			order_date - LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) AS days_since_prev_order
		FROM
			nw.orders
	),
	orders2 AS (
		SELECT *
		FROM orders1
		WHERE days_since_prev_order IS NOT NULL
	)
SELECT
	days_since_prev_order / 10 * 10 AS bin,
	COUNT(*) AS bin_cnt
FROM
	orders2
GROUP BY
	bin
ORDER BY
	bin;
