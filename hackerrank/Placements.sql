SELECT
    s.Name
FROM Students s
    LEFT JOIN Friends f ON s.ID = f.ID
    LEFT JOIN Packages ps ON s.ID = ps.ID
    LEFT JOIN Packages pf ON f.Friend_ID = pf.ID
WHERE ps.Salary < pf.Salary
ORDER BY pf.Salary
;
