use mydb1;

-- 1.创建一个临时表
-- a.create table xxx (select ....)
create table temp_table (select * from emp where deptno=30);
select * from temp_table;

-- b.子查询
select * from (select * from emp where deptno=30) new_emp;

-- c.with公共表达式
/*
作用：定义一个临时的结果集，然后将其用作查询的一部分
语法：
	with temp_table as(
		-- 在此处定义临时表达式
        select ......
        from  old_table
        where condotion
    )
    -- 使用创建的临时表达式
    select * from temp_table;
    
语法解释：
	temp_table：给临时表达式命名的标识符
    as的关键字之后，可以编写一个普通的select语法来临时定义表达式
    一旦定义了临时表达式，则可以在后面的查询中引用它
    
通过使用with语句，可以清晰的组织复杂的sql,并使得sql语句可读性更高，后期的可维护性提高
*/
with dept_30 as (
	select * from emp where deptno=30
) 
select * from dept_30;

with table1 as(
	select empno,ename,birth,salary,deptno from emp where birth between '1980-01-01' and '1982-12-30'
)
select deptno,avg(salary) from table1 group by deptno;


