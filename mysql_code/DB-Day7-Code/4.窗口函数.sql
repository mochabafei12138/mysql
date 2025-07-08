-- 1
select 
	deptno,
    max(salary),
    min(salary),
    sum(salary),
    avg(salary),
    count(*)
from
	emp
group by
	deptno;
    
insert into emp values(7230,'aaa','female','managen',7839,'1981-04-02',1200,null,30);
insert into emp values(7561,'bbb','female','managen',7839,'1981-04-02',1250,null,30);
insert into emp values(7710,'ccc','female','managen',7839,'1981-04-02',1000,null,30);
    
-- 2.
-- 对每个部门内员工的薪资进行降序排序
/*
partition by <用于分组的表达式>
order by <用于排序的表达式>
*/
-- rank():1 2 3 4 4 6...
select 
	ename,salary,deptno,
    rank() over(
		partition by deptno    -- 使用deptno分组
        order by salary desc   -- 在分组之后的每组内进行降序排序
    ) sal_rank
from
	emp;
    
-- dense_rank():1 2 3 4 4 5...
select 
	ename,salary,deptno,
    dense_rank() over(
		partition by deptno   
        order by salary desc   
    ) sal_rank
from
	emp;
    
-- row_number(): 1 2 3 4 5 6....
select 
	ename,salary,deptno,
    row_number() over(
		partition by deptno   
        order by salary desc   
    ) sal_rank
from
	emp;

-- 练习：获取每个部门中最高薪资对应的员工信息
select 
	*,
    row_number() over(
	partition by deptno
    order by salary desc
	) sal_rank
from
	emp;
    
select 
	*
from
	(
    select 
		*,
		row_number() over(
		partition by deptno
		order by salary desc
		) sal_rank
	from
		emp
    ) new_emp
where
	sal_rank=1;
    
-- 3.窗口函数和聚合函数结合使用，此时只会用到分组
-- 需求：获取每个部门中平均薪资以下的员工信息
select 
	*,
    avg(salary) over(
		partition by deptno
    ) avg_sal
from 
	emp;
    
select
	*
from 
	(select 
		*,
		avg(salary) over(
			partition by deptno
		) avg_sal
	from 
		emp
    ) new_emp
where 
	salary<avg_sal;



