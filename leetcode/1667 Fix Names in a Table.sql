SELECT 
    user_id, 
    upper(left(name, 1)) || lower(substr(name, 2)) AS name
FROM Users
ORDER BY user_id
;
