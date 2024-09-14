WITH WeightSum AS (
    SELECT
        person_name,
        SUM(weight) OVER (ORDER BY turn) AS weight_sum
    FROM Queue
)
SELECT person_name
FROM WeightSum
WHERE weight_sum <= 1000
ORDER BY weight_sum DESC
LIMIT 1
;
