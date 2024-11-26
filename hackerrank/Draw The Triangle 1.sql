WITH RECURSIVE pattern AS (
    SELECT 20 AS num
    
    UNION ALL
    
    SELECT num-1 AS num
    FROM pattern
    WHERE num > 1
)
SELECT
    REPEAT("* ", num)
FROM pattern
;
