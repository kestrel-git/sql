WITH Temp AS (
    SELECT
        DISTINCT product_id,
        FIRST_VALUE(new_price) OVER (PARTITION BY product_id ORDER BY change_date DESC) AS price
    FROM Products
    WHERE change_date <= '2019-08-16'
)
SELECT
    DISTINCT p.product_id,
    COALESCE(t.price, 10) AS price
FROM Products p
    LEFT JOIN Temp t ON p.product_id = t.product_id
;
