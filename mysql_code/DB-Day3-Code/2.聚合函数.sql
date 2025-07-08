-- a.查询student表中记录的条数
select count(*) from student;
-- 注意：count针对任意类型的字段都可以做统计，只是计数，如果明确字段则使用字段名称，如果未明确字段则直接使用*
-- 统计指定列不为null的记录行数
insert into student (sid,name,age) value (1007,'yuw',12),(1009,'cnhf',8),(1010,'lks',9),(1012,'tom',10);
-- 统计成绩非空的数据的条数
select count(*) from student where score is not null;  -- 17
select count(score) from student;    -- 17

-- b.查询成绩及格的人数
select count(*) from student where score >= 60;

-- c.查询全班同学的最高分
select max(score) from student;

-- d.查询全班同学的最低分
select min(score) from student;
select max(score) as 最高分,min(score) as 最低分 from student;

-- e.计算全班学生的总分
select sum(score) from student;

-- f.统计全班学生的平均分
select sum(score)/count(*) from student;  -- 50.0952
select sum(score)/count(score) from student;  -- 61.8824
-- avg只针对非空数据求平均值
select avg(score) from student;    -- 61.8824

-- g.查询年龄在10~12岁的学生的最高成绩
select max(score) from student where age between 10 and 12;

-- h.查询姓张的学生的平均年龄
select avg(age) from student where name like '张%';
