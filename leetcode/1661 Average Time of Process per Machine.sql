WITH PTime AS (
    SELECT
        machine_id,
        SUM(CASE WHEN activity_type = 'start' THEN -1 * timestamp 
                ELSE timestamp
            END) AS processing_time
    FROM Activity
    GROUP BY machine_id, process_id
)
SELECT
    machine_id,
    ROUND(CAST(AVG(processing_time) AS numeric), 3) AS processing_time
FROM PTime
GROUP BY machine_id
;
