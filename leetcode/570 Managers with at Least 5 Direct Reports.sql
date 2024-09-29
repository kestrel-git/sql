SELECT name
FROM Employee
WHERE id in (SELECT managerId
             FROM Employee
             GROUP BY managerId
             HAVING COUNT(*) >= 5)
;

-- WITH Managers AS (
--     SELECT managerId AS id
--     FROM Employee
--     GROUP BY managerId
--     HAVING COUNT(*) >= 5
-- )
-- SELECT e.name
-- FROM Employee e
--     JOIN Managers m ON e.id = m.id
-- ;
