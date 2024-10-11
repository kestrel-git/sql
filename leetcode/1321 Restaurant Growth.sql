WITH 
DailyTable AS (
    SELECT
        visited_on,
        SUM(amount) AS daily_amount
    FROM Customer
    GROUP BY visited_on
),
AggTable AS (
    SELECT
        visited_on,
        SUM(daily_amount) OVER (ORDER BY visited_on
                                RANGE BETWEEN INTERVAL 6 DAY PRECEDING AND CURRENT ROW) AS amount,
        ROUND(
            AVG(daily_amount) OVER (ORDER BY visited_on
                                    RANGE BETWEEN INTERVAL 6 DAY PRECEDING AND CURRENT ROW)
        , 2) AS average_amount,
        MIN(visited_on) OVER (ORDER BY visited_on) AS first_day
    FROM DailyTable
)
SELECT
    visited_on,
    amount,
    average_amount
FROM AggTable
WHERE visited_on >= first_day + INTERVAL 6 DAY
;
