WITH IsImmediateTable AS (
    SELECT
        customer_id,
        CASE WHEN order_date = customer_pref_delivery_date THEN 1 ELSE 0
            END AS is_immediate,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date) AS order_order
    FROM Delivery
)
SELECT
    ROUND(100.0 * SUM(is_immediate) / COUNT(is_immediate), 2) AS immediate_percentage
FROM IsImmediateTable
WHERE order_order = 1
;
