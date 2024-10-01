SELECT
    TO_CHAR(trans_date, 'YYYY-MM') AS month,
    country,
    COUNT(*) AS trans_count,
    SUM((state='approved')::INTEGER) AS approved_count,
    SUM(amount) AS trans_total_amount,
    SUM((state='approved')::INTEGER * amount) AS approved_total_amount
FROM Transactions
GROUP BY month, country
;
