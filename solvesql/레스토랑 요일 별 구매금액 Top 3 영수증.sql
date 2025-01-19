WITH
  tips_rank AS (
    SELECT
  day,
  time,
  sex,
  total_bill,
  DENSE_RANK () OVER (PARTITION BY day ORDER BY total_bill DESC) AS bill_rank
FROM
  tips
  )
SELECT
  day,
  time,
  sex,
  total_bill
FROM
  tips_rank
WHERE
  bill_rank <= 3;
