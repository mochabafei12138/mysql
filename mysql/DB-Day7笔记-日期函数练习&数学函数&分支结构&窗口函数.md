### 一、常用函数【重点掌握】

#### 1.日期函数练习

> ```mysql
> use mydb1;
> 
> -- 日期函数结合表的应用
> select * from emp;
> 
> -- 1.计算员工的年龄
> -- floor():向下取整  ceil():向上取整
> select floor(datediff(now(),birth) / 365) 年龄 from emp; -- 周岁
> select ceil(datediff(now(),birth) / 365) 年龄 from emp; -- 虚岁
> 
> select timestampdiff(year,birth,now()) 年龄  from emp;
> 
> -- 2.查询本周过生日的员工信息
> -- 查询星期
> select dayofweek(curdate());   -- 星期四-----》5
> -- 查询当前日期对应周的星期一
> -- 解释：比如当前日期是4.18 ，在当前日期的基础上减少3天，就是4.15
> --       比如当前日期是4.19 ，在当前日期的基础上减少4天，就是4.15
> select date_sub(curdate(),interval dayofweek(curdate()) - 2  day);
> 
> -- 查询当前日期对应周的星期日
> -- 方式一:date_sub(interval 负数)
> select date_sub(curdate(),interval -(8 - dayofweek(curdate()))  day);
> -- 方式二：date_add(interval 正数)
> select date_add(curdate(),interval 8 - dayofweek(curdate())  day);
> 
> -- 整合
> -- 错误：Unknown column 'm_birth'
> -- 错误原因：注意mysql中关键字的执行顺序,from----》where-----》select
> select 
> 	ename,
>     date_format(birth,'%m-%d') m_birth,
>     date_format(date_sub(curdate(),interval dayofweek(curdate()) - 2  day),'%m-%d') week1,
>     date_format(date_add(curdate(),interval 8 - dayofweek(curdate())  day),'%m-%d') week7
> from 
> 	emp
> where
> 	m_birth>=week1 and m_birth<=week7;
>     
> -- 解决方案：子查询
> -- 注意：如果select返回多行多列，则可以当成一张表进行二次查询，但是该表一定要起别名
> -- a
> select
> 	ename,
>     m_birth
> from 
> 	(
>     select 
> 		ename,
> 		date_format(birth,'%m-%d') m_birth,
> 		date_format(date_sub(curdate(),interval dayofweek(curdate()) - 2  day),'%m-%d') week1,
> 		date_format(date_add(curdate(),interval 8 - dayofweek(curdate())  day),'%m-%d') week7
> 	from 
> 		emp
>     ) emp_birth
> where
> 	m_birth>=week1 and m_birth<=week7;
>     
> -- b
> select
> 	*
> from 
> 	(
>     select 
> 		*,
> 		date_format(birth,'%m-%d') m_birth,
> 		date_format(date_sub(curdate(),interval dayofweek(curdate()) - 2  day),'%m-%d') week1,
> 		date_format(date_add(curdate(),interval 8 - dayofweek(curdate())  day),'%m-%d') week7
> 	from 
> 		emp
>     ) emp_birth
> where
> 	m_birth between week1 and week7;
>     
> -- 3.查询本月过生日的员工信息
> select * from emp where month(curdate())=month(birth);
> select * from emp where date_format(curdate(),'%m')=date_format(birth,'%m');
>     
> ```

#### 2.数学函数

> ```python
> round(n, 小数位长)  四舍五入
> ceil(n) 上行取整，比n大的，最小的整数
> floor() 下行取整，比n小的，最大的整数
> pow(n, c) 计算n的c次方   
> mod(n1, n2) 计算两者的余数
> rand() 随机产生[0,1)之间数，如 ceil(rand()*15) + 1,生成[1,16]之间的数
> abs()  求绝对值
> sin()/asin()/cos()/acos()/tan()/atan()/con() 数学相关的三角函数
> ```

