SELECT 
    ci.NAME
FROM CITY ci
    JOIN COUNTRY co ON ci.COUNTRYCODE = co.CODE AND co.CONTINENT = "Africa"
;
