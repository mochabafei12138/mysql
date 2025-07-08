-- 重新打开链接，一定要做两件事  
-- 第一步：选择数据库【切换数据库】，否则 No database seletecd   *********
use mydb1;
-- 第二步：查询需要使用的数据库
select * from student;

-- a.查询所有学生的信息，按照成绩升序排序
select * from student order by score;
select * from student order by score asc;

-- b.查询所有学生的信息，按照成绩降序排序
select * from student order by score desc;

-- c.查询成绩及格的学生信息，按照年龄降序排序
-- select xx from xx where xx order by xx
select * from student where score >= 60 order by age desc;

-- d.查询所有学生的信息，按照年龄降序排序，如果年龄相同，则按照成绩升序排序
select * from student order by age desc,score asc;

-- e.查询所有学生的信息，按照成绩降序排序，如果成绩相同，则按照学号降序排序
select * from student order by score desc,sid desc;
