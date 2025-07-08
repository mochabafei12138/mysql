### 一、with公共表达式【重点掌握】

> ```mysql
> use mydb1;
> 
> -- 1.创建一个临时表
> -- a.create table xxx (select ....)
> create table temp_table (select * from emp where deptno=30);
> select * from temp_table;
> 
> -- b.子查询
> select * from (select * from emp where deptno=30) new_emp;
> 
> -- c.with公共表达式
> /*
> 作用：定义一个临时的结果集，然后将其用作查询的一部分
> 语法：
> 	with temp_table as(
> 		-- 在此处定义临时表达式
>         select ......
>         from  old_table
>         where condotion
>     )
>     -- 使用创建的临时表达式
>     select * from temp_table;
>     
> 语法解释：
> 	temp_table：给临时表达式命名的标识符
>     as的关键字之后，可以编写一个普通的select语法来临时定义表达式
>     一旦定义了临时表达式，则可以在后面的查询中引用它
>     
> 通过使用with语句，可以清晰的组织复杂的sql,并使得sql语句可读性更高，后期的可维护性提高
> */
> with dept_30 as (
> 	select * from emp where deptno=30
> ) 
> select * from dept_30;
> 
> with table1 as(
> 	select empno,ename,birth,salary,deptno from emp where birth between '1980-01-01' and '1982-12-30'
> )
> select deptno,avg(salary) from table1 group by deptno;
> ```

### 二、综合案例讲解

#### 1.学生-课程-成绩-班级表建立及查询

> ```mysql
> -- tb_student: stu_id ,stu_name, gender, class_id
> 
> insert into tb_student values(1004, '李秀才', '2001-09-03', '男', 'c002'),
> (1005, '李大嘴', '2001-06-03', '男', 'c002'),
> (1006, '白展堂', '2002-11-17', '男', 'c002'),
> (1007, '张小六', '2001-09-03', '男', 'c003'),
> (1008, '白百欣', '2002-10-03', '女', 'c003'),
> (1009, '赵强', '2001-09-03', '男', 'c003'),
> (1010, '王倩倩', '2001-09-03', '男', 'c003'),
> (1011, '宋达达', '2001-09-03', '男', 'c003'),
> (1012, '万达', '2001-05-14', '男', 'c004'),
> (1013, '李娟', '2000-09-14', '女', 'c004');
> 
> -- tb_course:course_id，course_name
> insert into tb_course values('k001', '语文'),
> ('k002', '数学'),
> ('k003', '英语'),
> ('k004', '体育');
> 
> 
> -- tb_score:stu_id,course_id,score
> insert into tb_score values(1, 'k001', 77),
> (1, 'k002', 79),
> (1, 'k003', 77),
> (1, 'k004', 69),
> (2, 'k001', 57),
> (2, 'k002', 89),
> (2, 'k004', 97),
> (1000, 'k002', 69),
> (1000, 'k001', 79),
> (1001, 'k002', 89),
> (1001, 'k001', 47),
> (1001, 'k003', 59),
> (1002, 'k001', 47),
> (1002, 'k002', 69),
> (1002, 'k003', 57),
> (1002, 'k004', 59),
> (1003, 'k002', 47),
> (1003, 'k003', 49),
> (1003, 'k004', 67),
> (1004, 'k002', 89),
> (1004, 'k003', 97),
> (1005, 'k002', 89),
> (1006, 'k001', 72),
> (1006, 'k002', 75),
> (1006, 'k004', 73),
> (1007, 'k002', 89),
> (1007, 'k004', 79),
> (1008, 'k001', 99),
> (1008, 'k003', 67),
> (1009, 'k002', 82),
> (1009, 'k003', 74),
> (1009, 'k004', 72);
> 
> -- 1. 统计每个学生的成绩信息，展示信息： 学号  总成绩  最高分  最低分
> -- 2. 查找学生总成绩在270分及其以上的学生的学号与总成绩
> -- 3. 统计每个学生不及格的科目数，展示信息：学号 不及格的科目数
> -- 4. 统计每个学生的选课数
> -- 5. 获取选修了所有课程的学生的学号，姓名，班级编号
> -- 6. 统计任何一门课程成绩都在70分以上的学生的学号，姓名
> -- 7. 查询选修了英语课程的学生的学号和姓名	
> -- 8. 查询coding班的学生的学号与姓名	
> -- 9. 查询同名同姓学生姓名
> -- 10.获取每个班级中考试成绩前2名的同学信息
> -- 11.低于本科目平均值的学生信息
> ```

