WITH Players AS (
    SELECT
        player_id,
        (event_date - MIN(event_date) OVER (PARTITION BY player_id)) = 1 AS cons_login
    FROM Activity
)
SELECT
    ROUND(1.0 * SUM(cons_login::INT) / COUNT(DISTINCT player_id), 2) AS fraction
FROM Players
;
