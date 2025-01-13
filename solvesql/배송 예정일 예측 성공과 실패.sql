SELECT
  strftime ('%Y-%m-%d', order_purchase_timestamp) AS purchase_date,
  SUM(
    CASE
      WHEN order_delivered_customer_date <= order_estimated_delivery_date THEN 1
      ELSE 0
    END
  ) AS success,
  SUM(
    CASE
      WHEN order_delivered_customer_date > order_estimated_delivery_date THEN 1
      ELSE 0
    END
  ) AS fail
FROM
  olist_orders_dataset
WHERE
  purchase_date BETWEEN '2017-01-01' AND '2017-01-31'
  AND order_delivered_customer_date IS NOT NULL
  AND order_estimated_delivery_date IS NOT NULL
GROUP BY
  purchase_date
ORDER BY
  purchase_date;
