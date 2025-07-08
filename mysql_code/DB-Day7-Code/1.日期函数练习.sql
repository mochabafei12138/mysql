use mydb1;

-- 日期函数结合表的应用
select * from emp;

-- 1.计算员工的年龄
-- floor():向下取整  ceil():向上取整
select floor(datediff(now(),birth) / 365) 年龄 from emp; -- 周岁
select ceil(datediff(now(),birth) / 365) 年龄 from emp; -- 虚岁

select timestampdiff(year,birth,now()) 年龄  from emp;

-- 2.查询本周过生日的员工信息
-- 查询星期
select dayofweek(curdate());   -- 星期四-----》5
-- 查询当前日期对应周的星期一
-- 解释：比如当前日期是4.18 ，在当前日期的基础上减少3天，就是4.15
--       比如当前日期是4.19 ，在当前日期的基础上减少4天，就是4.15
select date_sub(curdate(),interval dayofweek(curdate()) - 2  day);

-- 查询当前日期对应周的星期日
-- 方式一:date_sub(interval 负数)
select date_sub(curdate(),interval -(8 - dayofweek(curdate()))  day);
-- 方式二：date_add(interval 正数)
select date_add(curdate(),interval 8 - dayofweek(curdate())  day);

-- 整合
-- 错误：Unknown column 'm_birth'
-- 错误原因：注意mysql中关键字的执行顺序,from----》where-----》select
select 
	ename,
    date_format(birth,'%m-%d') m_birth,
    date_format(date_sub(curdate(),interval dayofweek(curdate()) - 2  day),'%m-%d') week1,
    date_format(date_add(curdate(),interval 8 - dayofweek(curdate())  day),'%m-%d') week7
from 
	emp
where
	m_birth>=week1 and m_birth<=week7;
    
-- 解决方案：子查询
-- 注意：如果select返回多行多列，则可以当成一张表进行二次查询，但是该表一定要起别名
-- a
select
	ename,
    m_birth
from 
	(
    select 
		ename,
		date_format(birth,'%m-%d') m_birth,
		date_format(date_sub(curdate(),interval dayofweek(curdate()) - 2  day),'%m-%d') week1,
		date_format(date_add(curdate(),interval 8 - dayofweek(curdate())  day),'%m-%d') week7
	from 
		emp
    ) emp_birth
where
	m_birth>=week1 and m_birth<=week7;
    
-- b
select
	*
from 
	(
    select 
		*,
		date_format(birth,'%m-%d') m_birth,
		date_format(date_sub(curdate(),interval dayofweek(curdate()) - 2  day),'%m-%d') week1,
		date_format(date_add(curdate(),interval 8 - dayofweek(curdate())  day),'%m-%d') week7
	from 
		emp
    ) emp_birth
where
	m_birth between week1 and week7;
    
-- 3.查询本月过生日的员工信息
select * from emp where month(curdate())=month(birth);
select * from emp where date_format(curdate(),'%m')=date_format(birth,'%m');
    
    
