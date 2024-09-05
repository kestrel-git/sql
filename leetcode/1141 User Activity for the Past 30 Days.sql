SELECT
      activity_date AS day
    , COUNT(DISTINCT user_id) AS active_users
FROM Activity
WHERE activity_date > '2019-07-27'::DATE - INTERVAL '30 DAYS'
  AND activity_date <= '2019-07-27'
GROUP BY activity_date;