> ```mysql
> -- 一、基本使用
> select abs(-30);
> select ceil(18.11),ceil(18.99);
> select floor(18.11),floor(18.99);
> 
> select PI();
> 
> select rand(); -- 获取0~1之间的随机数
> select rand() * 80 + 20; -- 获取20~100之间的随机数
> 
> select pow(5,3);
> 
> -- 二、结合表使用
> select ename,birth,floor(datediff(now(),birth) / 365) 年龄 from emp; -- 周岁
> select ename,birth,ceil(datediff(now(),birth) / 365) 年龄 from emp; -- 虚岁
> select ename,birth,year(now()) - year(birth) 年龄 from emp;
> 
> ```

#### 3.分支结构

> ```Python
> if判断
> 		ifnull(字段名, 替换值)
> 			--- 判断这个字段名对应的值是否有空值  有的话就设置为替换值 没有的话使用原值
> 		if(条件判断, 表达式1, 表达式2)
> 			条件判断成立 执行表达式1 否则执行表达式2
> case判断
> 		case 表达式
> 		when 值1 then 表达式1
> 		when 值2 then 表达式2
> 		...
> 		else 表达式n+1
> 		end 显示名称
> 		
> 		解读：
> 			获取表达式的值， 如果这个值是值1的话  就执行表达式1..
> 			如果列出的所有的值都不成立 执行else后面的表达式
> 	
> 		case 
> 		when 条件1 then 表达式1
> 		when 条件2 then 表达式2
> 		...
> 		else 表达式n+1
> 		end 显示名称
> ```

> ```mysql
> -- 1.ifnull()
> select ename,salary + ifnull(extra,0) total_sal from emp;
> 
> -- 2.if
> -- a.只有两种情况：实现二选一的操作
> select ename,if(salary + ifnull(extra,0)>=3000,'继续保持','再接再厉') 备注 from emp;
> 
> -- b.右多种情况：实现多选一的操作
> -- 实现思路：借助于if的嵌套
> /*
> >= 5k   优秀
> 3k~5k   良好
> 2k~3k   再接再励
> 2k以下	奔跑起来吧
> */
> select
> 	ename,
>     salary + ifnull(extra,0) total_sal,
>     if(salary + ifnull(extra,0)>=5000,'优秀',
>     if(salary + ifnull(extra,0)>=3000,'良好',
>     if(salary + ifnull(extra,0)>= 2000,'再接再励','奔跑起来吧'))) 备注
> from
> 	emp;
>     
> -- 3.case
> -- a
> select
> 	ename,
>     deptno,
>     case deptno
> 		when 10 then '人事部'
>         when 20 then '财务部'
>         when 30 then '运营部'
>         else '其他部门'
> 	end '部门名称'
> from 
> 	emp;
>     
> -- b
> select
> 	ename,
>     deptno,
>     case 
> 		when deptno=10 then '人事部'
>         when deptno=20 then '财务部'
>         when deptno=30 then '运营部'
>         else '其他部门'
> 	end '部门名称'
> from 
> 	emp;
>     
> -- 练习
> -- a
> /*
> >= 5k   优秀
> 3k~5k   良好
> 2k~3k   再接再励
> 2k以下	奔跑起来吧
> */
> select
> 	ename,
>     salary + ifnull(extra,0) total_sal,
>     case 
> 		when salary + ifnull(extra,0)>=5000  then  '优秀'
>         when salary + ifnull(extra,0)>=3000  then  '良好'
>         when salary + ifnull(extra,0)>=2000  then  '再接再厉'
>         else '奔跑起来吧'
> 	end '备注'
> from
> 	emp;
>     
> -- b
> select 
> 	ename,
>     case 
> 		when month(birth) between 1 and 3 then '第一季度'
>         when month(birth) between 4 and 6 then '第二季度'
>         when month(birth) between 7 and 9 then '第三季度'
>         when month(birth) between 10 and 12 then '第四季度'
>         else '日期有误'
> 	end '出生季度'
> from
> 	emp;
> ```

