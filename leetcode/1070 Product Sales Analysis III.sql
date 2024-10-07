WITH SalesYearOrder AS (
    SELECT
        product_id,
        year,
        quantity,
        price,
        RANK() OVER (PARTITION BY product_id ORDER BY year) AS year_order
    FROM Sales
)
SELECT
    product_id,
    year AS first_year,
    quantity,
    price
FROM SalesYearOrder
WHERE year_order = 1
;
