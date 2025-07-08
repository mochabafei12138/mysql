### 一、DQL

#### 1.排序-order by

> select  * from stu  where score>80 ;
>
> 我们已经看到使用SQL SELECT命令从MySQL表中获取数据。当选择数据行，MySQL服务器可以自由地返回它们的顺序，除非有指示它按照怎样的结果进行排序。但是排序结果可以通过增加一个ORDER BY子句设定列名称或要排序的列。
>
> order   by :指定数据返回的顺序，用法：select  xx  from 表 order by  字段 排序方式
>
> 排序方式：
>
> ​	asc:升序【Ascending】，可以省略，默认就是升序
>
> ​	desc:降序【Descending】
>
> ```python
> 注意：
> 	a.根据指定字段排序，默认升序[asc],降序为desc
> 	b.可以在多个字段排序结果，如果多个条件进行排序，只有当前一个条件的值相同时，才会比较第二个条件，格式：order by 排序字段1 排序方式 ，排序字段2 排序方式 ，... 
> 	d.可以使用WHERE ... LIKE子句以通用的方式放置条件
> ```

> ```mysql
> -- a.查询所有学生的信息，按照成绩升序排序
> -- b.查询所有学生的信息，按照成绩降序排序
> -- c.查询成绩及格的学生信息，按照年龄降序排序
> -- d.查询所有学生的信息，按照年龄降序排序，如果年龄相同，则按照成绩升序排序
> ```

> ```mysql
> -- 重新打开链接，一定要做两件事  
> -- 第一步：选择数据库【切换数据库】，否则 No database seletecd   *********
> use mydb1;
> -- 第二步：查询需要使用的数据库
> select * from student;
> 
> -- a.查询所有学生的信息，按照成绩升序排序
> select * from student order by score;
> select * from student order by score asc;
> 
> -- b.查询所有学生的信息，按照成绩降序排序
> select * from student order by score desc;
> 
> -- c.查询成绩及格的学生信息，按照年龄降序排序
> -- select xx from xx where xx order by xx
> select * from student where score >= 60 order by age desc;
> 
> -- d.查询所有学生的信息，按照年龄降序排序，如果年龄相同，则按照成绩升序排序
> select * from student order by age desc,score asc;
> 
> -- e.查询所有学生的信息，按照成绩降序排序，如果成绩相同，则按照学号降序排序
> select * from student order by score desc,sid desc;
> 
> ```

#### 2.聚合函数

> 概念：将一列数据作为一个整体，进行纵向的计算,将可以用来做纵向运算的函数称为聚合函数
>
> avg()：计算平均值
>
> sum()：求和
>
> max()：求最大值
>
> min()：求最小值
>
> count()：求个数
>
> 1>count():统计指定列不为null的记录行数
>
>  注意：count()中一般使用非空字段或者  *
>
> 2>sum():计算指定列的数值和，如果指定列类型不是数值类型，那么计算结果为0
>
> 3>max():计算指定列的最大值，如果指定列是字符串类型，那么使用字符串排序运算
>
> ​    min():计算指定列的最小值，如果指定列是字符串类型，那么使用字符串排序运算
>
> 4>avg():计算指定列的平均值，如果指定列类型不是数值类型，那么计算结果为0
>
> ```sql
> -- a.查询stu表中记录的条数
> -- b.查询成绩及格的人数
> -- c.查询全班同学的最高分
> -- d.查询全班同学的最低分
> -- e.计算全班学生的总分
> -- f.统计全班学生的平均分
> -- g.查询年龄在15~30岁的学生的最高成绩
> -- h.查询姓张的学生的平均年龄
> ```

> ```mysql
> -- a.查询student表中记录的条数
> select count(*) from student;
> -- 注意：count针对任意类型的字段都可以做统计，只是计数，如果明确字段则使用字段名称，如果未明确字段则直接使用*
> -- 统计指定列不为null的记录行数
> insert into student (sid,name,age) value (1007,'yuw',12),(1009,'cnhf',8),(1010,'lks',9),(1012,'tom',10);
> -- 统计成绩非空的数据的条数
> select count(*) from student where score is not null;  -- 17
> select count(score) from student;    -- 17
> 
> -- b.查询成绩及格的人数
> select count(*) from student where score >= 60;
> 
> -- c.查询全班同学的最高分
> select max(score) from student;
> 
> -- d.查询全班同学的最低分
> select min(score) from student;
> select max(score) as 最高分,min(score) as 最低分 from student;
> 
> -- e.计算全班学生的总分
> select sum(score) from student;
> 
> -- f.统计全班学生的平均分
> select sum(score)/count(*) from student;  -- 50.0952
> select sum(score)/count(score) from student;  -- 61.8824
> -- avg只针对非空数据求平均值
> select avg(score) from student;    -- 61.8824
> 
> -- g.查询年龄在10~12岁的学生的最高成绩
> select max(score) from student where age between 10 and 12;
> 
> -- h.查询姓张的学生的平均年龄
> select avg(age) from student where name like '张%';
> ```

