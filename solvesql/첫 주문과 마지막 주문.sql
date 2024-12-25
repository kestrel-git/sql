SELECT
  MIN(strftime ("%Y-%m-%d", order_purchase_timestamp)) AS first_order_date,
  MAX(strftime ("%Y-%m-%d", order_purchase_timestamp)) AS last_order_date
FROM
  olist_orders_dataset;
