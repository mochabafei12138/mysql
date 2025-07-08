-- 1.查询和blake在同一个部门的员工信息
-- 子查询
select * from emp where deptno=(select deptno from emp where ename='blake') and ename!='blake';
-- 自连接
-- e1:参照表   e2:目标表
select 
	e2.*     -- 查询e2表中的所有字段
from 
	emp e1 
join 
	emp e2 
on 
	e1.ename='blake' and e2.deptno=e1.deptno and e2.ename!='blake';
    
-- 2.查询工资高于jones的员工信息
-- 子查询
select * from emp where salary+ifnull(extra,0)>(select salary+ifnull(extra,0) from emp where ename='jones');
-- 自连接
-- e1:参照表   e2:目标表
select 
	e2.*
from
	emp e1
join 
	emp e2
on
	e1.ename='jones' and e2.salary+ifnull(e2.extra,0)>e1.salary+ifnull(e1.extra,0);
