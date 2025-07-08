create database emp_dept_grade_db;
use emp_dept_grade_db;

-- 一、建表
/*
部门表:dept
	部门编号(主键):dno
	部门名称(不能为空):dname
	部门地址(不能为空):daddr
*/
create table  `dept`(
`dno` int primary key comment '部门编号',
 `dname` varchar(10) not null comment '部门名称',
 `daddr` varchar(10) not null comment '部门地址'
)comment '部门表';

/*
员工表:emp
	员工编号(主键):eno
	员工名称(不能为空):ename
	员工岗位:ejob
	所属领导编号 【外键】 :managerid
	入职日期:hiredate
	薪水:salary
	提成:comm
	部门编号【外键】:dno
*/
create table `emp`(
 `eno` int primary key comment '工号',
 `ename` varchar(30) not null comment '员工姓名',
 `ejob` varchar(20) comment '工作',
 `managerid` int comment '领导编号',
 `hiredate` date comment '入职日期',
 `salary` int comment '薪资',
 `comm` int comment '奖金',
 `dno` int comment '部门编号',
 constraint fk_dno foreign key(dno) references dept(dno),     -- 和dept表进行关联
 constraint fk_manager foreign key(managerid) references emp(eno) -- 领导本质也是员工，和自身关联
)comment '员工表';
desc dept;
desc emp;

-- 二、添加数据
insert into dept values 
(10,'财务部','北京'),
(20,'研发部','上海'),
(30,'销售部','广州'),
(40,'行政部','深圳');


-- 添加员工数据
insert into emp values 
(7839,'吴九','总裁',7839,'1981-11-17',5000,0,10),
(7566,'李四','经理',7839,'1981-04-02',2975,0,20),
(7698,'赵六','经理',7839,'1981-05-01',2850,0,30),
(7782,'孙七','经理',7839,'1981-06-09',2450,0,10),
(7902,'大锦鲤','分析师',7566,'1981-12-03',3000,0,20),
(7788,'周八','分析师',7566,'1987-06-13',3000,0,20),
(7654,'王五','推销员',7698,'1981-09-28',1250,1400,30),
(7369,'刘一','职员',7902,'1980-12-17',800,0,20),
(7499,'陈二','推销员',7698,'1981-02-20',1600,300,30),
(7521,'张三','推销员',7698,'1981-02-22',1250,500,30),
(7844,'郑十','推销员',7698,'1981-09-08',1500,0,30),
(7876,'郭十一','职员',7788,'1987-06-13',1100,0,20),
(7900,'钱多多','职员',7698,'1981-12-03',950,0,30),
(7934,'木有钱','职员',7782,'1983-01-23',1300,0,10);
select * from emp;

-- 三、查询数据
-- 1.列出至少有一个员工的所有部门。
select dno,count(*) from emp group by dno having count(*)>=1;

-- 2.列出薪金比"刘一"多的所有员工。
select * from emp where (salary+comm)>(select salary+comm from emp where ename='刘一');

-- 3.列出所有员工的姓名及其直接上级的姓名。
/*
员工表：emp
领导表：emp
因为只有一一张表，所以进行自连接
联系条件：普通员工的领导编号=领导的自身编号
*/
select emp.ename 员工姓名,manager.ename 领导姓名 from emp join emp as manager on emp.managerid=manager.eno;

-- 4.列出薪资高于其直接上级的所有员工。
select 
	emp.ename 员工姓名,emp.salary 员工薪资,manager.ename 领导姓名,manager.salary 领导薪资 
from emp 
join emp as manager 
on emp.managerid=manager.eno
where emp.salary>manager.salary;

-- 5.列出部门名称和这些部门的员工信息，同时列出那些没有员工的部门。
select dname,emp.* from dept left join emp on dept.dno=emp.dno;

-- 6.列出所有job为“职员”的姓名。
select ename,ejob from emp where ejob='职员';

-- 7.列出最低薪金大于1500的各种工作。
select ejob from emp group by ejob having min(salary)>1500;

-- 8.列出在部门 "销售部" 工作的员工的姓名，假定不知道销售部的部门编号。
-- 方式一
select ename from emp where dno=(select dno from dept where dname='销售部');
-- 方式二
select ename from emp left join dept on emp.dno=dept.dno where dept.dname='销售部';

-- 9.列出薪金高于公司平均薪金的所有员工。
select * from emp where salary>(select avg(salary) from emp);

-- 10.列出与"周八"从事相同工作的所有员工。
select * from emp where ejob=(select ejob from emp where ename='周八') and ename!='周八';

-- 11.列出薪金等于部门30中员工的薪金的所有员工的姓名和薪金。
select ename,salary from emp where salary in (select salary from emp where dno=30) and dno!=30;
select ename,salary from emp where salary=any(select salary from emp where dno=30) and dno!=30;

