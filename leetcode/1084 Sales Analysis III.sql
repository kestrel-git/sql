SELECT DISTINCT s.product_id, p.product_name
FROM Sales s
    JOIN Product p ON s.product_id = p.product_id
WHERE s.product_id not in (SELECT DISTINCT product_id
                           FROM Sales
                           WHERE sale_date NOT BETWEEN '2019-01-01' AND '2019-03-31')
;
