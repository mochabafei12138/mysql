create table `emp`(
`empno` int comment '工号',
`ename` varchar(20) comment '姓名',
`gender` varchar(10) comment '性别',
`job` varchar(20) comment '岗位',
`leaderno` int comment '领导工号',
`birth` date comment '生日',
`salary` int comment '底薪',
`extra` int comment '绩效',
`deptno` int comment '部门编号'
)engine=innoDB  comment '员工表';

insert into emp values(7369,'smith','male','clark',7902,'1980-12-17',800,null,20);
insert into emp values(7499,'allen','female','salesman',7698,'1981-02-20',1600,300,30);
insert into emp values(7521,'ward','male','salesman',7698,'1981-02-22',1250,500,30);
insert into emp values(7566,'jones','female','managen',7839,'1981-04-02',2975,null,30);
insert into emp values(7654,'martin','male','salesman',7698,'1981-09-28',1250,1400,30);
insert into emp values(7698,'blake','female','manager',7839,'1981-05-01',2850,null,30);
insert into emp values(7782,'clark','female','manageer',7839,'1980-06-17',2450,null,10);
insert into emp values(7788,'scott','male','analyst',7566,'1987-02-20',3000,null,20);
insert into emp values(7839,'king','male','president',null,'1987-02-20',5000,null,10);

-- a.查询每个部门的平均薪资
-- select * from emp group by deptno;  -- 显示的是每组中的第一条数据，这样的查询没有意义
select deptno,avg(salary + ifnull(extra,0)) avg_sal from emp group by deptno;

-- b.分别查询男员工和女员工的最高收入
select gender,max(salary + ifnull(extra,0)) max_sal from emp group by gender;

-- c.查询每个部门的女员工的平均薪资，最终的结果以降序排序
select deptno,avg(salary + ifnull(extra,0)) from emp  where gender='female' group by deptno order by avg(salary + ifnull(extra,0)) desc;
-- 简化
select deptno,avg(salary + ifnull(extra,0)) avg_sal from emp  where gender='female' group by deptno order by avg_sal desc;

-- d.查询平均薪资大于3000的部门
-- 求每个部门的平均薪资
select deptno,avg(salary + ifnull(extra,0)) avg_sal from emp group by deptno;
-- 分组之前进行条件筛选用where,分组之后进行条件筛选用having   *******
select deptno,avg(salary + ifnull(extra,0)) avg_sal from emp group by deptno having avg_sal>3000;

-- e.查询每个部门男员工平均薪资大于4000的部门
select deptno,avg(salary + ifnull(extra,0)) avg_sal from emp where gender='male' group by deptno having avg_sal>4000;

-- 注意：
-- 1.where和having都是用来对数据进行条件筛选的
-- 2.where是分组之前进行筛选，having是分组之后进行筛选
-- 3.having后面可以使用聚合运算，但是where不行

