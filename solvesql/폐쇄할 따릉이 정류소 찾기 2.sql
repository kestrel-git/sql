WITH
  history_19 AS (
    SELECT
      rent_station_id AS station_id
    FROM
      rental_history
    WHERE
      strftime ('%Y-%m', rent_at) = '2019-10'
    UNION ALL
    SELECT
      return_station_id AS station_id
    FROM
      rental_history
    WHERE
      strftime ('%Y-%m', return_at) = '2019-10'
  ),
  agg_19 AS (
    SELECT
      station_id,
      COUNT(*) AS cnt
    FROM
      history_19
    GROUP BY
      station_id
  ),
  history_18 AS (
    SELECT
      rent_station_id AS station_id
    FROM
      rental_history
    WHERE
      strftime ('%Y-%m', rent_at) = '2018-10'
    UNION ALL
    SELECT
      return_station_id AS station_id
    FROM
      rental_history
    WHERE
      strftime ('%Y-%m', return_at) = '2018-10'
  ),
  agg_18 AS (
    SELECT
      station_id,
      COUNT(*) AS cnt
    FROM
      history_18
    GROUP BY
      station_id
  )
SELECT
  n.station_id,
  s.name,
  s.local,
  ROUND(100.0 * n.cnt / e.cnt, 2) AS usage_pct
FROM
  agg_19 n
  JOIN agg_18 e ON n.station_id = e.station_id
  JOIN station s ON n.station_id = s.station_id
WHERE
  n.cnt <= e.cnt * 0.5;