> ```mysql
> -- 一、建库及切换
> -- 创建库
> create database stu_sco_cou_db;
> -- 切换库
> use stu_sco_cou_db;
> 
> -- 二、建表及插入数据
> -- tb_student: stu_id ,stu_name,birth, gender, class_id
> create table `tb_student`(
> `stu_id` int primary key auto_increment comment '学号',
> `stu_name` varchar(10) not null comment '姓名',
> `birth` date comment '生日',
> `gender` char(1) comment '性别',
> `class_id` varchar(5) comment '班级号'
> ) comment '学生表';
> 
> insert into tb_student values(1004, '李秀才', '2001-09-03', '男', 'c002'),
> (1005, '李大嘴', '2001-06-03', '男', 'c002'),
> (1006, '白展堂', '2002-11-17', '男', 'c002'),
> (1007, '张小六', '2001-09-03', '男', 'c003'),
> (1008, '白百欣', '2002-10-03', '女', 'c003'),
> (1009, '赵强', '2001-09-03', '男', 'c003'),
> (1010, '王倩倩', '2001-09-03', '男', 'c003'),
> (1011, '宋达达', '2001-09-03', '男', 'c003'),
> (1012, '万达', '2001-05-14', '男', 'c004'),
> (1013, '李娟', '2000-09-14', '女', 'c004');
> select * from tb_student;
> 
> -- tb_course:course_id，course_name
> create table `tb_course`(
> `course_id` varchar(4) primary key comment '课程号',
> `course_name` varchar(20) comment '课程名称'
> )comment '课程表';
> 
> insert into tb_course values('k001', '语文'),
> ('k002', '数学'),
> ('k003', '英语'),
> ('k004', '体育');
> select * from tb_course;
> 
> -- tb_score:stu_id,course_id,score
> create table `tb_score`(
> `stu_id` int comment '学号',
> `course_id`  varchar(4) comment '课程号',
> `score` int comment '成绩'
> )comment '成绩表';
> 
> -- 问题：建立了外键约束之后，无法插入数据
> /*
> constraint fk_stu_score foreign key(`stu_id`) references tb_student(`stu_id`)
> */
> -- 解决方案：先移除外键，然后插入数据
> -- alter table tb_score drop foreign key fk_stu_score;
> -- alter table tb_score drop foreign key fk_cou_score;
> 
> insert into tb_score values(1, 'k001', 77),
> (1, 'k002', 79),
> (1, 'k003', 77),
> (1, 'k004', 69),
> (2, 'k001', 57),
> (2, 'k002', 89),
> (2, 'k004', 97),
> (1000, 'k002', 69),
> (1000, 'k001', 79),
> (1001, 'k002', 89),
> (1001, 'k001', 47),
> (1001, 'k003', 59),
> (1002, 'k001', 47),
> (1002, 'k002', 69),
> (1002, 'k003', 57),
> (1002, 'k004', 59),
> (1003, 'k002', 47),
> (1003, 'k003', 49),
> (1003, 'k004', 67),
> (1004, 'k002', 89),
> (1004, 'k003', 97),
> (1005, 'k002', 89),
> (1006, 'k001', 72),
> (1006, 'k002', 75),
> (1006, 'k004', 73),
> (1007, 'k002', 89),
> (1007, 'k004', 79),
> (1008, 'k001', 99),
> (1008, 'k003', 67),
> (1009, 'k002', 82),
> (1009, 'k003', 74),
> (1009, 'k004', 72);
> select * from tb_score;
> 
> -- 1. 统计每个学生的成绩信息，展示信息： 学号  总成绩  最高分  最低分
> select stu_id,sum(score) 总成绩,max(score) 最高分,min(score) 最低分  from tb_score group by stu_id;
> 
> -- 2. 查找学生总成绩在270分及其以上的学生的学号与总成绩
> -- 按照关键字的执行顺序，在执行having的时候还没有total_sal这个名词，但是mysql支持这个语法
> -- select stu_id,sum(score) total_sal  from tb_score group by stu_id having total_sal>=270;
> -- having的后面直接跟聚合函数
> select stu_id,sum(score) total_score  from tb_score group by stu_id having sum(score)>=270;
> 
> -- 3. 统计每个学生不及格的科目数，展示信息：学号 不及格的科目数
> -- 先筛选不及格的信息,在该数据的基础上，进行分组和计数
> select stu_id,count(course_id) 不及格的科目数 from tb_score where score<60 group by stu_id;
> 
> -- 上述写法学生信息不够全面，没有不及格的，结果就不显示
> -- count(x):只对指定字段的非空值进行计数
> select stu_id,count(if(score<60,course_id,null)) 不及格的科目数 from tb_score group by stu_id;
> 
> -- 4. 统计每个学生的选课数
> select stu_id,count(course_id) 选课数 from tb_score group by stu_id;
> 
> -- 5. 获取选修了所有课程的学生的学号，姓名，班级编号
> /*
> 选修了什么课程：score
> 需要展示的信息：student
> 
> 子查询：score.stu_id=student.stu_id
> */
> -- 课程表中有几个数据，代表有几门可课
> -- 查询选修了所有课程的学生号
> -- select stu_id from tb_score group by stu_id having count(course_id)=(select count(*) from tb_course);
> 
> insert into tb_student values(1, '小明', '2001-09-03', '男', 'c002'),
> (1002, '王小花', '2001-06-03', '男', 'c002');
> 
> -- 子查询：可以发生在同一张表中，也可以发生在不同的表中
> select 
> 	stu_id,stu_name,class_id 
> from 
> 	tb_student 
> where 
> 	stu_id 
> in 
> 	(select 
> 		stu_id 
> 	from 
> 		tb_score 
> 	group by 
> 		stu_id 
> 	having 
> 		count(course_id)=(select count(*) from tb_course)
> 	);
> 
> -- 6. 统计任何一门课程成绩都在70分以上的学生的学号，姓名
> -- 方式一：任意一门课程都在70以上：每个学生的最低分大于70
> -- select stu_id from tb_score group by stu_id having min(score)>70;
> select 
> 	stu_id,
>     stu_name
> from 
> 	tb_student
> where 
> 	stu_id 
> in 
> 	(
>     select 
> 		stu_id 
> 	from 
> 		tb_score 
> 	group by 
> 		stu_id 
> 	having 
> 		min(score)>70
>     );
>     
> -- 方式二：统计每个学生70分以下的课程的数量
> select 
> 	stu_id,
>     stu_name
> from 
> 	tb_student
> where 
> 	stu_id 
> in 
> 	(
>     select 
> 		stu_id 
> 	from 
> 		tb_score 
> 	group by 
> 		stu_id 
> 	having 
> 		count(if(score<70,course_id,null))=0
>     );
> 
> -- 7. 查询选修了英语课程的学生的学号和姓名	
> /*
> 分析：
> 已知的信息：课程名称-----》course
> 要查询的信息：学号和姓名----》student
> 联系是score
> 
> 实现思路：
> a.从course表中查询已知课程名称的课程编号
> 	select course_id from tb_course where course_name='英语';
> b.在score表中查询学了这门课的学生学号
> 	select stu_id from tb_score where course_id=(select course_id from tb_course where course_name='英语');
> c.在student表中查询相应学号的学生信息
> */
> select 
> 	stu_id,stu_name 
> from 
> 	tb_student 
> where 
> 	stu_id 
> in 
> 	(
>     select 
> 		stu_id 
> 	from 
> 		tb_score 
> 	where 
> 		course_id=(
>         select 
> 			course_id 
> 		from 
> 			tb_course 
> 		where 
> 			course_name='英语'
> 		)
>     );
>     
> create table `tb_class`(
> `class_id` varchar(5) comment '班级号',
> `class_name` varchar(10) comment '班级名称'
> )comment '班级表';
> insert into tb_class values('c002','Python'),('c003','Java'),('c004','C++');
> select * from tb_class;
> 
> -- 8. 查询python班的学生的学号与姓名	
> /*
> 已知的数据：班级----》class
> 查询的数据：学号与姓名	-----》student
> 
> 实现思路：
> a.查询python对应的班级号
> b.在学生表中找到该编号对应的学生信息
> */
> select 
> 	stu_id,stu_name
> from
> 	tb_student
> where
> 	class_id=(select class_id from tb_class where class_name='Python');
> 
> -- 9. 查询同名同姓学生姓名
> -- 根据学生姓名分组，然后统计每组中名字出现2个及以上的数据
> select stu_name from tb_student group by stu_name having count(*)>=2;
> 
> -- 10.获取每个班级中考试成绩前2名的同学信息
> -- a.求每个学生的总分
> select 
> 	stu.stu_id,stu_name,class_id,sum(ifnull(score,0))  total
> from 
> 	tb_student stu left join tb_score sco 
> on 
> 	stu.stu_id=sco.stu_id 
> group by 
> 	stu_id;
>     
> -- b.
> with total_score as 
> 	(select stu.stu_id,stu_name,class_id,sum(ifnull(score,0))  total from tb_student stu left join tb_score sco on stu.stu_id=sco.stu_id group by stu_id),
> rank_score as (select * ,rank() over(partition by class_id order by total desc) rk from total_score)
> select * from rank_score where rk<=2;
> 
> -- 11.低于本科目平均值的学生信息
> with avg_score as (select course_id,avg(score) avgs from tb_score group by course_id)
> select * from tb_student join tb_score join avg_score
> on tb_student.stu_id=tb_score.stu_id and tb_score.course_id=avg_score.course_id
> where score<avgs;
> ```

