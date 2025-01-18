WITH
  genre_avg AS (
    SELECT
      genre_id,
      AVG(critic_score) AS avg_critic_score,
      AVG(critic_count) AS avg_critic_count,
      AVG(user_score) AS avg_user_score,
      AVG(user_count) AS avg_user_count
    FROM
      games
    GROUP BY
      genre_id
  )
SELECT
  g.game_id,
  g.name,
  ROUND(COALESCE(g.critic_score, ga.avg_critic_score), 3) AS critic_score,
  CEIL(COALESCE(g.critic_count, ga.avg_critic_count)) AS critic_count,
  ROUND(COALESCE(g.user_score, ga.avg_user_score), 3) AS user_score,
  CEIL(COALESCE(g.user_count, ga.avg_user_count)) AS user_count
FROM
  games g
  JOIN genre_avg ga ON g.genre_id = ga.genre_id
WHERE
  year >= 2015
  AND (
    g.critic_score IS NULL
    OR g.critic_count IS NULL
    OR g.user_score IS NULL
    OR g.user_count IS NULL
  );
