WITH CheckConsecutive AS (
    SELECT 
        *,
        lag(id, 1) over (order by id) + 1 as lag_1,
        lag(id, 2) over (order by id) + 2 as lag_2,
        lead(id, 1) over (order by id) - 1 as lead_1,
        lead(id, 2) over (order by id) - 2 as lead_2
    FROM Stadium
    WHERE people >= 100
)
SELECT
    id,
    visit_date,
    people
FROM CheckConsecutive
WHERE id IN (lag_2, lead_2)
   OR (id = lag_1 AND id = lead_1)
;