#### 3.分组查询-group by

> group by:分组查询
>
> having:有….，表示条件
>
> 注意:
>
> ​	a.分组后查询的字段应该且只能是：分组字段、聚合函数
>
> ​	b.where和having的区别：
>
> ​		where在分组前进行筛选，如果不满足where条件则不进入分组。having在分组后进行筛选，如果不满足则不被查询到
>
> ​		where后不能跟聚合函数，having后可以使用聚合函数进行筛选
>
> ```mysql
> insert into emp values(7369,'smith','male','clark',7902,'1980-12-17',800,null,20);
> insert into emp values(7499,'allen','female','salesman',7698,'1981-02-20',1600,300,30);
> insert into emp values(7521,'ward','male','salesman',7698,'1981-02-22',1250,500,30);
> insert into emp values(7566,'jones','female','managen',7839,'1981-04-02',2975,null,30);
> insert into emp values(7654,'martin','male','salesman',7698,'1981-09-28',1250,1400,30);
> insert into emp values(7698,'blake','female','manager',7839,'1981-05-01',2850,null,30);
> insert into emp values(7782,'clark','female','manageer',7839,'1980-06-17',2450,null,10);
> insert into emp values(7788,'scott','male','analyst',7566,'1987-02-20',3000,null,20);
> insert into emp values(7839,'king','male','president',null,'1987-02-20',5000,null,10);
> 
> -- a.查询每个部门的平均薪资
> -- b.分别查询男员工和女员工的最高收入
> -- c.查询每个部门的女员工的平均薪资，最终的结果以降序排序
> -- d.查询平均薪资大于3000的部门
> -- e.查询每个部门男员工平均薪资大于4000的部门
> ```

> ```mysql
> create table `emp`(
> `empno` int comment '工号',
> `ename` varchar(20) comment '姓名',
> `gender` varchar(10) comment '性别',
> `job` varchar(20) comment '岗位',
> `leaderno` int comment '领导工号',
> `birth` date comment '生日',
> `salary` int comment '底薪',
> `extra` int comment '绩效',
> `deptno` int comment '部门编号'
> )engine=innoDB  comment '员工表';
> 
> insert into emp values(7369,'smith','male','clark',7902,'1980-12-17',800,null,20);
> insert into emp values(7499,'allen','female','salesman',7698,'1981-02-20',1600,300,30);
> insert into emp values(7521,'ward','male','salesman',7698,'1981-02-22',1250,500,30);
> insert into emp values(7566,'jones','female','managen',7839,'1981-04-02',2975,null,30);
> insert into emp values(7654,'martin','male','salesman',7698,'1981-09-28',1250,1400,30);
> insert into emp values(7698,'blake','female','manager',7839,'1981-05-01',2850,null,30);
> insert into emp values(7782,'clark','female','manageer',7839,'1980-06-17',2450,null,10);
> insert into emp values(7788,'scott','male','analyst',7566,'1987-02-20',3000,null,20);
> insert into emp values(7839,'king','male','president',null,'1987-02-20',5000,null,10);
> 
> -- a.查询每个部门的平均薪资
> -- select * from emp group by deptno;  -- 显示的是每组中的第一条数据，这样的查询没有意义
> select deptno,avg(salary + ifnull(extra,0)) avg_sal from emp group by deptno;
> 
> -- b.分别查询男员工和女员工的最高收入
> select gender,max(salary + ifnull(extra,0)) max_sal from emp group by gender;
> 
> -- c.查询每个部门的女员工的平均薪资，最终的结果以降序排序
> select deptno,avg(salary + ifnull(extra,0)) from emp  where gender='female' group by deptno order by avg(salary + ifnull(extra,0)) desc;
> -- 简化
> select deptno,avg(salary + ifnull(extra,0)) avg_sal from emp  where gender='female' group by deptno order by avg_sal desc;
> 
> -- d.查询平均薪资大于3000的部门
> -- 求每个部门的平均薪资
> select deptno,avg(salary + ifnull(extra,0)) avg_sal from emp group by deptno;
> -- 分组之前进行条件筛选用where,分组之后进行条件筛选用having   *******
> select deptno,avg(salary + ifnull(extra,0)) avg_sal from emp group by deptno having avg_sal>3000;
> 
> -- e.查询每个部门男员工平均薪资大于4000的部门
> select deptno,avg(salary + ifnull(extra,0)) avg_sal from emp where gender='male' group by deptno having avg_sal>4000;
> 
> -- 注意：
> -- 1.where和having都是用来对数据进行条件筛选的
> -- 2.where是分组之前进行筛选，having是分组之后进行筛选
> -- 3.having后面可以使用聚合运算，但是where不行
> ```

