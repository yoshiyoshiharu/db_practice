DROP TABLE PopTbl2;

CREATE TABLE PopTbl2(
  pref_name text PRIMARY KEY,
  sex integer PRIMARY KEY,
  population integer
);

INSERT INTO
  PopTbl2 (pref_name,, sex, population)
VALUES
  ('徳島', 1, 60),
  ('徳島', 2, 40),
  ('香川', 1, 100),
  ('香川', 2, 100),
  ('愛媛', 1, 100),
  ('愛媛', 2, 50),
  ('高知', 1, 100),
  ('高知', 2, 100),
  ('福岡', 1, 100),
  ('福岡', 2, 200),
  ('佐賀', 1, 20),
  ('佐賀', 2, 80),
  ('長崎', 1, 125),
  ('長崎', 2, 125),
  ('東京', 1, 250),
  ('東京', 2, 150);

SELECT
  *
FROM
  PopTbl2
WHERE
  pref_name = '徳島';

SELECT
  CASE
    WHEN sex = 1 THEN '男'
    WHEN sex = 2 THEN '女'
  END AS 性別,
  sum(population) AS 全国,
  sum(
    CASE
      WHEN pref_name = '徳島' THEN population
      ELSE 0
    END
  ) AS 徳島,
  sum(
    CASE
      WHEN pref_name = '香川' THEN population
      ELSE 0
    END
  ) AS 香川,
  sum(
    CASE
      WHEN pref_name = '愛媛' THEN population
      ELSE 0
    END
  ) AS 愛媛,
  sum(
    CASE
      WHEN pref_name = '高知' THEN population
      ELSE 0
    END
  ) AS 高知,
  sum(
    CASE
      WHEN pref_name IN ('徳島', '香川','愛媛', '高知') THEN population
      ELSE 0
    END
  ) AS 四国
FROM
  PopTbl2
GROUP BY
  sex;
