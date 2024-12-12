SELECT
  strftime ("%Y-%m", o.order_date) AS order_month,
  SUM(
    CASE
      WHEN o.order_id NOT LIKE "C%" THEN i.price * i.quantity
      ELSE 0
    END
  ) AS ordered_amount,
  SUM(
    CASE
      WHEN o.order_id LIKE "C%" THEN i.price * i.quantity
      ELSE 0
    END
  ) AS canceled_amount,
  SUM(i.price * i.quantity) AS total_amount
FROM
  orders o
  JOIN order_items i ON o.order_id = i.order_id
GROUP BY
  strftime ("%Y-%m", o.order_date)
ORDER BY
  order_month;
