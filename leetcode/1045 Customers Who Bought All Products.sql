WITH ProductCount AS (
    SELECT
        COUNT(product_key) AS count
    FROM Product
)
SELECT
    customer_id
FROM Customer c
GROUP BY c.customer_id
HAVING COUNT(DISTINCT c.product_key) = (SELECT count FROM ProductCount)
;
