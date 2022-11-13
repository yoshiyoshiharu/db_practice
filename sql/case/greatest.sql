DROP TABLE greatests;

CREATE TABLE greatests(
  key text primary key,
  x integer,
  y integer,
  z integer
);

INSERT INTO greatests (key, x, y, z)
  VALUES ('A', 1, 2, 3), ('B', 5, 5, 2), ('C', 4, 7, 1), ('D', 3, 3, 8);

SELECT * FROM greatests ;

-- keyの中から最大値を取得する
SELECT
  key,
  CASE
    WHEN (
      CASE
        WHEN x < y THEN y
        ELSE x
      END) < z THEN z
    ELSE (
      CASE
        WHEN x < y THEN y
        ELSE x
      END)
  END AS greatest
FROM greatests;
