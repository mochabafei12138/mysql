use mydb1;

select * from emp;

-- 1.查询和blake在同一个部门的员工信息
-- a.查询blake所在的部门
select deptno from emp where ename='blake';
-- b.查询30号部门的员工信息
select * from emp where deptno=30;
-- c.整合
select * from emp where deptno=(select deptno from emp where ename='blake') and ename!='blake';

-- 2.查询工资高于jones的员工信息
-- a.查询jones的薪资
select salary+ifnull(extra,0) from emp where ename='jones';
-- b.查询薪资高于2975的员工信息
select * from emp where salary+ifnull(extra,0)>2975;
-- c.整合
select * from emp where salary+ifnull(extra,0)>(select salary+ifnull(extra,0) from emp where ename='jones');

-- 3.查询工资高于30号部门所有员工的员工信息
-- a.查询30号部门的最高薪资
select max(salary+ifnull(extra,0)) from emp where deptno=30;
-- b.查询薪资高于2975的员工信息
select * from emp where salary+ifnull(extra,0)>2975;
-- c.整合
select * from emp where salary+ifnull(extra,0)>(select max(salary+ifnull(extra,0)) from emp where deptno=30);

-- 4.查询工作和工资与martin完全相同的员工信息
select job from emp where ename='martin';
select salary+ifnull(extra,0) from emp where ename='martin';
select * from emp where job='salesman' and salary+ifnull(extra,0)=2650;
-- 整合
select 
	* 
from 
	emp 
where 
	job=(select job from emp where ename='martin') 
and 
	salary+ifnull(extra,0)=(select salary+ifnull(extra,0) from emp where ename='martin')
and
	ename!='martin';

-- 5.查询各个部门工资最高的员工信息
-- 方式一:不严谨
-- a.查询各个部门的最高薪资
select max(salary) from emp group by deptno;
-- b.查询工资为3000，2975，5000的员工信息
select * from emp where salary in (3000,2975,5000);
-- c.整合
select * from emp where salary in (select max(salary) from emp group by deptno);

-- 问题：10号部门有员工的薪资和30号部门的最高薪资相同
insert into emp values(7219,'aaa','female','salesman',7698,'1981-02-20',2975,300,10);

-- 方式二：严谨写法
-- a.根据deptno分组，得到deptno和对应的最高薪资,得到一张临时表
create table new_emp (select deptno,max(salary) max_sal from emp group by deptno);
select * from new_emp;
-- b.将emp和new_emp进行连接查询
select * from new_emp left join emp on new_emp.deptno=emp.deptno and new_emp.max_sal=emp.salary; -- 左外连接
select * from emp right join new_emp on new_emp.deptno=emp.deptno and new_emp.max_sal=emp.salary; -- 右外连接
select * from new_emp join emp on new_emp.deptno=emp.deptno and new_emp.max_sal=emp.salary;  -- 内连接

-- c.整合
select 
	* 
from 
	(select deptno,max(salary) max_sal from emp group by deptno) new_emp
left join 
	emp 
on 
	new_emp.deptno=emp.deptno 
and 
	new_emp.max_sal=emp.salary;

-- 6.查询10号部门中工资高于20号部门中任意一人的信息
-- any(select ...)
-- a.查询20号部门的所有的员工薪资
select salary from emp where deptno=20;
-- b.查询薪资高于(800,3000)中任意一个的信息
select * from emp where deptno=10 and salary>any(select salary from emp where deptno=20);

-- 7.查询10号部门中工资高于20号部门中所有人的信息
-- all(select...)
select * from emp where deptno=10 and salary>all(select salary from emp where deptno=20);