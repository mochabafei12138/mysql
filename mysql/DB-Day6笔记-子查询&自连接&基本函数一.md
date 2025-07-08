### 一、子查询和自连接

#### 1.子查询【重点掌握】

> 一个select语句中包含另一个完整的select语句【select语句嵌套】
>
> 子查询就是嵌套查询，即select中包含select，如果一条sql语句中存在两个或者两个以上select，那么就是子查询语句了
>
> ​	1>子查询出现的位置：					
>
> ​		a.where后，作为条件的一部分被查询
>
> ​		b.from后，作为表
>
> ​	2>当子查询出现在where后作为条件时，还可以使用关键字
>
> ​		a.any:任意一个
>
> ​		b.all：所有
>
> ​	3>子查询结果集的形式
>
> ​		a.单行单列（用于条件）,一般使用=，>,>=  < <=等
>
> ​		b.单行多列（用于条件），any ,all,in ,not in等
>
> ​		c.多行单列（用于条件），any ,all,in ,not in等
>
> ​		d.多行多列（用于表），from的后面
>
> ```mysql
> --emp
> -- 1.查询和blake在同一个部门的员工信息
> -- 2.查询工资高于jones的员工信息
> -- 3.查询工资高于30号部门所有员工的员工信息
> -- 4.查询工作和工资与martin完全相同的员工信息
> -- 5.查询各个部门工资最高的员工信息
> -- 6.查询10号部门中工资高于20号部门中任意一人的信息
> -- 7.查询10号部门中工资高于20号部门中所有人的信息
> ```

> ```mysql
> use mydb1;
> 
> select * from emp;
> 
> -- 1.查询和blake在同一个部门的员工信息
> -- a.查询blake所在的部门
> select deptno from emp where ename='blake';
> -- b.查询30号部门的员工信息
> select * from emp where deptno=30;
> -- c.整合
> select * from emp where deptno=(select deptno from emp where ename='blake') and ename!='blake';
> 
> -- 2.查询工资高于jones的员工信息
> -- a.查询jones的薪资
> select salary+ifnull(extra,0) from emp where ename='jones';
> -- b.查询薪资高于2975的员工信息
> select * from emp where salary+ifnull(extra,0)>2975;
> -- c.整合
> select * from emp where salary+ifnull(extra,0)>(select salary+ifnull(extra,0) from emp where ename='jones');
> 
> -- 3.查询工资高于30号部门所有员工的员工信息
> -- a.查询30号部门的最高薪资
> select max(salary+ifnull(extra,0)) from emp where deptno=30;
> -- b.查询薪资高于2975的员工信息
> select * from emp where salary+ifnull(extra,0)>2975;
> -- c.整合
> select * from emp where salary+ifnull(extra,0)>(select max(salary+ifnull(extra,0)) from emp where deptno=30);
> 
> -- 4.查询工作和工资与martin完全相同的员工信息
> select job from emp where ename='martin';
> select salary+ifnull(extra,0) from emp where ename='martin';
> select * from emp where job='salesman' and salary+ifnull(extra,0)=2650;
> -- 整合
> select 
> 	* 
> from 
> 	emp 
> where 
> 	job=(select job from emp where ename='martin') 
> and 
> 	salary+ifnull(extra,0)=(select salary+ifnull(extra,0) from emp where ename='martin')
> and
> 	ename!='martin';
> 
> -- 5.查询各个部门工资最高的员工信息
> -- 方式一:不严谨
> -- a.查询各个部门的最高薪资
> select max(salary) from emp group by deptno;
> -- b.查询工资为3000，2975，5000的员工信息
> select * from emp where salary in (3000,2975,5000);
> -- c.整合
> select * from emp where salary in (select max(salary) from emp group by deptno);
> 
> -- 问题：10号部门有员工的薪资和30号部门的最高薪资相同
> insert into emp values(7219,'aaa','female','salesman',7698,'1981-02-20',2975,300,10);
> 
> -- 方式二：严谨写法
> -- a.根据deptno分组，得到deptno和对应的最高薪资,得到一张临时表
> create table new_emp (select deptno,max(salary) max_sal from emp group by deptno);
> select * from new_emp;
> -- b.将emp和new_emp进行连接查询
> select * from new_emp left join emp on new_emp.deptno=emp.deptno and new_emp.max_sal=emp.salary; -- 左外连接
> select * from emp right join new_emp on new_emp.deptno=emp.deptno and new_emp.max_sal=emp.salary; -- 右外连接
> select * from new_emp join emp on new_emp.deptno=emp.deptno and new_emp.max_sal=emp.salary;  -- 内连接
> 
> -- c.整合
> select 
> 	* 
> from 
> 	(select deptno,max(salary) max_sal from emp group by deptno) new_emp
> left join 
> 	emp 
> on 
> 	new_emp.deptno=emp.deptno 
> and 
> 	new_emp.max_sal=emp.salary;
> 
> -- 6.查询10号部门中工资高于20号部门中任意一人的信息
> -- any(select ...)
> -- a.查询20号部门的所有的员工薪资
> select salary from emp where deptno=20;
> -- b.查询薪资高于(800,3000)中任意一个的信息
> select * from emp where deptno=10 and salary>any(select salary from emp where deptno=20);
> 
> -- 7.查询10号部门中工资高于20号部门中所有人的信息
> -- all(select...)
> select * from emp where deptno=10 and salary>all(select salary from emp where deptno=20);
> ```

