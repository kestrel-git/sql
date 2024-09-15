WITH RankSalary AS (
    SELECT
        d.name AS Department,
        e.name AS Employee,
        e.salary AS Salary,
        RANK() OVER (PARTITION BY d.id ORDER BY e.salary DESC) AS rank_salary
    FROM Department d
        JOIN Employee e ON d.id = e.departmentId
)
SELECT
    Department, Employee, Salary
FROM RankSalary
WHERE rank_salary = 1
;
