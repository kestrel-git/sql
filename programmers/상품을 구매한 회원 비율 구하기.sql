WITH USERS_2021 AS (
    SELECT 
          USER_ID
        , COUNT(*) OVER () AS CNT
    FROM USER_INFO
    WHERE YEAR(JOINED) = 2021
)
SELECT 
      YEAR(SALES_DATE) AS YEAR
    , MONTH(SALES_DATE) AS MONTH
    , COUNT(DISTINCT S.USER_ID) AS PURCHASED_USERS
    , ROUND(COUNT(DISTINCT S.USER_ID) / U.CNT, 1) AS PURCHASED_RATIO
FROM ONLINE_SALE AS S
    JOIN USERS_2021 AS U ON S.USER_ID = U.USER_ID
GROUP BY YEAR(SALES_DATE), MONTH(SALES_DATE)
ORDER BY 1, 2
;
