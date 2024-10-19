-- (1)
SELECT
    DISTINCT l1.num AS ConsecutiveNums
FROM 
    Logs l1,
    Logs l2,
    Logs l3
WHERE l1.id + 1 = l2.id
  AND l1.id + 2 = l3.id
  AND l1.num = l2.num
  AND l2.num = l3.num
;
    

-- (2)
-- SELECT
--     DISTINCT num AS ConsecutiveNums
-- FROM Logs
-- WHERE (id+1, num) IN (SELECT * FROM Logs)
--   AND (id+2, num) IN (SELECT * FROM Logs)
-- ;


-- (3)
-- WITH Temp AS (
--     SELECT
--         num AS num_0,
--         LEAD(num, 1) OVER () AS num_1,
--         LEAD(num, 2) OVER () AS num_2
--     FROM Logs
-- )
-- SELECT
--     DISTINCT num_0 AS ConsecutiveNums
-- FROM Temp
-- WHERE num_0 = num_1
--   AND num_1 = num_2
-- ;
