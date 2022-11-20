drop table
  arrays;


create table
  arrays(key text, i integer, val integer, PRIMARY key (key, i));


INSERT INTO
  arrays
VALUES
  ('A', 1, NULL),
  ('A', 2, NULL),
  ('A', 3, NULL),
  ('A', 4, NULL),
  ('A', 5, NULL),
  ('A', 6, NULL),
  ('A', 7, NULL),
  ('A', 8, NULL),
  ('A', 9, NULL),
  ('A', 10, NULL),
  ('B', 1, 3),
  ('B', 2, NULL),
  ('B', 3, NULL),
  ('B', 4, NULL),
  ('B', 5, NULL),
  ('B', 6, NULL),
  ('B', 7, NULL),
  ('B', 8, NULL),
  ('B', 9, NULL),
  ('B', 10, NULL),
  ('C', 1, 1),
  ('C', 2, 1),
  ('C', 3, 1),
  ('C', 4, 1),
  ('C', 5, 1),
  ('C', 6, 1),
  ('C', 7, 1),
  ('C', 8, 1),
  ('C', 9, 1),
  ('C', 10, 1);


-- valがすべて1のkeyを取得する
-- not existsを用いる
select
  distinct key
from
  arrays as a_1
where
  not exists (
    SELECT
      *
    from
      arrays as a_2
    where
      a_1.key = a_2.key
      and (
        a_2.val != 1 or a_2.val is null -- ここは coalesce(a_2.val, 0) != 1 でも可
        )
  );
-- ALL を使う

select
  distinct key
from
  arrays as a_1
where
  1 = ALL (
    select
      val
    from
      arrays as a_2
    where
      a_1.key = a_2.key
  );
