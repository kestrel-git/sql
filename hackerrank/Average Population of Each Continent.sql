SELECT
    co.CONTINENT,
    FLOOR(AVG(co.POPULATION))
FROM COUNTRY co
    LEFT JOIN CITY ci ON co.CODE = ci.COUNTRYCODE
GROUP BY co.CONTINENT
;