#### 2.员工-部门-工资等级建立及查询

> ```mysql
> -- 一、建表
> /*
> 部门表:dept
> 	部门编号(主键):dno
> 	部门名称(不能为空):dname
> 	部门地址(不能为空):daddr
> */
> create table  `dept`(
> `dno` int primary key comment '部门编号',
>  `dname` varchar(10) not null comment '部门名称',
>  `daddr` varchar(10) not null comment '部门地址'
> )comment '部门表';
> 
> /*
> 员工表:emp
> 	员工编号(主键):eno
> 	员工名称(不能为空):ename
> 	员工岗位:ejob
> 	所属领导编号 【外键】 :managerid
> 	入职日期:hiredate
> 	薪水:salary
> 	提成:comm
> 	部门编号【外键】:dno
> */
> create table `emp`(
>  `eno` int primary key comment '工号',
>  `ename` varchar(30) not null comment '员工姓名',
>  `ejob` varchar(20) comment '工作',
>  `managerid` int comment '领导编号',
>  `hiredate` date comment '入职日期',
>  `salary` int comment '薪资',
>  `comm` int comment '奖金',
>  `dno` int comment '部门编号',
>  constraint fk_dno foreign key(dno) references dept(dno),     -- 和dept表进行关联
>  constraint fk_manager foreign key(managerid) references emp(eno) -- 领导本质也是员工，和自身关联
> )comment '员工表';
> desc dept;
> desc emp;
> 
> -- 二、添加数据
> insert into dept values 
> (10,'财务部','北京'),
> (20,'研发部','上海'),
> (30,'销售部','广州'),
> (40,'行政部','深圳');
> 
> 
> -- 添加员工数据
> insert into emp values 
> (7839,'吴九','总裁',7839,'1981-11-17',5000,0,10),
> (7566,'李四','经理',7839,'1981-04-02',2975,0,20),
> (7698,'赵六','经理',7839,'1981-05-01',2850,0,30),
> (7782,'孙七','经理',7839,'1981-06-09',2450,0,10),
> (7902,'大锦鲤','分析师',7566,'1981-12-03',3000,0,20),
> (7788,'周八','分析师',7566,'1987-06-13',3000,0,20),
> (7654,'王五','推销员',7698,'1981-09-28',1250,1400,30),
> (7369,'刘一','职员',7902,'1980-12-17',800,0,20),
> (7499,'陈二','推销员',7698,'1981-02-20',1600,300,30),
> (7521,'张三','推销员',7698,'1981-02-22',1250,500,30),
> (7844,'郑十','推销员',7698,'1981-09-08',1500,0,30),
> (7876,'郭十一','职员',7788,'1987-06-13',1100,0,20),
> (7900,'钱多多','职员',7698,'1981-12-03',950,0,30),
> (7934,'木有钱','职员',7782,'1983-01-23',1300,0,10);
> INSERT INTO emp VALUES(7369,'smith','clerk',7902,"1980-12-17",800,NULL,20);
> INSERT INTO emp VALUES(7499,'allen','salesman',7698,'1981-02-20',1600,300,30);
> INSERT INTO emp VALUES(7521,'ward','salesman',7698,'1981-02-22',1250,500,30);
> INSERT INTO emp VALUES(7566,'jones','manager',7839,'1981-04-02',2975,NULL,20);
> INSERT INTO emp VALUES(7654,'martin','salesman',7698,'1981-09-28',1250,1400,30);
> INSERT INTO emp VALUES(7698,'blake','manager',7839,'1981-05-01',2850,NULL,30);
> INSERT INTO emp VALUES(7782,'clark','manager',7839,'1981-06-09',2450,NULL,10);
> INSERT INTO emp VALUES(7788,'scott','analyst',7566,'1987-07-03',3000,NULL,20);
> INSERT INTO emp VALUES(7839,'king','president',NULL,'1981-11-17',5000,NULL,10);
> INSERT INTO emp VALUES(7844,'turner','salesman',7698,'1981-09-08',1500,0,30);
> INSERT INTO emp VALUES(7876,'adams','clerk',7788,'1987-07-13',1100,NULL,20);
> INSERT INTO emp VALUES(7900,'james','clerk',7698,'1981-12-03',950,NULL,30);
> INSERT INTO emp VALUES(7902,'ford','analyst',7566,'1981-12-03',3000,NULL,20);
> INSERT INTO emp VALUES(7934,'miller','clerk',7782,'1981-01-23',1300,NULL,10);
> 
> 
> -- 三、查询数据
> -- 1.列出至少有一个员工的所有部门。
> -- 2.列出薪金比"刘一"多的所有员工。
> -- 3.列出所有员工的姓名及其直接上级的姓名。
> -- 4.列出薪资高于其直接上级的所有员工。
> -- 5.列出部门名称和这些部门的员工信息，同时列出那些没有员工的部门。
> -- 6.列出所有job为“职员”的姓名。
> -- 7.列出最低薪金大于1500的各种工作。
> -- 8.列出在部门 "销售部" 工作的员工的姓名，假定不知道销售部的部门编号。
> -- 9.列出薪金高于公司平均薪金的所有员工。
> -- 10.列出与"周八"从事相同工作的所有员工。
> -- 11.列出薪金等于部门30中员工的薪金的所有员工的姓名和薪金。
> -- 12.列出薪金高于在部门30工作的所有员工的薪金的员工姓名和薪金。
> -- 13.列出在每个部门工作的员工数量、平均工资。
> -- 14.列出所有员工的姓名、部门名称和工资。
> -- 15.列出所有部门的详细信息和部门人数。
> -- 16.列出各种工作的最低工资。
> -- 17.列出各个部门的 经理 的最低薪金。
> -- 18.查出emp表中薪水在3000以上（包括3000）的所有员工的员工号、姓名、薪水。
> -- 19.查询出所有薪水在'陈二'之上的所有人员信息。
> -- 20.查询出emp表中部门编号为20，薪水在2000以上（不包括2000）的所有员工，
> -- 21.查询出所有奖金（comm）字段不为空的人员的所有信息。
> -- 22.查询出薪水在800到2500之间（闭区间）所有员工的信息。
> -- 23.查询出员工号为7521，7900，7782的所有员工的信息
> -- 24.查询出名字中有“张”字符，并且薪水在1000以上（不包括1000）的所有员工信息
> -- 25.查询出名字第三个汉字是“多”的所有员工信息
> -- 26.查询出最早工作的那个人的名字、入职时间和薪水。
> -- 27.显示出薪水最高人的职位。
> -- 28.获取每个部门中最高薪资对应的员工信息
> -- 29.获取每个部门中在部门平均薪资以下的员工的信息
> ```

