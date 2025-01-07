SELECT
  total_bill,
  tip,
  sex,
  smoker,
  day,
  time,
  size
FROM
  (
    SELECT
      *,
      RANK() OVER (
        PARTITION BY
          day
        ORDER BY
          total_bill DESC
      ) AS rnk
    FROM
      tips
  ) t
WHERE
  t.rnk = 1;
