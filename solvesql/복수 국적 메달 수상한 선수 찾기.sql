SELECT
  a.name
FROM
  records r
  JOIN games g ON r.game_id = g.id
  AND g.year >= 2000
  JOIN athletes a ON r.athlete_id = a.id
WHERE
  r.medal IS NOT NULL
GROUP BY
  r.athlete_id
HAVING
  COUNT(DISTINCT r.team_id) >= 2
ORDER BY
  name;
