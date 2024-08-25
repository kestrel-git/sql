SELECT 
      MAX(u.name) AS name
    , SUM(t.amount) AS balance
FROM Transactions t
    JOIN Users u ON t.account = u.account
GROUP BY t.account
HAVING SUM(t.amount) > 10000
;
