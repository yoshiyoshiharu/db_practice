DROP TABLE server_load_samples;

CREATE TABLE server_load_samples(
  server text,
  sample_date DATE,
  load_val INTEGER,
  PRIMARY KEY (server, sample_date)
);

INSERT INTO
  server_load_samples
VALUES
  ('A', '2018-02-01', 1024),
  ('A', '2018-02-02', 2366),
  ('A', '2018-02-05', 2366),
  ('A', '2018-02-07', 985),
  ('A', '2018-02-08', 780),
  ('A', '2018-02-12', 1000),
  ('B', '2018-02-01', 54),
  ('B', '2018-02-02', 39008),
  ('B', '2018-02-03', 2900),
  ('B', '2018-02-04', 556),
  ('B', '2018-02-05', 12600),
  ('B', '2018-02-06', 7309),
  ('C', '2018-02-01', 1000),
  ('C', '2018-02-07', 2000),
  ('C', '2018-02-16', 500);

-- OVERのオプションを指定しなければ、デフォルトで全ての行を対象に集約する
SELECT
  server,
  sample_date,
  SUM(load_val) OVER () AS sum_load
FROM
  server_load_samples;

-- serverごとに集計される
SELECT
  server,
  sample_date,
  SUM(load_val) OVER (PARTITION BY server) AS sum_load
FROM
  server_load_samples;

/*
 ROW BETWEEN (相対位置1) AND (相対位置2): 相対位置1から相対位置2までの行で区切る
 
 相対位置:
 n PRECEDING: n行前
 n FORWORDING: n行後
 CURRENT ROW: 現在行
 */
-- 一行前のレコードを表示
SELECT
  sample_date AS cur_date,
  load_val AS cur_load,
  MIN(sample_date) OVER(
    ORDER BY
      sample_date ASC ROWS BETWEEN 1 PRECEDING
      AND 1 preceding
  ) AS latest_date,
  MIN(load_val) OVER(
    ORDER BY
      sample_date ASC ROWS BETWEEN 1 PRECEDING
      AND 1 preceding
  ) AS latest_load
FROM
  server_load_samples;

-- 上記を名前付きウィンドウ構文で書く
SELECT
  sample_date AS cur_date,
  load_val AS cur_load,
  MIN(sample_date) OVER W AS latest_date,
  MIN(load_val) OVER W AS latest_load
FROM
  server_load_samples WINDOW W AS (
    ORDER BY
      sample_date ASC ROWS BETWEEN 1 PRECEDING
      AND 1 preceding
  );

-- 1行前と現在行の平均値
SELECT
  server,
  sample_date AS cur_date,
  AVG(load_val) OVER(
    PARTITION BY server
    ORDER BY
      sample_date ASC ROWS BETWEEN 1 preceding
      AND CURRENT ROW
  ) AS avg_load
FROM
  server_load_samples;

-- 1"日"前と現在行との平均値 (値での比較はRANGEを使う)
SELECT
  server,
  sample_date AS cur_date,
  AVG(load_val) OVER(
    PARTITION BY server
    ORDER BY sample_date ASC
    RANGE BETWEEN interval '1' day preceding
      AND CURRENT ROW
  ) AS avg_load
FROM
  server_load_samples;
