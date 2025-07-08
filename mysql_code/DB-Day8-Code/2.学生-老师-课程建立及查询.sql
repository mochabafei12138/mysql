-- 一、建库及切换
-- 创建库
create database stu_sco_cou_db;
-- 切换库
use stu_sco_cou_db;

-- 二、建表及插入数据
-- tb_student: stu_id ,stu_name,birth, gender, class_id
create table `tb_student`(
`stu_id` int primary key auto_increment comment '学号',
`stu_name` varchar(10) not null comment '姓名',
`birth` date comment '生日',
`gender` char(1) comment '性别',
`class_id` varchar(5) comment '班级号'
) comment '学生表';

insert into tb_student values(1004, '李秀才', '2001-09-03', '男', 'c002'),
(1005, '李大嘴', '2001-06-03', '男', 'c002'),
(1006, '白展堂', '2002-11-17', '男', 'c002'),
(1007, '张小六', '2001-09-03', '男', 'c003'),
(1008, '白百欣', '2002-10-03', '女', 'c003'),
(1009, '赵强', '2001-09-03', '男', 'c003'),
(1010, '王倩倩', '2001-09-03', '男', 'c003'),
(1011, '宋达达', '2001-09-03', '男', 'c003'),
(1012, '万达', '2001-05-14', '男', 'c004'),
(1013, '李娟', '2000-09-14', '女', 'c004');
select * from tb_student;

-- tb_course:course_id，course_name
create table `tb_course`(
`course_id` varchar(4) primary key comment '课程号',
`course_name` varchar(20) comment '课程名称'
)comment '课程表';

insert into tb_course values('k001', '语文'),
('k002', '数学'),
('k003', '英语'),
('k004', '体育');
select * from tb_course;

-- tb_score:stu_id,course_id,score
create table `tb_score`(
`stu_id` int comment '学号',
`course_id`  varchar(4) comment '课程号',
`score` int comment '成绩'
)comment '成绩表';

-- 问题：建立了外键约束之后，无法插入数据
/*
constraint fk_stu_score foreign key(`stu_id`) references tb_student(`stu_id`)
*/
-- 解决方案：先移除外键，然后插入数据
-- alter table tb_score drop foreign key fk_stu_score;
-- alter table tb_score drop foreign key fk_cou_score;

insert into tb_score values(1, 'k001', 77),
(1, 'k002', 79),
(1, 'k003', 77),
(1, 'k004', 69),
(2, 'k001', 57),
(2, 'k002', 89),
(2, 'k004', 97),
(1000, 'k002', 69),
(1000, 'k001', 79),
(1001, 'k002', 89),
(1001, 'k001', 47),
(1001, 'k003', 59),
(1002, 'k001', 47),
(1002, 'k002', 69),
(1002, 'k003', 57),
(1002, 'k004', 59),
(1003, 'k002', 47),
(1003, 'k003', 49),
(1003, 'k004', 67),
(1004, 'k002', 89),
(1004, 'k003', 97),
(1005, 'k002', 89),
(1006, 'k001', 72),
(1006, 'k002', 75),
(1006, 'k004', 73),
(1007, 'k002', 89),
(1007, 'k004', 79),
(1008, 'k001', 99),
(1008, 'k003', 67),
(1009, 'k002', 82),
(1009, 'k003', 74),
(1009, 'k004', 72);
select * from tb_score;

-- 1. 统计每个学生的成绩信息，展示信息： 学号  总成绩  最高分  最低分
select stu_id,sum(score) 总成绩,max(score) 最高分,min(score) 最低分  from tb_score group by stu_id;

-- 2. 查找学生总成绩在270分及其以上的学生的学号与总成绩
-- 按照关键字的执行顺序，在执行having的时候还没有total_sal这个名词，但是mysql支持这个语法
-- select stu_id,sum(score) total_sal  from tb_score group by stu_id having total_sal>=270;
-- having的后面直接跟聚合函数
select stu_id,sum(score) total_score  from tb_score group by stu_id having sum(score)>=270;

-- 3. 统计每个学生不及格的科目数，展示信息：学号 不及格的科目数
-- 先筛选不及格的信息,在该数据的基础上，进行分组和计数
select stu_id,count(course_id) 不及格的科目数 from tb_score where score<60 group by stu_id;

-- 上述写法学生信息不够全面，没有不及格的，结果就不显示
-- count(x):只对指定字段的非空值进行计数
select stu_id,count(if(score<60,course_id,null)) 不及格的科目数 from tb_score group by stu_id;

