WITH
  agg_points AS (
    SELECT
      quartet,
      AVG(x) AS x_mean,
      AVG(y) AS y_mean,
      COUNT(*) AS cnt
    FROM
      points
    GROUP BY
      quartet
  )
SELECT
  p.quartet,
  ROUND(x_mean, 2) AS x_mean,
  ROUND(SUM(POWER(x - x_mean, 2)) / (cnt - 1), 2) AS x_var,
  ROUND(y_mean, 2) AS y_mean,
  ROUND(SUM(POWER(y - y_mean, 2)) / (cnt - 1), 2) AS y_var
FROM
  points p
  LEFT JOIN agg_points ap ON p.quartet = ap.quartet
GROUP BY
  p.quartet;
