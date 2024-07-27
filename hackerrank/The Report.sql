SELECT
      CASE WHEN g.Grade >= 8 THEN s.Name ELSE NULL END AS Name
    , g.Grade
    , s.Marks
FROM Students s
    LEFT JOIN Grades g ON g.Min_Mark <= s.Marks and s.Marks <= g.Max_Mark
ORDER BY 2 Desc, 1, 3
;
