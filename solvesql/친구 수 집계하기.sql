WITH
  union_edges AS (
    SELECT
      user_a_id AS user_id,
      user_b_id AS friend_id
    FROM
      edges
    UNION
    SELECT
      user_b_id AS user_id,
      user_a_id AS friend_id
    FROM
      edges
  ),
  agg_friends AS (
    SELECT
      user_id,
      COUNT(friend_id) AS num_friends
    FROM
      union_edges
    GROUP BY
      user_id
  )
SELECT
  u.user_id,
  COALESCE(a.num_friends, 0) AS num_friends
FROM
  users u
  LEFT JOIN agg_friends a ON u.user_id = a.user_id
ORDER BY
  num_friends DESC,
  u.user_id;