-- 12.列出薪金高于在部门30工作的所有员工的薪金的员工姓名和薪金。
select ename,salary from emp where salary>(select max(salary) from emp where dno=30) and dno!=30;
select ename,salary from emp where salary>all(select salary from emp where dno=30) and dno!=30;

-- 13.列出在每个部门工作的员工数量、平均工资。
select count(*),avg(salary) from emp group by dno;

-- 14.列出所有员工的姓名、部门名称和工资。
select ename,dname,salary from emp left join dept on emp.dno=dept.dno;

-- 15.列出所有部门的详细信息和部门人数。
select dept.*,count(if(eno is null,null,eno)) from emp right join dept on emp.dno=dept.dno group by emp.dno;

-- 16.列出各种工作的最低工资。
select ejob,min(salary) from emp group by ejob;

-- 17.列出各个部门的 经理 的最低薪金。
select dno,min(salary) from emp where ejob='经理' group by dno;

-- 18.查出emp表中薪水在3000以上（包括3000）的所有员工的员工号、姓名、薪水。
select eno,ename,salary from emp where salary>=3000;

-- 19.查询出所有薪水在'陈二'之上的所有人员信息。
select * from emp where salary>(select salary from emp where ename='陈二');

-- 20.查询出emp表中部门编号为20，薪水在2000以上（不包括2000）的所有员工，
select * from emp where dno=20 and salary>2000;

-- 21.查询出所有奖金（comm）字段不为空的人员的所有信息。
select * from emp where comm is not null;

-- 22.查询出薪水在800到2500之间（闭区间）所有员工的信息。
select * from emp where salary between 800 and 2500;

-- 23.查询出员工号为7521，7900，7782的所有员工的信息
select * from emp where eno in (7521,7900,7782);

-- 24.查询出名字中有“张”字符，并且薪水在1000以上（不包括1000）的所有员工信息
select * from emp where ename like '%张%' and salary>1000;

-- 25.查询出名字第三个汉字是“多”的所有员工信息
select * from emp where ename like '__多';

-- 26.查询出最早工作的那个人的名字、入职时间和薪水。
select ename,hiredate,salary from emp where hiredate=(select min(hiredate) from emp);

-- 27.显示出薪水最高人的职位。
select ejob from emp where salary=(select max(salary) from emp);

-- 28.获取每个部门中最高薪资对应的员工信息
select 
	emp.*
from 
	(select dno,max(salary) max_sal from emp group by dno) max_sal_t
left join emp
on emp.dno=max_sal_t.dno and emp.salary=max_sal_t.max_sal;

-- 29.获取每个部门中在部门平均薪资以下的员工的信息
-- 方式一：子查询
select 
	emp.*,avg_sal
from 
	(select dno,avg(salary) avg_sal from emp group by dno) avg_sal_t
left join emp
on emp.dno=avg_sal_t.dno and emp.salary<avg_sal_t.avg_sal;

-- 方式二：with连接查询
with dept_avg as (select dno,avg(salary) avg_sal from emp group by dno)
select emp.*,avg_sal from emp join dept_avg on emp.dno=dept_avg.dno 
where salary<avg_sal;

-- 方式三：窗口函数
with avgs_t as (select *,avg(salary) over(partition by dno) avg_sal from emp)
select * from avgs_t where salary<avg_sal;

-- 扩展
-- 30.找出姓名以a,b,s开头的员工信息
-- 方式一
select * from emp where ename like 'a%' or ename like 'b%' or ename like 's%';
-- 方式二
select * from emp where left(ename,1) in ('a','b','s');
-- 方式三：正则【自学】
select * from emp where ename regexp '^[abs]';

-- 31.获取每个部门中薪资排名前两名的员工信息
-- 方式一：子查询
select * from (select *,row_number() over(partition by dno order by salary desc) sal_rank from emp) new_emp
where sal_rank<=2;
-- 方式二：with
with tb_rank as (select *,row_number() over(partition by dno order by salary desc) sal_rank from emp)
select * from tb_rank where sal_rank<=2;

-- 32.返回工资为二级的员工姓名，部门的所在地
create table `salgrade`(
`grade` int comment '等级',
`minsal` double comment '最低薪资',
`maxsal` double comment '最高薪资'
) comment '薪资等级表';
insert into salgrade value(1,500,1200);
insert into salgrade value(2,1201,1400);
insert into salgrade value(3,1401,2000);
insert into salgrade value(4,2001,3000);
insert into salgrade value(5,3001,10000);

-- 三张表进行连接，a join b join c join .....
select emp.*,dname,daddr,salgrade.* from emp join dept join salgrade on emp.dno=dept.dno and salary between minsal and maxsal where grade=2;