-- 4. 统计每个学生的选课数
select stu_id,count(course_id) 选课数 from tb_score group by stu_id;

-- 5. 获取选修了所有课程的学生的学号，姓名，班级编号
/*
选修了什么课程：score
需要展示的信息：student

子查询：score.stu_id=student.stu_id
*/
-- 课程表中有几个数据，代表有几门可课
-- 查询选修了所有课程的学生号
-- select stu_id from tb_score group by stu_id having count(course_id)=(select count(*) from tb_course);

insert into tb_student values(1, '小明', '2001-09-03', '男', 'c002'),
(1002, '王小花', '2001-06-03', '男', 'c002');

-- 子查询：可以发生在同一张表中，也可以发生在不同的表中
select 
	stu_id,stu_name,class_id 
from 
	tb_student 
where 
	stu_id 
in 
	(select 
		stu_id 
	from 
		tb_score 
	group by 
		stu_id 
	having 
		count(course_id)=(select count(*) from tb_course)
	);

-- 6. 统计任何一门课程成绩都在70分以上的学生的学号，姓名
-- 方式一：任意一门课程都在70以上：每个学生的最低分大于70
-- select stu_id from tb_score group by stu_id having min(score)>70;
select 
	stu_id,
    stu_name
from 
	tb_student
where 
	stu_id 
in 
	(
    select 
		stu_id 
	from 
		tb_score 
	group by 
		stu_id 
	having 
		min(score)>70
    );
    
-- 方式二：统计每个学生70分以下的课程的数量
select 
	stu_id,
    stu_name
from 
	tb_student
where 
	stu_id 
in 
	(
    select 
		stu_id 
	from 
		tb_score 
	group by 
		stu_id 
	having 
		count(if(score<70,course_id,null))=0
    );

-- 7. 查询选修了英语课程的学生的学号和姓名	
/*
分析：
已知的信息：课程名称-----》course
要查询的信息：学号和姓名----》student
联系是score

实现思路：
a.从course表中查询已知课程名称的课程编号
	select course_id from tb_course where course_name='英语';
b.在score表中查询学了这门课的学生学号
	select stu_id from tb_score where course_id=(select course_id from tb_course where course_name='英语');
c.在student表中查询相应学号的学生信息
*/
select 
	stu_id,stu_name 
from 
	tb_student 
where 
	stu_id 
in 
	(
    select 
		stu_id 
	from 
		tb_score 
	where 
		course_id=(
        select 
			course_id 
		from 
			tb_course 
		where 
			course_name='英语'
		)
    );
    
create table `tb_class`(
`class_id` varchar(5) comment '班级号',
`class_name` varchar(10) comment '班级名称'
)comment '班级表';
insert into tb_class values('c002','Python'),('c003','Java'),('c004','C++');
select * from tb_class;

-- 8. 查询python班的学生的学号与姓名	
/*
已知的数据：班级----》class
查询的数据：学号与姓名	-----》student

实现思路：
a.查询python对应的班级号
b.在学生表中找到该编号对应的学生信息
*/
select 
	stu_id,stu_name
from
	tb_student
where
	class_id=(select class_id from tb_class where class_name='Python');

-- 9. 查询同名同姓学生姓名
-- 根据学生姓名分组，然后统计每组中名字出现2个及以上的数据
select stu_name from tb_student group by stu_name having count(*)>=2;

-- 10.获取每个班级中考试成绩前2名的同学信息
-- a.求每个学生的总分
select 
	stu.stu_id,stu_name,class_id,sum(ifnull(score,0))  total
from 
	tb_student stu left join tb_score sco 
on 
	stu.stu_id=sco.stu_id 
group by 
	stu_id;
    
-- b.
with total_score as 
	(select stu.stu_id,stu_name,class_id,sum(ifnull(score,0))  total from tb_student stu left join tb_score sco on stu.stu_id=sco.stu_id group by stu_id),
rank_score as (select * ,rank() over(partition by class_id order by total desc) rk from total_score)
select * from rank_score where rk<=2;

-- 11.低于本科目平均值的学生信息
with avg_score as (select course_id,avg(score) avgs from tb_score group by course_id)
select * from tb_student join tb_score join avg_score
on tb_student.stu_id=tb_score.stu_id and tb_score.course_id=avg_score.course_id
where score<avgs;
