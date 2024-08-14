WITH SingleNumbers AS (
    SELECT num
    FROM MyNumbers
    GROUP BY num
    HAVING COUNT(num) = 1
)
SELECT COALESCE(Max(num), NULL) as num
FROM SingleNumbers
;
