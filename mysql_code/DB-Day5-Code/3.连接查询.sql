select * from student;
select * from score;

select count(*) from student; -- 6
select count(*) from score;  -- 12

-- 连接查询
-- 问题：结果集中的数据是两张表中的乘积，该结果被称为笛卡尔积，其中包含无用的数据甚至错误的数据
select * from student,score;
select count(*) from student,score;   -- 72

-- 解决：需要去除无用的数据甚至错误的数据，可以根据条件进行筛选
-- a.不规范的写法：表之间未建立主外键关系
-- 注意1：在多张表中有相同的字段，则可以通过  表名.字段名  进行区分
select * from student,score where student.sno=score.sno;
-- 注意2：连接查询之后，如果有相同字段，则可以按照需求查询需要的字段即可
select student.sno,sname,cno,degree from student,score where student.sno=score.sno;
-- 注意3：在连接查询中，可以设置别名
select s.sno,sname,cno,degree from student s,score c where s.sno=c.sno;
select 
	s.sno 学号,
    sname 姓名,
    cno 课程号,
    degree 分数
from 
	student s,score c 
where s.sno=c.sno;
-- 上述几种写法就是连接查询，属于内连接，但它不是sql中标准的查询方式，可以理解为方言

-- b.规范写法：设置主外键关系
-- 一对多【一：student,多：score】
desc student;
desc score;
alter table student modify sno varchar(5) primary key;
-- alter table student drop primary key;
-- 注意：要建立连接的两个字段的数据类型需要保持一致，否则会报错21:16:06	alter table score add constraint fk_stu_sco foreign key(sno) references student(sno)	Error Code: 3780. Referencing column 'sno' and referenced column 'sno' in foreign key constraint 'fk_stu_sco' are incompatible.	0.000 sec
-- incompatible:不相容，不兼容
alter table score add constraint stu_sco_sno foreign key(sno) references student(sno);

-- 1.内连接:两张表中根据筛选条件获取到的公共数据
select 
	s.sno 学号,
    sname 姓名,
    cno 课程号,
    degree 分数
from 
	student s inner join score c 
on s.sno=c.sno;

select 
	s.sno 学号,
    sname 姓名,
    cno 课程号,
    degree 分数
from 
	student s join score c 
on s.sno=c.sno;

-- 2.外连接
select 
	s.sno 学号,
    sname 姓名,
    cno 课程号,
    degree 分数
from 
	student s left outer join score c    -- outer可以省略，此时左表是stdent,右表是score
on s.sno=c.sno;

select 
	s.sno 学号,
    sname 姓名,
    cno 课程号,
    degree 分数
from 
	score c right  join student s    -- 此时左表是score,右表是student
on s.sno=c.sno;

select 
	s.sno 学号,
    sname 姓名,
    cno 课程号,
    degree 分数
from 
	score c left  join student s    -- 此时左表是score,右表是student
on s.sno=c.sno;

-- 3.自然连接:会自动找到两张表中的等价关系，进行自动的筛选
-- 内连接的简化

-- 内连接
select 
	s.sno 学号,
    sname 姓名,
    cno 课程号,
    degree 分数
from 
	student s inner join score c 
on s.sno=c.sno;

-- 自然连接
select 
	s.sno 学号,
    sname 姓名,
    cno 课程号,
    degree 分数
from 
	student s natural join score c; 
