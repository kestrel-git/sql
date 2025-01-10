WITH
  mentees AS (
    SELECT
      *
    FROM
      employees
    WHERE
      join_date BETWEEN DATE('2021-12-31', '-3 month') AND '2021-12-31'
  ),
  mentors AS (
    SELECT
      *
    FROM
      employees
    WHERE
      join_date <= DATE('2021-12-31', '-2 year')
  )
SELECT
  mte.employee_id AS mentee_id,
  mte.name AS mentee_name,
  mtr.employee_id AS mentor_id,
  mtr.name AS mentor_name
FROM
  mentees mte
  LEFT JOIN mentors mtr ON mte.department != mtr.department
ORDER BY
  mentee_id,
  mentor_id;