#### 2.自连接

> 自连接：自己连接自己，相当于起别名 
>
> 本质：通过给一张表起别名，达到使用两张表的目的，通过比对获取需要的数据，其实还是连接查询

> ```mysql
> -- 1.查询和blake在同一个部门的员工信息
> -- 子查询
> select * from emp where deptno=(select deptno from emp where ename='blake') and ename!='blake';
> -- 自连接
> -- e1:参照表   e2:目标表
> select 
> 	e2.*     -- 查询e2表中的所有字段
> from 
> 	emp e1 
> join 
> 	emp e2 
> on 
> 	e1.ename='blake' and e2.deptno=e1.deptno and e2.ename!='blake';
>     
> -- 2.查询工资高于jones的员工信息
> -- 子查询
> select * from emp where salary+ifnull(extra,0)>(select salary+ifnull(extra,0) from emp where ename='jones');
> -- 自连接
> -- e1:参照表   e2:目标表
> select 
> 	e2.*
> from
> 	emp e1
> join 
> 	emp e2
> on
> 	e1.ename='jones' and e2.salary+ifnull(e2.extra,0)>e1.salary+ifnull(e1.extra,0);
> 
> ```

### 二、常用函数【重点掌握】

#### 1.字符串函数

> ```python
> concat(a, b) 将a和b拼接成一个字符串
> length("子符串") 计算字符串的字节长度
> char_length()  计算字符个数
> lower()  小写转换
> upper()  大写转换
> left(str, len) 从字符串str的左边截取len个字符
> right(str, len) 从字符串str的右边截取 len个字符
> substr(str,   start, len) 截取str的子字符串，从start位置开始，截取len个字符，start可以是负数，表示从右边开始
> replace(str, sub, replace_str) 替换子子符串
> trim() 同python的strip()函数，删除两端的空白
> instr(str, sub) 返回sub在str的首次出现的位置， 索引位置是从1开始
> lpad(str,len,sub)  如果str的长度不足时，在左边填充sub字符， 同Python的str对象的rjust()
> rpad(str, len, sub) 如果str的长度不足时，在右边填充sub字符, 同Python的str对象的ljust()
> 
> char(N) 将AscII数值转成字符， N可以是一个字符，也可以是数值 【注意】在8.0中返回十六进制字符串。
> ord(str) 将ASCII字符转成数值
> 
> format(n, 小数位长) 将n转成带千位符‘#，###.##’格式的字符串
> ```

> ```mysql
> -- 一、基本使用
> select charset('abc');
> -- char(N) 将AscII数值转成字符， N可以是一个字符，也可以是数值 【注意】在8.0中返回十六进制字符串。
> select char(48);
> select ord('A');  -- 65
> -- concat(a, b) 将a和b拼接成一个字符串
> select concat('abc','123');
> -- length("子符串") 计算字符串的字节长度
> select length('abc');
> -- instr(str, sub) 返回sub在str的首次出现的位置， 索引位置是从1开始
> select instr('adminname','n');
> -- left(str, len) 从字符串str的左边截取len个字符
> select left('abcdef',2);
> -- right(str, len) 从字符串str的右边截取 len个字符
> select right('abcdef',2);
> -- replace(str, sub, replace_str) 替换子子符串
> select replace('today is a good day today today','today','yesterday');
> -- lpad(str,len,sub)  如果str的长度不足时，在左边填充sub字符， 同Python的str对象的rjust()
> select lpad('hello',20,'*');
> -- rpad(str, len, sub) 如果str的长度不足时，在右边填充sub字符, 同Python的str对象的ljust()
> select rpad('hello',20,'*');
> -- lower()  小写转换
> select lower('JGDfjae');
> -- upper()  大写转换
> select upper('JGDfjae');
> -- trim() 同python的strip()函数，删除两端的空白
> select trim('     hello     ');
> select ltrim('     hello     ');
> select rtrim('     hello     ');
> -- strcmp(sub1,sub2):比较两个字符串的大小,大于：1，小于：-1  等于：0
> -- 注意：依据的是ASICII，但是不缺区分大小写
> select strcmp('abc','HGf');
> 
> -- 二、结合表进行操作
> -- 1.查询emp表中员工姓名为4个字母的员工信息
> select * from emp where ename like '____';
> select * from emp where length(ename)=4;
> 
> -- 2.将员工的姓名，工作通过-的方式连接
> select ename,job from emp;
> select concat(ename,'-',job) from emp;
> 
> -- 3.查询姓a的员工信息
> select * from emp where ename like 'a%';
> select * from emp where left(ename,1)='a';
> 
> -- 4.查询员工姓名最后一位为n的员工信息
> select * from emp where ename like '%n';
> select * from emp where right(ename,1)='n';
> ```

