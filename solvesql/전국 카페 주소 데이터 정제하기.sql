WITH
  cafe_addrs AS (
    SELECT
      SUBSTR(address, 0, INSTR(address, ' ')) AS sido,
      SUBSTR(address, INSTR(address, ' ') + 1) AS address
    FROM
      cafes
  )
SELECT
  sido,
  SUBSTR(address, 0, INSTR(address, ' ')) AS sigungu,
  COUNT(*) AS cnt
FROM
  cafe_addrs
GROUP BY
  sido,
  sigungu
ORDER BY
  cnt desc;