### 二、窗口函数【重点掌握】

> 注意：窗口函数是mysql8.0之后新增的一个函数
>
> 窗口函数和聚合函数的区别：
>
> ​	a.聚合函数是将多条记录聚合为一条，而窗口函数是每条记录都会执行，有几条数据执行完还是几条
>
> ​	b.聚合函数也可以和窗口函数结合使用
>
> ```
> 窗口函数是针对于数据自己进行计算创建出来的新的一列
> select 字段...， 窗口函数 over(
> 		partition by <用于分组的表达式>
> 		order by <用于排序的表达式>
> ) as 别名 from 表名
> 	
> 	over -- 表示窗口函数开始的位置，使用聚合的结果作为一列添加到结果集中
> 	partition by 根据表达式对数据进行分组，聚合结果被执行
> 	order by 根据对应的表达式对数据进行排序
> 	
> 	窗口函数可以使用聚合函数和专门的窗口函数
> 	专门的窗口函数：
> 		rank, dense_rank,row_number 这些都是用于排名的函数
> 	
> 	注意：计算一下每个人在当前班级中的成绩排名
> 	rank  --- 有并列排名的情况，会占用下一个名次。比如：1,1,3...   1,2,2,4...
> 	dense_rank --- 有并列排名的情况，不会占用下一个名次,如：1,1,2,3....   1,2,2,3,4...
> 	row_number --- 没有并列的情况,如：1,2,3,4.....
> ```

> ```mysql
> -- 1
> select 
> 	deptno,
>     max(salary),
>     min(salary),
>     sum(salary),
>     avg(salary),
>     count(*)
> from
> 	emp
> group by
> 	deptno;
>     
> insert into emp values(7230,'aaa','female','managen',7839,'1981-04-02',1200,null,30);
> insert into emp values(7561,'bbb','female','managen',7839,'1981-04-02',1250,null,30);
> insert into emp values(7710,'ccc','female','managen',7839,'1981-04-02',1000,null,30);
>     
> -- 2.
> -- 对每个部门内员工的薪资进行降序排序
> /*
> partition by <用于分组的表达式>
> order by <用于排序的表达式>
> */
> -- rank():1 2 3 4 4 6...
> select 
> 	ename,salary,deptno,
>     rank() over(
> 		partition by deptno    -- 使用deptno分组
>         order by salary desc   -- 在分组之后的每组内进行降序排序
>     ) sal_rank
> from
> 	emp;
>     
> -- dense_rank():1 2 3 4 4 5...
> select 
> 	ename,salary,deptno,
>     dense_rank() over(
> 		partition by deptno   
>         order by salary desc   
>     ) sal_rank
> from
> 	emp;
>     
> -- row_number(): 1 2 3 4 5 6....
> select 
> 	ename,salary,deptno,
>     row_number() over(
> 		partition by deptno   
>         order by salary desc   
>     ) sal_rank
> from
> 	emp;
> 
> -- 练习：获取每个部门中最高薪资对应的员工信息
> select 
> 	*,
>     row_number() over(
> 	partition by deptno
>     order by salary desc
> 	) sal_rank
> from
> 	emp;
>     
> select 
> 	*
> from
> 	(
>     select 
> 		*,
> 		row_number() over(
> 		partition by deptno
> 		order by salary desc
> 		) sal_rank
> 	from
> 		emp
>     ) new_emp
> where
> 	sal_rank=1;
>     
> -- 3.窗口函数和聚合函数结合使用，此时只会用到分组
> -- 需求：获取每个部门中平均薪资以下的员工信息
> select 
> 	*,
>     avg(salary) over(
> 		partition by deptno
>     ) avg_sal
> from 
> 	emp;
>     
> select
> 	*
> from 
> 	(select 
> 		*,
> 		avg(salary) over(
> 			partition by deptno
> 		) avg_sal
> 	from 
> 		emp
>     ) new_emp
> where 
> 	salary<avg_sal;
> ```