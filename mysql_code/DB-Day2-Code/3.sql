-- DQL

-- 1.基础查询
-- 查询指定表中的所有字段
select * from student;

-- 查询指定表中的指定字段
select sid,name from student;

-- 2.条件查询
-- where子句
-- 格式：select * from  xxx where 条件

-- a.查询成绩大于90分的学生信息
select * from student where score>90;

-- b.查询成绩在70分~90分之间的学生信息
select * from student where score>=70 and score<=90;
select * from student where score between 70 and 90;

-- c.查询成绩是66，77，88，99的学生信息
select * from student where score=66 or score=77 or score=88 or score=99;
select * from student where score in (66,77,88,99);

-- d.查询成绩不是66，77，88，99的学生信息
select * from student where score not in (66,77,88,99);

-- e.查询未参加考试的学生信息【成绩为空】
select * from student where score is null;

-- f.查询姓名为abc或成绩为80的学生信息
select * from student where name='abc' or score=80;

-- 3.模糊查询
-- where结合like关键字使用
-- a.查询姓张的学生信息 
select * from student where name like '张%';
   
-- b.查询姓名中有'小'的学生信息
select * from student where name like '%小%';

-- c.查询姓名由3个字符组成，最后一个字符为w的学生信息
select * from student where name like '__w';

-- d.查询姓名中第2个字符为a的学生信息
select * from student where name like '_a%';

-- e.查询姓名为四个字的学生信息
select * from student where name like '____';

-- 4.字段控制查询
-- as:起别名，可以省略,经常用于多表查询中
select sid as 学号,name as 姓名 from student;
select sid  学号,name  姓名 from student;
select sid as 学号,name as 姓名 from student s;

-- ifnull(字段,value),如果指定字段的值为null，则显示为value
select ifnull(score,0) from student;

-- c.distinct:去重的
-- 针对整条数据去重
select distinct * from student;
-- 针对字段去重
select distinct age from student;