> ```mysql
> create database emp_dept_grade_db;
> use emp_dept_grade_db;
> 
> -- 一、建表
> /*
> 部门表:dept
> 	部门编号(主键):dno
> 	部门名称(不能为空):dname
> 	部门地址(不能为空):daddr
> */
> create table  `dept`(
> `dno` int primary key comment '部门编号',
>  `dname` varchar(10) not null comment '部门名称',
>  `daddr` varchar(10) not null comment '部门地址'
> )comment '部门表';
> 
> /*
> 员工表:emp
> 	员工编号(主键):eno
> 	员工名称(不能为空):ename
> 	员工岗位:ejob
> 	所属领导编号 【外键】 :managerid
> 	入职日期:hiredate
> 	薪水:salary
> 	提成:comm
> 	部门编号【外键】:dno
> */
> create table `emp`(
>  `eno` int primary key comment '工号',
>  `ename` varchar(30) not null comment '员工姓名',
>  `ejob` varchar(20) comment '工作',
>  `managerid` int comment '领导编号',
>  `hiredate` date comment '入职日期',
>  `salary` int comment '薪资',
>  `comm` int comment '奖金',
>  `dno` int comment '部门编号',
>  constraint fk_dno foreign key(dno) references dept(dno),     -- 和dept表进行关联
>  constraint fk_manager foreign key(managerid) references emp(eno) -- 领导本质也是员工，和自身关联
> )comment '员工表';
> desc dept;
> desc emp;
> 
> -- 二、添加数据
> insert into dept values 
> (10,'财务部','北京'),
> (20,'研发部','上海'),
> (30,'销售部','广州'),
> (40,'行政部','深圳');
> 
> 
> -- 添加员工数据
> insert into emp values 
> (7839,'吴九','总裁',7839,'1981-11-17',5000,0,10),
> (7566,'李四','经理',7839,'1981-04-02',2975,0,20),
> (7698,'赵六','经理',7839,'1981-05-01',2850,0,30),
> (7782,'孙七','经理',7839,'1981-06-09',2450,0,10),
> (7902,'大锦鲤','分析师',7566,'1981-12-03',3000,0,20),
> (7788,'周八','分析师',7566,'1987-06-13',3000,0,20),
> (7654,'王五','推销员',7698,'1981-09-28',1250,1400,30),
> (7369,'刘一','职员',7902,'1980-12-17',800,0,20),
> (7499,'陈二','推销员',7698,'1981-02-20',1600,300,30),
> (7521,'张三','推销员',7698,'1981-02-22',1250,500,30),
> (7844,'郑十','推销员',7698,'1981-09-08',1500,0,30),
> (7876,'郭十一','职员',7788,'1987-06-13',1100,0,20),
> (7900,'钱多多','职员',7698,'1981-12-03',950,0,30),
> (7934,'木有钱','职员',7782,'1983-01-23',1300,0,10);
> select * from emp;
> 
> -- 三、查询数据
> -- 1.列出至少有一个员工的所有部门。
> select dno,count(*) from emp group by dno having count(*)>=1;
> 
> -- 2.列出薪金比"刘一"多的所有员工。
> select * from emp where (salary+comm)>(select salary+comm from emp where ename='刘一');
> 
> -- 3.列出所有员工的姓名及其直接上级的姓名。
> /*
> 员工表：emp
> 领导表：emp
> 因为只有一一张表，所以进行自连接
> 联系条件：普通员工的领导编号=领导的自身编号
> */
> select emp.ename 员工姓名,manager.ename 领导姓名 from emp join emp as manager on emp.managerid=manager.eno;
> 
> -- 4.列出薪资高于其直接上级的所有员工。
> select 
> 	emp.ename 员工姓名,emp.salary 员工薪资,manager.ename 领导姓名,manager.salary 领导薪资 
> from emp 
> join emp as manager 
> on emp.managerid=manager.eno
> where emp.salary>manager.salary;
> 
> -- 5.列出部门名称和这些部门的员工信息，同时列出那些没有员工的部门。
> select dname,emp.* from dept left join emp on dept.dno=emp.dno;
> 
> -- 6.列出所有job为“职员”的姓名。
> select ename,ejob from emp where ejob='职员';
> 
> -- 7.列出最低薪金大于1500的各种工作。
> select ejob from emp group by ejob having min(salary)>1500;
> 
> -- 8.列出在部门 "销售部" 工作的员工的姓名，假定不知道销售部的部门编号。
> -- 方式一
> select ename from emp where dno=(select dno from dept where dname='销售部');
> -- 方式二
> select ename from emp left join dept on emp.dno=dept.dno where dept.dname='销售部';
> 
> -- 9.列出薪金高于公司平均薪金的所有员工。
> select * from emp where salary>(select avg(salary) from emp);
> 
> -- 10.列出与"周八"从事相同工作的所有员工。
> select * from emp where ejob=(select ejob from emp where ename='周八') and ename!='周八';
> 
> -- 11.列出薪金等于部门30中员工的薪金的所有员工的姓名和薪金。
> select ename,salary from emp where salary in (select salary from emp where dno=30) and dno!=30;
> select ename,salary from emp where salary=any(select salary from emp where dno=30) and dno!=30;
> 
> -- 12.列出薪金高于在部门30工作的所有员工的薪金的员工姓名和薪金。
> select ename,salary from emp where salary>(select max(salary) from emp where dno=30) and dno!=30;
> select ename,salary from emp where salary>all(select salary from emp where dno=30) and dno!=30;
> 
> -- 13.列出在每个部门工作的员工数量、平均工资。
> select count(*),avg(salary) from emp group by dno;
> 
> -- 14.列出所有员工的姓名、部门名称和工资。
> select ename,dname,salary from emp left join dept on emp.dno=dept.dno;
> 
> -- 15.列出所有部门的详细信息和部门人数。
> select dept.*,count(if(eno is null,null,eno)) from emp right join dept on emp.dno=dept.dno group by emp.dno;
> 
> -- 16.列出各种工作的最低工资。
> select ejob,min(salary) from emp group by ejob;
> 
> -- 17.列出各个部门的 经理 的最低薪金。
> select dno,min(salary) from emp where ejob='经理' group by dno;
> 
> -- 18.查出emp表中薪水在3000以上（包括3000）的所有员工的员工号、姓名、薪水。
> select eno,ename,salary from emp where salary>=3000;
> 
> -- 19.查询出所有薪水在'陈二'之上的所有人员信息。
> select * from emp where salary>(select salary from emp where ename='陈二');
> 
> -- 20.查询出emp表中部门编号为20，薪水在2000以上（不包括2000）的所有员工，
> select * from emp where dno=20 and salary>2000;
> 
> -- 21.查询出所有奖金（comm）字段不为空的人员的所有信息。
> select * from emp where comm is not null;
> 
> -- 22.查询出薪水在800到2500之间（闭区间）所有员工的信息。
> select * from emp where salary between 800 and 2500;
> 
> -- 23.查询出员工号为7521，7900，7782的所有员工的信息
> select * from emp where eno in (7521,7900,7782);
> 
> -- 24.查询出名字中有“张”字符，并且薪水在1000以上（不包括1000）的所有员工信息
> select * from emp where ename like '%张%' and salary>1000;
> 
> -- 25.查询出名字第三个汉字是“多”的所有员工信息
> select * from emp where ename like '__多';
> 
> -- 26.查询出最早工作的那个人的名字、入职时间和薪水。
> select ename,hiredate,salary from emp where hiredate=(select min(hiredate) from emp);
> 
> -- 27.显示出薪水最高人的职位。
> select ejob from emp where salary=(select max(salary) from emp);
> 
> -- 28.获取每个部门中最高薪资对应的员工信息
> select 
> 	emp.*
> from 
> 	(select dno,max(salary) max_sal from emp group by dno) max_sal_t
> left join emp
> on emp.dno=max_sal_t.dno and emp.salary=max_sal_t.max_sal;
> 
> -- 29.获取每个部门中在部门平均薪资以下的员工的信息
> -- 方式一：子查询
> select 
> 	emp.*,avg_sal
> from 
> 	(select dno,avg(salary) avg_sal from emp group by dno) avg_sal_t
> left join emp
> on emp.dno=avg_sal_t.dno and emp.salary<avg_sal_t.avg_sal;
> 
> -- 方式二：with连接查询
> with dept_avg as (select dno,avg(salary) avg_sal from emp group by dno)
> select emp.*,avg_sal from emp join dept_avg on emp.dno=dept_avg.dno 
> where salary<avg_sal;
> 
> -- 方式三：窗口函数
> with avgs_t as (select *,avg(salary) over(partition by dno) avg_sal from emp)
> select * from avgs_t where salary<avg_sal;
> 
> -- 扩展
> -- 30.找出姓名以a,b,s开头的员工信息
> -- 方式一
> select * from emp where ename like 'a%' or ename like 'b%' or ename like 's%';
> -- 方式二
> select * from emp where left(ename,1) in ('a','b','s');
> -- 方式三：正则【自学】
> select * from emp where ename regexp '^[abs]';
> 
> -- 31.获取每个部门中薪资排名前两名的员工信息
> -- 方式一：子查询
> select * from (select *,row_number() over(partition by dno order by salary desc) sal_rank from emp) new_emp
> where sal_rank<=2;
> -- 方式二：with
> with tb_rank as (select *,row_number() over(partition by dno order by salary desc) sal_rank from emp)
> select * from tb_rank where sal_rank<=2;
> 
> -- 32.返回工资为二级的员工姓名，部门的所在地
> create table `salgrade`(
> `grade` int comment '等级',
> `minsal` double comment '最低薪资',
> `maxsal` double comment '最高薪资'
> ) comment '薪资等级表';
> insert into salgrade value(1,500,1200);
> insert into salgrade value(2,1201,1400);
> insert into salgrade value(3,1401,2000);
> insert into salgrade value(4,2001,3000);
> insert into salgrade value(5,3001,10000);
> 
> -- 三张表进行连接，a join b join c join .....
> select emp.*,dname,daddr,salgrade.* from emp join dept join salgrade on emp.dno=dept.dno and salary between minsal and maxsal where grade=2;
> ```

