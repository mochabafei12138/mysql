-- 1.ifnull()
select ename,salary + ifnull(extra,0) total_sal from emp;

-- 2.if
-- a.只有两种情况：实现二选一的操作
select ename,if(salary + ifnull(extra,0)>=3000,'继续保持','再接再厉') 备注 from emp;

-- b.右多种情况：实现多选一的操作
-- 实现思路：借助于if的嵌套
/*
>= 5k   优秀
3k~5k   良好
2k~3k   再接再励
2k以下	奔跑起来吧
*/
select
	ename,
    salary + ifnull(extra,0) total_sal,
    if(salary + ifnull(extra,0)>=5000,'优秀',
    if(salary + ifnull(extra,0)>=3000,'良好',
    if(salary + ifnull(extra,0)>= 2000,'再接再励','奔跑起来吧'))) 备注
from
	emp;
    
-- 3.case
-- a
select
	ename,
    deptno,
    case deptno
		when 10 then '人事部'
        when 20 then '财务部'
        when 30 then '运营部'
        else '其他部门'
	end '部门名称'
from 
	emp;
    
-- b
select
	ename,
    deptno,
    case 
		when deptno=10 then '人事部'
        when deptno=20 then '财务部'
        when deptno=30 then '运营部'
        else '其他部门'
	end '部门名称'
from 
	emp;
    
-- 练习
-- a
/*
>= 5k   优秀
3k~5k   良好
2k~3k   再接再励
2k以下	奔跑起来吧
*/
select
	ename,
    salary + ifnull(extra,0) total_sal,
    case 
		when salary + ifnull(extra,0)>=5000  then  '优秀'
        when salary + ifnull(extra,0)>=3000  then  '良好'
        when salary + ifnull(extra,0)>=2000  then  '再接再厉'
        else '奔跑起来吧'
	end '备注'
from
	emp;
    
-- b
select 
	ename,
    case 
		when month(birth) between 1 and 3 then '第一季度'
        when month(birth) between 4 and 6 then '第二季度'
        when month(birth) between 7 and 9 then '第三季度'
        when month(birth) between 10 and 12 then '第四季度'
        else '日期有误'
	end '出生季度'
from
	emp;