#### 4.分页查询-limit

> limit：用来限定查询结果的起始行，以及总行数
>
> 语法：limit  i,n   ,i表示开始索引，n表示每页查询的记录数
>
> 注：索引从0开始
>
> 公式：开始索引 = （当前页码 - 1） *   每页查询的记录数
>
> ```Python
> select * from emp;
> 
> -- 从头开始，查询2条，注意：索引默认从0开始，且索引可以省略
> select * from emp limit 0,2;
> select * from emp limit 2;
> 
> -- 从索引3开始，查询4条
> select * from emp limit 3,4;
> ```

#### 5.总结

> 书写顺序：select   */字段/聚合函数 ------》   from   表 -----》where 条件----》group by 分组字段  -----》having  分组后的条件【聚合函数】------》order by 排序字段  排序方式 -------》limit  i,n
>
> 执行顺序：from-----》where------》group by-----》having--------》select  ------》order by -----》limit

### DB-Day2作业讲解

> ```mysql
> drop table if exists student;
> drop table if exists score;
> 
> #建学生信息表student
> -- sno
> -- sname 
> -- ssex
> -- sbirthday
> create table `student`(
> `sno` varchar(5) comment '学号',
> `sname` varchar(20) comment '姓名',
> `ssex` varchar(1) comment '性别',
> `sbirth` date comment '生日',
> `class` varchar(5) comment '班级号'
> );
> #建立成绩表score
> -- sno
> -- cno
> -- degree
> create table `score`(
> `sno` varchar(5) comment '学号',
> `cno` varchar(5) comment '课程号',
> `degree` varchar(3) comment '成绩'
> );
> 
> #添加学生信息
> insert into student values('108','曾华','男','1977-09-01','95033');
> insert into student values('105','匡明','男','1975-10-02','95031');
> insert into student values('107','王丽','女','1976-01-23','95033');
> insert into student values('101','李军','男','1976-02-20','95033');
> insert into student values('109','王芳','女','1975-02-10','95031');
> insert into student values('103','陆君','男','1974-06-03','95031');
> #添加成绩表
> insert into score values('103','3-245','86');
> insert into score values('105','3-245','75');
> insert into score values('109','3-245','68');
> insert into score values('103','3-105','92');
> insert into score values('105','3-105','88');
> insert into score values('109','3-105','76');
> insert into score values('103','3-105','64');
> insert into score values('105','3-105','91');
> insert into score values('109','3-105','78');
> insert into score values('103','6-166','85');
> insert into score values('105','6-166','79');
> insert into score values('109','6-166','81');
> 
> #1、 查询student表中的所有记录的sname、ssex和class列
> select sname,ssex,class from student;
> #2、 查询学生所有的学号即不重复的sno列
> select distinct sno from student;
> 
> #3、 查询student表的所有记录
> select * from student;
> #4、查询score表中成绩在60到80之间的所有记录
> select * from score where degree between 60 and 80;
> 
> #5、 查询score表中成绩为85，86或88的记录
> select * from score where degree in (85,86,88);
> 
> #6、 查询student表中“95031”班或性别为“女”的同学记录
> select * from student where class='95031' or ssex='女';
> 
> #7、 以class降序查询Student表的所有记录
> select * from student order by class desc;
> 
> #8、 以cno升序、degree降序查询score表的所有记录
> select * from score order by cno, degree desc;
> 
> #9、 查询“95031”班的学生人数
> select count(*) from student where class='95031';
> 
> #10、查询score表中的最高分的学生学号和课程号
> -- select max(degree) from score;
> -- select sno,cno from score where degree=92;
> -- 整合，子查询
> select sno,cno from score where degree=(select max(degree) from score);
> 
> #11、查询每门课的平均成绩
> select cno,avg(degree) from score group by cno;
> 
> #12、查询score表中至少有5名学生选修的并以3开头的课程的平均分数
> select * from score;
> select * from score where cno like '3%';
> select cno,avg(degree) from score where cno like '3%' group by cno having count(*)>= 5;
> 
> 
> #13、查询分数大于70，小于90的sno列
> select sno from score where degree>70 and degree<90;
> ```