#### 2.日期函数

> ```python
>   获取当前时间
>    		curdate() 年月日
>    		curtime() 时分秒
>    		now() 年月日 十分秒
>    时间差
>    	datediff(时间1， 时间2) --- 结果是天数
>    获取时间的年份
>    	year(时间)
>    获取时间的月份
>    	month(时间)
>    获取时间的日期
>    	dayofmonth(时间)
>    获取小时
>    	hour(时间)
>    获取分钟
>    	minute(时间)
>    获取秒
>    	second(时间)
>    星期
>    	dayofweek(时间)  周日是1  周六是7
>    获取一年中的第几天
>    	dayofyear(时间)
>    在指定的时间上做加减法
>    	date_add(时间, interval 增加的数据 日期种类 ) 加法
>    	date_sub(时间, interval 增加的数据 日期种类 )  减法
>    	
>    	日期种类（以add 为例）
>    		year  增加的是年    interval 1 year  在原来的基础上增加1年
>    		month 增加的是月    interval 1 month  在原来的基础上增加1月
>    		day   增加的是天    interval 1 day  在原来的基础上增加1天
>    		hour  增加的是小时
>    		minute 增加的是分钟
>    		second 增加的是秒
>    		year_month 增加的几年几月   interval '1-1' year_month    【年月日之间的连接符是-】
>    		hour_minute 增加的是几时几分     interval '1:1' hour_minute   【时分秒之间的连接符是冒号】
>    		hour_second  增加的是几时几分几秒     interval '1:1:1' hour_second 
>    		day_hour 增加的几天几小时  interval '1 1' day_hour  【小时和天之间是空格分割的】
>         day_minute 增加的是几天几时几分  interval '1 1:1' day_minute
>         day_second 增加的是几天几时几分几秒 interval '1 1:1:1' day_second
>         minute_second 增加的是几分几秒     interval '1:1' minute_second
>   	时间格式化
>     	date_format(时间, 格式化格式)
>     		%Y --- 年    ******
>     		%m --- 月    ******
>     		%d --- 日    ******
>     		%H --- 24小时制时    ******    
>     		%I --- 12小时制     ******
>     		%p --- 上下午的标记 am  pm
>     		%i --- 分钟     ******
>     		%S、%s -- 秒    ******
>     		%M --- 月份的英文名称
>     		%j --- 一年中的第几天
>     		%W --- 星期 标识
>     		%w --- 星期几
>    
>    
>    week(时间) --- 获取的这个日期是一年中的第几周  默认采用的是国外的时间
>    week(时间, 1) --- 以星期一为第一天
>    		周数是从0开始的
> ```

> ```mysql
> -- 日期函数的基本使用
> -- 日期
> select current_date();
> -- 时间
> select current_time();
> -- 日期+时间
> select current_timestamp();
> select now();   --   ******
> 
> -- 分别获取指定使劲按的年月日时分秒 *****
> select year(now());
> select month(now());
> select day(now());
> select hour(now());
> select minute(now());
> select second(now());
> 
> -- 获取星期几，注意： 周日是1  周六是7
> -- 比如：当前是星期二，查询结果为3
> select dayofweek(now()); -- 3
> 
> -- 获取一年的第几天
> select dayofyear(now());
> 
> -- 时间的加减运算   *****
> select date_add(now(),interval 2 year);    -- 增加2年
> select date_add(now(),interval -2 year);   -- 减少2年
> 
> select date_sub(now(),interval 2 year);    -- 减少2年
> select date_sub(now(),interval -2 year);   -- 增加2年
> 
> select date_add('2016.12.3',interval 2 month);   
> select date_sub('2016.12.3',interval 2 day);  
> 
> -- 日期格式化
> select date_format(now(),'%Y/%m/%d');
> select date_format(now(),'%Y.%m.%d %H:%i:%s');
> 
> -- 日期之间求差值
> -- datediff：返回天数
> select datediff('2024.4.16','2024.2.13');  -- 返回的是天数 ,前面的日期 - 后面的日期
> -- timestrapdiff(结果的单位，date1,date2)
> select timestampdiff(year,'2024.2.13','2024.4.16'); 
> select timestampdiff(month,'2024.2.13','2024.4.16');   -- 后面的日期 - 前面的日期
> select timestampdiff(day,'2024.2.13','2024.4.16'); 
> ```