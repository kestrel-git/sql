WITH FebProds AS (
    SELECT product_id, SUM(unit) AS unit
    FROM Orders
    WHERE date_trunc('month', order_date) = '2020-02-01'
    GROUP BY product_id
    HAVING SUM(unit) >= 100
)
SELECT product_name, unit
FROM FebProds f
    JOIN Products p ON f.product_id = p.product_id
;
