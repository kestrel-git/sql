WITH
  tips_agg AS (
    SELECT
      SUM(total_bill) AS daily_sum
    FROM
      tips
    GROUP BY
      day
  )
SELECT
  ROUND(AVG(daily_sum), 2) AS avg_sales
FROM
  tips_agg;
