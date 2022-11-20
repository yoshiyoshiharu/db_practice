-- Active: 1668919969418@@127.0.0.1@15432@postgres@public
create table
  test_scores(
    student_id integer,
    subject text,
    score integer,
    PRIMARY key (student_id, subject)
  );


insert into
  test_scores
values
  (100, '算数', 100),
  (100, '国語', 80),
  (100, '理科', 80),
  (200, '算数', 80),
  (200, '国語', 95),
  (300, '算数', 40),
  (300, '国語', 90),
  (300, '社会', 55),
  (400, '算数', 80);


-- すべての教科が50点以上である生徒を選択
-- NOT EXISTSの活用 50点未満の教科が一つもない(ド・モルガン)
select
  distinct student_id
from
  test_scores as t_1
where
  not exists (
    select
      *
    from
      test_scores as t_2
    where
      t_1.student_id = t_2.student_id
      and t_2.score < 50
  );


-- ALLを使う方法
select
  student_id
from
  test_scores as t_1
where
  50 < ALL (
    select
      score
    from
      test_scores as t_2
    where
      t_2.student_id = t_1.student_id
  )
group by
  student_id;


--ここ消してSELECT DISTINCTでもいける
-- 条件を複雑にする
-- 算数が80点以上 かつ 国語が50点以上である生徒を選択
-- 算数が80点未満 または 国語が50点未満でない生徒
select distinct
  student_id
from
  test_scores t_1
where
  not exists (
    select
      *
    from
      test_scores t_2
    where
      1 = case
        when subject = '算数' and score < 80 then 1
        when subject = '国語' and score < 50 then 1
        else 0
      end
      and t_1.student_id = t_2.student_id
  );
