SELECT 
      user_id
    , MAX(time_stamp) AS last_stamp
FROM Logins
WHERE DATE_TRUNC('year', time_stamp) = '2020-01-01'
GROUP BY user_id
;
