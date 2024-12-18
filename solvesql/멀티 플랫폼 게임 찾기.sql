WITH
  games_platforms AS (
    SELECT
      g.name AS game_name,
      CASE
        WHEN p.name IN ('PS3', 'PS4', 'PSP', 'PSV') THEN 'Sony'
        WHEN p.name IN ('Wii', 'WiiU', 'DS', '3DS') THEN 'Nintendo'
        WHEN p.name IN ('X360', 'XONE') THEN 'Microsoft'
        ELSE 'Etc'
      END AS platform_name
    FROM
      games g
      JOIN platforms p ON g.platform_id = p.platform_id
    WHERE
      g.year >= 2012
  )
SELECT
  game_name AS name
FROM
  games_platforms
WHERE
  platform_name != 'Etc'
GROUP BY
  game_name
HAVING
  COUNT(DISTINCT platform_name) >= 2;
