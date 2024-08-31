SELECT
      sell_date
    , COUNT(DISTINCT product) AS num_sold
    , STRING_AGG(DISTINCT product, ',' ORDER BY product ASC) AS products
FROM Activities
GROUP BY sell_date
;
