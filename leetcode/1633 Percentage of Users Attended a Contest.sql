WITH RegUsers AS (
    SELECT 
          contest_id
        , COUNT(DISTINCT user_id) AS users
    FROM Register
    GROUP BY contest_id
), TotalUsers AS (
    SELECT COUNT(user_id) AS total_users
    FROM Users
)
SELECT
      r.contest_id
    , ROUND(100.0 * r.users / t.total_users, 2) AS percentage
FROM RegUsers r, TotalUsers t
ORDER BY 
      percentage DESC
    , contest_id
;
