SELECT
  m1.measured_at AS today,
  m2.measured_at AS next_day,
  m1.pm10 AS pm10,
  m2.pm10 AS next_pm10
FROM
  measurements m1
  JOIN measurements m2 ON DATE(m1.measured_at, '1 Day') = m2.measured_at
WHERE
  m1.pm10 < m2.pm10;
