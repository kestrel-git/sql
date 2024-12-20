WITH MAX_SIZE_PER_YEAR AS (
    SELECT 
          YEAR(DIFFERENTIATION_DATE) AS DIFF_YEAR
        , MAX(SIZE_OF_COLONY) AS MAX_SIZE
    FROM ECOLI_DATA
    GROUP BY YEAR(DIFFERENTIATION_DATE)
)
SELECT 
      YEAR(E.DIFFERENTIATION_DATE) AS YEAR
    , M.MAX_SIZE - E.SIZE_OF_COLONY AS YEAR_DEV
    , E.ID
FROM ECOLI_DATA AS E
    LEFT JOIN MAX_SIZE_PER_YEAR AS M ON YEAR(E.DIFFERENTIATION_DATE) = M.DIFF_YEAR
ORDER BY 1, 2
;
