SELECT
    'Low Salary' AS category,
    SUM((income < 20000)::INT) AS accounts_count
FROM Accounts
UNION ALL
SELECT
    'Average Salary' AS category,
    SUM((income BETWEEN 20000 AND 50000)::INT) AS accounts_count
FROM Accounts
UNION ALL
SELECT
    'High Salary' AS category,
    SUM((50000 < income)::INT) AS accounts_count
FROM Accounts
;
