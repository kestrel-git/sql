SELECT
  strftime ('%Y-%m-%d', order_delivered_carrier_date) AS delivered_carrier_date,
  COUNT(*) AS orders
FROM
  olist_orders_dataset
WHERE
  strftime ('%Y-%m', order_delivered_carrier_date) = '2017-01'
  AND order_delivered_carrier_date IS NOT NULL
  AND order_delivered_customer_date IS NULL
GROUP BY
  delivered_carrier_date
ORDER BY
  delivered_carrier_date;
