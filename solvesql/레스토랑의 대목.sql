WITH
  days AS (
    SELECT
      day
    FROM
      tips
    GROUP BY
      day
    HAVING
      SUM(total_bill) >= 1500
  )
SELECT
  t.*
FROM
  tips t
  JOIN days d ON t.day = d.day;
