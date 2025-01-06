SELECT
  bike_id
FROM
  rental_history
WHERE
  strftime ('%Y-%m', rent_at) = '2021-01'
  AND strftime ('%Y-%m', return_at) = '2021-01'
GROUP BY
  bike_id
HAVING
  SUM(distance) >= 50000;
