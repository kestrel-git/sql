WITH
  platform_sales AS (
    SELECT
      developer_id,
      platform_id,
      SUM(sales_eu + sales_jp + sales_na + sales_other) AS total_sales,
      RANK() OVER (
        PARTITION BY
          developer_id
        ORDER BY
          SUM(sales_eu + sales_jp + sales_na + sales_other) DESC
      ) AS sales_rank
    FROM
      games
    WHERE
      developer_id IS NOT NULL
    GROUP BY
      developer_id,
      platform_id
  )
SELECT
  c.name AS developer,
  p.name AS platform,
  total_sales AS sales
FROM
  platform_sales ps
  LEFT JOIN companies c ON ps.developer_id = c.company_id
  LEFT JOIN platforms p ON ps.platform_id = p.platform_id
WHERE sales_rank = 1;
