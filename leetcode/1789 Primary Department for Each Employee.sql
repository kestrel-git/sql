WITH CountDep AS (
    SELECT 
        *,
        COUNT(*) OVER (PARTITION BY employee_id) AS dep_count
    FROM Employee    
)
SELECT 
    employee_id,
    department_id
FROM CountDep
WHERE 
    dep_count = 1 
    OR primary_flag = 'Y'
;
