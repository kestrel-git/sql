SELECT 
      DISTINCT ID
    , EMAIL
    , FIRST_NAME
    , LAST_NAME
FROM DEVELOPERS AS DEV
    JOIN SKILLCODES AS SK 
      ON SK.CATEGORY = 'Front End' AND DEV.SKILL_CODE & SK.CODE
ORDER BY ID
;
