SELECT
  strftime ('%Y', acquisition_date) AS 'Acquisition year',
  COUNT(*) AS 'New acquisitions this year (Flow)',
  SUM(COUNT(*)) OVER (
    ROWS BETWEEN UNBOUNDED PRECEDING
    AND CURRENT ROW
  ) AS 'Total collection size (Stock)'
FROM
  artworks
WHERE
  acquisition_date IS NOT NULL
GROUP BY
  1
ORDER BY
  1;
