DROP TABLE populations;

CREATE TABLE populations(
  id integer PRIMARY KEY,
  country text,
  region text,
  population integer
);

INSERT INTO
  populations(id, country, region, population)
VALUES
  (1, 'China', 'Asia', 1409517397),
  (2, 'India', 'Asia', 1339180127),
  (3, 'United States', 'Americas', 324459463),
  (4, 'Indonesia', 'Asia', 263991379),
  (5, 'Brazil', 'Americas', 209288278),
  (6, 'Pakistan', 'Asia', 197015955),
  (7, 'Nigeria', 'Africa', 190886311),
  (8, 'Bangladesh', 'Asia', 164669751),
  (9, 'Russia', 'Europe', 143989754),
  (10, 'Mexico', 'Americas', 129163276),
  (11, 'Japan', 'Asia', 127484450),
  (12, 'Ethiopia', 'Africa', 104957438),
  (13, 'Philippines', 'Asia', 104918090),
  (14, 'Egypt', 'Africa', 97553151),
  (15, 'Vietnam', 'Asia', 95540800),
  (16, 'Germany', 'Europe', 82114224),
  (17, 'Congo', 'Africa', 81339988),
  (18, 'Iran', 'Asia', 81162788),
  (19, 'Turkey', 'Asia', 80745020),
  (20, 'Thailand', 'Asia', 69037513),
  (21, 'United Kingdom', 'Europe', 66181585),
  (22, 'France', 'Europe', 64979548),
  (23, 'Italy', 'Europe', 59359900),
  (24, 'Tanzania', 'Africa', 57310019),
  (25, 'South Africa', 'Africa', 56717156),
  (26, 'Myanmar', 'Asia', 53370609),
  (27, 'South Korea', 'Asia', 50982212),
  (28, 'Kenya', 'Africa', 49699862),
  (29, 'Colombia', 'Americas', 49065615),
  (30, 'Spain', 'Europe', 46354321);

SELECT
  *
FROM
  populations;

-- 地域ごとの合計人口を横に追加する
SELECT
  sum(population)
FROM
  populations
GROUP BY
  region;

-- 全てのレコードを表示し、横に地域ごとの人口の列を追加する
SELECT
  country,
  region,
  population,
  (
    SELECT
      sum(population)
    FROM
      populations AS b
    WHERE
      a.region = b.region
    GROUP BY
      region
  ) AS total_in_region
FROM
  populations AS a;

-- Window関数を使うと、各行を残したまま集約関数の結果を表示できる
SELECT
  country,
  region,
  population,
  sum(population) OVER(PARTITION by region)
FROM
  populations
ORDER BY
  id ASC;