### 三、窗口函数【重点掌握】

#### 1.窗口偏移函数-同比环比定比

> ```mysql
> create table if not exists tb_ym_sales(
>     yearly int comment '年份',
>     monthly int comment '月份',
>     sales int comment '销量',
>   	primary key(yearly, monthly)
> );
> insert into tb_ym_sales values
> (2021, 1, 84),
> (2021, 2, 24),
> (2021, 3, 50),
> (2021, 4, 73),
> (2021, 5, 65),
> (2021, 6, 91),
> (2021, 7, 52),
> (2021, 8, 85),
> (2021, 9, 57),
> (2021, 10, 32),
> (2021, 11, 64),
> (2021, 12, 69),
> (2022, 1, 82),
> (2022, 2, 13),
> (2022, 3, 52),
> (2022, 4, 55),
> (2022, 5, 87),
> (2022, 6, 32),
> (2022, 7, 46),
> (2022, 8, 81),
> (2022, 9, 14),
> (2022, 10, 68),
> (2022, 11, 51),
> (2022, 12, 56);
> ```

> ```mysql
> use mydb1;
> 
> create table if not exists tb_ym_sales(
>     yearly int comment '年份',
>     monthly int comment '月份',
>     sales int comment '销量',
>   	primary key(yearly, monthly)
> );
> insert into tb_ym_sales values
> (2021, 1, 84),
> (2021, 2, 24),
> (2021, 3, 50),
> (2021, 4, 73),
> (2021, 5, 65),
> (2021, 6, 91),
> (2021, 7, 52),
> (2021, 8, 85),
> (2021, 9, 57),
> (2021, 10, 32),
> (2021, 11, 64),
> (2021, 12, 69),
> (2022, 1, 82),
> (2022, 2, 13),
> (2022, 3, 52),
> (2022, 4, 55),
> (2022, 5, 87),
> (2022, 6, 32),
> (2022, 7, 46),
> (2022, 8, 81),
> (2022, 9, 14),
> (2022, 10, 68),
> (2022, 11, 51),
> (2022, 12, 56);
> 
> select * from tb_ym_sales;
> 
> /*
> 注意：偏移函数的本质是窗口函数，所以仍然遵循窗口函数的语法
> 
> 偏移函数的使用场景：
> 环比：相比于上一个月增长了多少
> 	计算公式：(本月数据-上月数据)/上月数据-----》本月数据/上月数据 - 1
>     lag(偏移字段，偏移个数，如如果不存在相应的数据的填充值)：把数据向下偏移
>     lead(偏移字段，偏移个数，如如果不存在相应的数据的填充值):把数据向上偏移
>     注意：偏移个数不书写，则默认为1
> 		  如果不存在相应的数据的填充值，默认的填充值是null
>           
> 同比：和去年相同月份进行对比增长了多少
> 	计算公式：(本月数据-去年相同月份的数据)/去年相同月份的数据 -----》本月数据/去年相同月份的数据 - 1
>     lag(字段,12)
> 
> 定比：和固定的某一个值进行比较，比如：相对于同年一月份增长了多少
> 	first_value(字段)：获取窗口中出现的第一个数据
>     计算公式：(本月数据-固定数据)/固定数据-----》本月数据/固定数据 - 1
> */
> 
> -- 1.环比
> -- 需要把数据值，按照年份月份从小到大的顺序，将salas的数据向下偏移1个
> -- 向下偏移    *******
> select *,lag(sales) over(order by yearly,monthly) 上个月的销量,
>  (sales/lag(sales) over(order by yearly,monthly) - 1) 环比
> from  tb_ym_sales;
> 
> -- 向上偏移
> select *,lead(sales) over(order by yearly,monthly) 下个月的销量
> from  tb_ym_sales;
> 
> -- 2.定比
> select *,first_value(sales) over(order by yearly,monthly)  第一个销量,   -- 未分组，获取的是整个窗口的第一个数据
> (sales/first_value(sales) over(order by yearly,monthly) - 1)  定比
> from tb_ym_sales;
> 
> -- 3.同比
> select *,lag(sales,12) over(order by yearly,monthly) 去年相同月份的销量,
> (sales/lag(sales,12) over(order by yearly,monthly) - 1) 同比
> from tb_ym_sales;
> 
> -- 4.整合
> select *,lag(sales) over(order by yearly,monthly) 上个月的销量,
>  (sales/lag(sales) over(order by yearly,monthly) - 1) 环比,
>  lead(sales) over(order by yearly,monthly) 下个月的销量,
>  first_value(sales) over(order by yearly,monthly)  第一个销量,
>  (sales/first_value(sales) over(order by yearly,monthly) - 1)  定比,
>  lag(sales,12) over(order by yearly,monthly) 去年相同月份的销量,
>  (sales/lag(sales,12) over(order by yearly,monthly) - 1) 同比
> from  tb_ym_sales;
> 
> -- 5.上述求环比，定比和同比，是没有区分年的，只是直接获取上个月
> -- 在同一年中检查指标【数据偏移的时候不能跨年，每年是独立的------》每年是一个单独的窗口】
> -- 通过分组实现不同的窗口，在每个窗口的内部，实现排序
> select *,lag(sales) over(partition by yearly order by monthly) 上个月的销量,
> first_value(sales) over(partition by yearly order by monthly) 	1月份销量,
> (sales/lag(sales) over(partition by yearly order by monthly) - 1) 环比,
> (sales/first_value(sales) over(partition by yearly order by monthly) - 1)  定比
> from  tb_ym_sales;
> 
> ```

