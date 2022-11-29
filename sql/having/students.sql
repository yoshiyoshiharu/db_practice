DROP TABLE students;

CREATE TABLE students (
  student_id text PRIMARY KEY,
  CLASS TEXT,
  sex TEXT,
  score integer
);

INSERT INTO students VALUES
  ('001', 'A', '男', 100),
  ('002', 'A', '女', 100),
  ('003', 'A', '女', 49),
  ('004', 'A', '男', 30),
  ('005', 'B', '女', 100),
  ('006', 'B', '男', 92),
  ('007', 'B', '男', 80),
  ('008', 'B', '男', 80),
  ('009', 'B', '女', 10),
  ('010', 'C', '男', 92),
  ('011', 'C', '男', 80),
  ('012', 'C', '女', 21),
  ('013', 'D', '女', 100),
  ('014', 'D', '女', 0),
  ('015', 'D', '女', 0);
  
SELECT * FROM students;

-- クラスの75%以上の生徒が80点以上のクラスを選択せよ
SELECT "class"
  FROM students
GROUP BY "class"
having count(
  CASE
    WHEN score >= 80 THEN 1
    ELSE NULL
    end
) >= count(score) * 0.75;

-- 女子の平均点が男子の平均点より高いクラスを選択せよ
SELECT "class" FROM students
GROUP BY "class"
HAVING AVG(
  CASE
    WHEN sex = '女' THEN score
    ELSE NULL
  END  
) > AVG(CASE
    WHEN sex = '男' THEN score
    ELSE NULL
  END);
