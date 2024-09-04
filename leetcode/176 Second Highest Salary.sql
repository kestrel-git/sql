WITH TEMP AS (
    SELECT
          salary
        , ROW_NUMBER() OVER (ORDER BY salary DESC) AS RN
    FROM Employee
    GROUP BY salary
)
SELECT
    CASE WHEN COUNT(*) = 0 THEN NULL
         ELSE MAX(salary)
    END AS SecondHighestSalary
FROM TEMP
WHERE RN = 2
;
