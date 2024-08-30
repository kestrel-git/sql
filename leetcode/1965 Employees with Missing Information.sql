WITH Missing AS (
    SELECT e.employee_id
    FROM Employees e
        LEFT OUTER JOIN Salaries s ON e.employee_id = s.employee_id
    WHERE s.employee_id IS NULL 

    UNION ALL

    SELECT s.employee_id
    FROM Employees e
        RIGHT OUTER JOIN Salaries s ON e.employee_id = s.employee_id
    WHERE e.employee_id IS NULL 
)
SELECT *
FROM Missing
ORDER BY employee_id
;
