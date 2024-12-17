WITH
  penguins_avg AS (
    SELECT
      species,
      AVG(flipper_length_mm) AS avg_flipper_length_mm,
      AVG(body_mass_g) AS avg_body_mass_g
    FROM
      penguins
    GROUP BY
      species
  )
SELECT
  p.species,
  ROUND(
    SUM(
      (p.flipper_length_mm - a.avg_flipper_length_mm) * (p.body_mass_g - a.avg_body_mass_g)
    ) / SQRT(
      SUM(
        POWER(p.flipper_length_mm - a.avg_flipper_length_mm, 2)
      ) * SUM(POWER(p.body_mass_g - a.avg_body_mass_g, 2))
    ),
    3
  ) AS corr
FROM
  penguins p
  JOIN penguins_avg a ON p.species = a.species
GROUP BY
  p.species;
