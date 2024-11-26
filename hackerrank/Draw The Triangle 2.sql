WITH RECURSIVE pattern AS (
    SELECT 1 AS num
    
    UNION ALL
    
    SELECT
        num + 1 AS num
    FROM pattern
    WHERE num < 20
)
SELECT
    REPEAT("* ", num)
FROM pattern
;
