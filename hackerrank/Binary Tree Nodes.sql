WITH CALC_PARENT_CHILDREN AS (
    SELECT
        b1.N AS N,
        b1.P IS NOT NULL AS HAS_PARENT,
        COUNT(b2.N) AS NUM_CHILDREN
    FROM BST b1
        LEFT JOIN BST b2 ON b1.N = b2.P
    GROUP BY b1.N, b1.P
)
SELECT
    N,
    CASE WHEN HAS_PARENT = 0 THEN "Root"
         WHEN NUM_CHILDREN = 0 THEN "Leaf"
         ELSE "Inner"
    END
FROM CALC_PARENT_CHILDREN
ORDER BY N
;