#### 2.子窗口-近n月销售和

> ```mysql
> /*
> frame子窗口
> 	在大窗口的基础上进行细分，对每个细分的窗口进行相应的运算
>     
> 进行窗口细分的方式：
> 1.按照行进行细分
> 	over(partition by 分组字段 order by 排序字段  rows between A and B) 
>     A和B数据有以下信息：
> 		current row:当前行
>         unbounded preceding:窗口的第一行
>         unbounded following:窗口的最后一行
>         N preceding:前n行【建立在当前行为基础之上】
>         N following:后n行【建立在当前行为基础之上】
> */
> 
> -- 需求：求近三个月的销售和
> -- 近xx的时候都是右参照点的，比如近3天，以今天作为基准点，就是前天，昨天和今天
> -- 实现的前提条件：必须要排序，保证数据计算的顺序【整个结果集是一个大窗口】
> -- 在大窗口的基础上设定小窗口，按照当前行进行移动，直到当前行为窗口中的最后一行则结束
> select *,sum(sales) over(order by yearly,monthly  rows between 2 preceding and current row) 近三个月的销量
> from tb_ym_sales;
> 
> /*
> 2.按照范围进行细分
> 	over(partition by 分组字段 order by 排序字段  range between A and B) 
>     A和B数据有以下信息：
> 		current row:当前行
>         unbounded preceding:窗口的第一个数据
>         unbounded following:窗口的最后一个数据
>         N preceding：当前数据 - n【建立在当前行为基础之上】
>         N following: 当前数据 + n【建立在当前行为基础之上】
> */
> -- 需求：统计当前月销量上下偏移30的，在这个范围内的月的个数
> select *,count(monthly) over(order by sales  range between 30 preceding and 30 following) 上下浮动30月份个数
> from tb_ym_sales;
> 
> 
> -- 思考问题：近3个月，如果月份的数据是连续的，可以使用行的概念来划分子窗口，但是如果月份的数据不连续，再使用行的概念会 不准确
> /*
> 1  27
> 2  84
> 3  30
> 4  52
> 6  77
> 7  88
> 
> 以6月份为基准，近3个月----》4月+5月+6月
> 但是以行的概念来说，6月份求销售和的时候，3 + 4 + 6的销售额，这是不准确的
> 
> 像这种不连续的数据如何处理？
> 	需要从时间维度处理，从时间范围进行偏移，而不是行
>     可以把给定的数据设置为时间格式，建立一个时间辅助表，该表中的时间数据是连续的，该表和原表进行连接查询
> */
> 
> -- 删除2021.5的数据
> delete from tb_ym_sales where yearly=2021 and monthly=5;
> -- 按照行偏移求近3个月的销售和
> select *,sum(sales) over(order by yearly,monthly  rows between 2 preceding and current row) 近三个月的销量
> from tb_ym_sales;
> 
> 
> -- 解决方案
> -- 第一步：生成一个辅助表
> -- recursive：控制的逻辑是一个循环的机制
> with recursive tb_month(monthly) as (
> 	select 1 monthly   -- 相当于python中monthly=1
>     union all 
>     select monthly + 1 from tb_month where monthly<12
> )select * from tb_month;
> 
> -- 上述循环等价于下面的写法：
> select 1 monthly  
> union all 
> select 2 monthly 
> union all 
> select 3 monthly 
> union all 
> select 4 monthly 
> union all 
> select 5 monthly 
> union all 
> select 6 monthly 
> union all 
> select 7 monthly 
> union all 
> select 8 monthly 
> union all 
> select 9 monthly 
> union all 
> select 10 monthly 
> union all 
> select 11 monthly 
> union all 
> select 12 monthly ;
> 
> -- 第二步：循环生成一个日期
> with recursive tb_month(dt) as (
> 	select '2021-01-01' dt    -- 初始化第一个日期
>     union all 
>     select date_add(dt,interval 1 month) from tb_month where dt<'2022-12-01'
> )select year(dt) yearly,month(dt) monthly from tb_month;
> 
> -- 第三步：连接查询
> with recursive tb_month(dt) as (
> 	select '2021-01-01' dt    -- 初始化第一个日期
>     union all 
>     select date_add(dt,interval 1 month) from tb_month where dt<'2022-12-01'
> )select year(dt) yearly,month(dt) monthly,tb_ym_sales.* from tb_month left join tb_ym_sales 
> on year(dt) = yearly and month(dt)=monthly;
> 
> -- 第四步：此时进行行偏移，求近三个月的销售和
> with recursive tb_month(dt) as (
> 	select '2021-01-01' dt    -- 初始化第一个日期
>     union all 
>     select date_add(dt,interval 1 month) from tb_month where dt<'2022-12-01'
> )select year(dt) yearly,month(dt) monthly,sales,
> sum(sales) over(order by year(dt),month(dt)  rows between 2 preceding and current row) 近三个月和
>  from tb_month left join tb_ym_sales 
> on year(dt) = yearly and month(dt)=monthly;
> ```



