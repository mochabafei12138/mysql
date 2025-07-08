### 一、数据库中的函数和存储过程【了解】

> 存储过程和函数，是用来实现一组关于表操作的SQL语句、可重复地执行操作数据库的集合。
>
> 存储过程和函数可以简单的理解为一条或多条SQL语句的集合。存储过程和函数就是**事先经过编译并存储在数据库**中的一段SQL语句集合。存储过程和函数执行不是由程序调用，也不是手动启动，而是由事件触发、激活从而实现执行的。
> 他们的主要区别是函数必须有返回值，而存储过程可以没有。

#### 1.函数定义及调用

> 就说的是自定义函数，但是因为日常工作复杂的逻辑都不在数据库上操作，一般都是在前后端。所以了解一下 如何定义，如何使用分支语句、循环语句即可
>
> 因为sql中语句结束标记是`;` 定义函数的时候 函数体中会有多条语句，如果还使用分号的话，那定义中途就会被中断掉 
>
> 所以定义之前要先修改一下语句结束的标记 
>
> ```mysql
> -- 1.函数的基本定义及调用
> -- 修改语句结束的标记为 $$
> delimiter $$
> create function 函数名(参数名 数据类型, 参数名 数据类型) returns 返回值的数据类型
> begin
> 	函数体
> end $$
> 
> -- 恢复结束标记 
> delimiter ;
> 
> -- 删除函数 
> drop function 函数名;
> 
> -- 2.带有分支结构的函数
> /*
>  * 	单分支
>  * 		if 条件 then 条件成立的语句
>  * 		end if;
>  *  双分支
>  * 		if 条件 then 条件成立的语句
>  * 		else 条件不成立的语句
>  * 		end if;
>  *  多分支
>  * 		if 条件 then 条件成立的语句
>  * 		elseif 条件1 then 条件1成立的语句
>  * 		...
>  * 		else 以上条件都不成立执行的语句
>  * 		end if;
>  */
>  
>  -- 3.带有循环的函数
>  /*
>  * 	SQL提供了三种循环
>  * 	1. while循环
>  * 		while 条件 do
>  * 			循环体语句
>  * 		end while;
>  *	2. repeat-until 一直重复做某件事 直到达到某个要求
>  *		repeat
>  *			循环体语句
>  *		until 循环结束条件 
>        end repeat;
>  *	3. loop死循环
>  *			给循环一个标记  在循环体中满足要求的位置结束该标记的循环
>  *		标记名称: loop
>  *			循环体语句
>  *			if 结束条件 then leave 标记名称;
>  *			end if;
>  *		end loop;
>  */
> ```

> ```mysql
> use stu_sco_cou_db;
> select * from tb_student;
> 
> /*
> mysql8.0之后，默认情况下，mysql不信任自定义的函数，信任的安全等级较低
> 在定义函数之前，提高自定义函数的信任度
> */
> set global log_bin_trust_function_creators=1;
> 
> -- 1.函数基本的定义和调用
> -- 需求：获取学生的年龄
> 
> /*
> 注意：
> 	1.因为定义函数的过程中，每条语句的后面需要添加分号，但是分号又是sql语句结束的标记
>     2.自定义函数之前，一般都会将结束符修改为$$
>     3.begin和end之间的内容是函数体【实现的具体需求】
> 	4.函数体中每条语句的结尾需要添加分号
>     5.当函数定义完毕之后，修改sql结束的符号为分号
>     6.自定义函数的过程中，尽量不要在sql之间添加注释，有可能会识别不到
> */
> delimiter $$
> create function get_age(birth date) returns int
> begin
>     return timestampdiff(year,birth,curdate());
> end $$
> delimiter ;
> 
> -- 注意：mysql中的函数必须设置返回值，调用函数必须结合select查看结果
> select *,get_age(birth) age from tb_student;
> 
> 
> -- 2.带有分支结构的函数
> -- 双分支
> -- 需求：创建一个判断成年或未成年的函数
> delimiter $$
> create function is_adult(age int) returns varchar(10)
> begin
> 	if age>= 18 then return '成年';
>     else return '未成年';
>     end if;
> end $$
> delimiter ;
> select is_adult(10) res;
> select *,is_adult(age) is_a from (select *,timestampdiff(year,birth,curdate()) age from tb_student) new_stu;
> 
> -- 多分支
> -- 需求：判断某个月份属于哪个季度
> delimiter $$
> create function get_quarter(monthly int) returns varchar(20)
> begin
> 	if monthly>=1 and monthly<=3 then return '第一季度';
>     elseif monthly>=4 and monthly<=6 then return '第二季度';
>     elseif monthly>=7 and monthly<=9 then return '第三季度';
>     else return '第四季度';
>     end if;
> end $$
> delimiter ;
> select get_quarter(8) res;
> select birth,get_quarter(month(birth)) res from tb_student;
> 
> 
> 
> -- 3.带有循环结构的函数
> -- 需求：求1~n之间所有整数的和
> /*
> 注意：
> 	if-end if 
>     while-end while
>     repeat-end repeat
>     loop-end loop
>     
> i = 1
> total = 0
> while i < 10:
> 	total += i
>     i += 1
> 
> */
> 
> -- a.while
> delimiter $$
> create function get_sum_while(n int) returns int
> begin
> 	declare i int default 1; -- 定义变量i，默认初始值为1
>     declare total int default 0; -- 定义变量total。默认初始值为0，记录和
>     while i <= n do
> 		set total = total + i;
>         set i = i + 1;
> 	end while;
>     return total;
> end $$
> delimiter ;
> select get_sum_while(100) res;
> 
> -- b.repeat
> delimiter $$
> create function get_sum_repeat(n int) returns int
> begin
> 	declare i int default 1; -- 定义变量i，默认初始值为1
>     declare total int default 0; -- 定义变量total。默认初始值为0，记录和
>     repeat
> 		set total = total + i;
>         set i = i + 1;
> 	until i > n end repeat;
>     return total;
> end $$
> delimiter ;
> 
> -- 函数定义有误的话，删除函数
> drop function get_sum_repeat;
> select get_sum_repeat(100) res;
> 
> -- c.loop
> delimiter $$
> create function get_sum_loop(n int) returns int
> begin
> 	declare i int default 1; -- 定义变量i，默认初始值为1
>     declare total int default 0; -- 定义变量total。默认初始值为0，记录和
>     A:loop
> 		set total = total + i;
>         set i = i + 1;
> 		if i > n then leave A;
>         end if;
> 	end loop;
>     return total;
> end $$
> delimiter ;
> select get_sum_loop(100) res;
> ```
>

#### 2.函数返回结果

> ```mysql
> -- 1.sql函数的返回值有且只能有一个
> -- 需求：返回按照生日排名第n的学生学号
> 
> -- 排名第1的学生学号
> select *,row_number() over(order by birth) rk from tb_student where birth is not null;
> 
> with t as (select *,row_number() over(order by birth) rk from tb_student where birth is not null)
> select stu_id from t where rk=1;
> 
> delimiter $$
> create function get_sid(n int) returns int
> begin
> 	declare sid int;  -- 声明一个变量，用于接受查询到的学生的学号
>     with t as (select *,row_number() over(order by birth) rk from tb_student where birth is not null)
> 	select stu_id into sid from t where rk=n;
>     return sid;
> end $$
> delimiter ;
> select get_sid(7) res;
> 
> -- 2.函数只能返回一个值，如果要多个值同时返回，处理方案：拼接
> -- a.同一条数据的多个字段值拼接，用concat_ws()
> -- 需求：获取第n名学生的学号和姓名
> 
> -- 注意：声明的类型和实际的数据类型要保持一致
> delimiter $$
> create function get_info(n int) returns varchar(20)
> begin
> 	declare info varchar(20);  
>     with t as (select *,row_number() over(order by birth) rk from tb_student where birth is not null)
> 	select concat_ws('-',stu_id,stu_name) into info from t where rk=n;
>     return info;
> end $$
> delimiter ;
> select get_info(7) res;
> 
> -- b.多条数据的同一个字段值拼接，用group_concat()
> -- 需求：返回前n名的学生学号
> delimiter $$
> create function get_rk(n int) returns varchar(20)
> begin
> 	declare info varchar(20);  
>     with t as (select *,row_number() over(order by birth) rk from tb_student where birth is not null)
> 	select group_concat(stu_id) into info from t where rk<=n;
>     return info;
> end $$
> delimiter ;
> select get_rk(4) res;
> ```

#### 3.存储过程

> 存储过程理解成对sql语句的封装
>
> 好处：把常用的sql语句进行封装成存储过程，执行效率要比使用的是有一条一条执行高
>
> 原理：将sql语句封装成存储过程的时候，已经对语句进行了解析优化，当我们调用存储过程的时候，直接使用执行引擎将结果返回
>
> ```mysql
> -- 修改语句结束的标记为 $$
> delimiter $$
> create procedure 存储过程名字(参数名 数据类型, 参数名 数据类型)
> begin
> 	sql语句
> end $$
> 
> -- 恢复结束标记 
> delimiter ;
> 
> -- 调用存储过程
> call 存储过程名字(传递的数据)
> 
> -- 删除存储过程
> drop procedure 存储过程名字;
> ```

#### 4.存储过程及返回结果

> ```mysql
> use stu_sco_cou_db;
> 
> /*
> 注意：
> 	a.返回值不是通过returns体现的，是通过参数体现的
>     b.参数的类型
> 		in    输入
>         out		输出
>         inout 输入也输出
>         
> 		in和out都是参数的修饰符，in表示传递进来的参数，out表示需要输出的参数
> */
> -- 1.获取指定学生的最高分/最低分/总成绩
> delimiter $$
> create procedure get_score(sid int)
> begin
> 	select stu_id,max(score) maxs,min(score) mins,sum(score) sums 
>     from tb_score where stu_id=sid;
> end $$
> delimiter ;
> 
> -- 调用存储过程
> call get_score(1000);
> 
> -- 2.将数据传递出出来，使用select展示
> delimiter $$
> create procedure get_num(inout sid int,
> 		out max_score float,
>         out min_score float,
>         out sum_score float)
> begin
> 	select stu_id,max(score) maxs,min(score) mins,sum(score) sums 
>     into sid,max_score,min_score,sum_score
>     from tb_score where stu_id=sid;
> end $$
> delimiter ;
> 
> -- out标记的参数，没有办法直接交给select展示
> -- 想要交给select，需要将其交给变量接收出来
> -- 定义变量，变量名必须以@开头
> set @maxs := 0;
> set @mins := 0;
> set @sums := 0;
> set @sid := 1000;
> -- 调用存储过程
> call get_num(@sid,@maxs,@mins,@sums);
> -- 通过select展示
> select @sid,@maxs,@mins,@sums;
> ```

#### 5.函数和存储过程的区别及优缺点

> 区别：
>
> 一般来说，存储过程实现的功能要复杂一点，而函数的实现的功能针对性比较强。 
>
> 1. 存储过程，功能强大，可以执行包括修改表等一系列数据库操作；用户定义函数不能用于执行一组修改全局数据库状态的操作。
> 2. 对于存储过程来说可以返回参数，如记录集，而函数只能返回值或者表对象。函数只能返回一个变量；而存储过程可以返回多个。存储过程的参数可以有IN,OUT类型，而函数只能有IN类型。存储过程声明时不需要返回类型，而函数声明时需要描述返回类型，且函数体中必须包含一个有效的RETURN语句。
> 3. 存储过程一般是作为一个独立的部分来执行，而函数可以作为查询语句的一个部分来调用（SELECT调用）

> 优缺点：
>
> 1. 优点：
>
>    存储过程和函数允许标准组件式编程，提高了SQL语句的重用性、共享性和可移植性。
>    存储过程和函数可以被作为一种安全机制来利用。
>    存储过程和函数能够实现较快的执行速度，能够减少网络流量。
>
> 2. 缺点：
>
>    存储过程和函数的编写比单句SQL语句复杂。
>    在编写存储过程和函数时，需要创建这些数据库对象的权限。

### 二、面试题讲解【重点掌握】

#### 1.连续n天登录问题

> ```mysql
> create table if not exists tb_login(
> id int primary key auto_increment comment '记录编号',
> dt datetime comment '登录时间',
> uid int comment '用户ID'
> );
> insert into tb_login(dt, uid) values('2023-01-01 08:17:09', 1001),
> ('2023-01-01 12:17:09', 1001),
> ('2023-01-01 09:17:09', 1002),
> ('2023-01-01 23:17:09', 1002),
> ('2023-01-01 10:17:09', 1003),
> ('2023-01-02 12:17:09', 1001),
> ('2023-01-02 16:17:09', 1002),
> ('2023-01-02 18:17:09', 1001),
> ('2023-01-03 05:17:09', 1003),
> ('2023-01-03 12:17:09', 1001),
> ('2023-01-03 22:17:09', 1001),
> ('2023-01-04 06:17:09', 1003),
> ('2023-01-04 22:17:09', 1002),
> ('2023-01-04 18:17:09', 1001),
> ('2023-01-05 21:17:09', 1003),
> ('2023-01-05 23:17:09', 1003),
> ('2023-01-06 09:17:09', 1002),
> ('2023-01-06 12:17:09', 1001),
> ('2023-01-06 09:17:09', 1002);
> ```
>

> ```mysql
> use mydb1;
> create table if not exists tb_login(
> id int primary key auto_increment comment '记录编号',
> dt datetime comment '登录时间',
> uid int comment '用户ID'
> );
> insert into tb_login(dt, uid) values('2023-01-01 08:17:09', 1001),
> ('2023-01-01 12:17:09', 1001),
> ('2023-01-01 09:17:09', 1002),
> ('2023-01-01 23:17:09', 1002),
> ('2023-01-01 10:17:09', 1003),
> ('2023-01-02 12:17:09', 1001),
> ('2023-01-02 16:17:09', 1002),
> ('2023-01-02 18:17:09', 1001),
> ('2023-01-03 05:17:09', 1003),
> ('2023-01-03 12:17:09', 1001),
> ('2023-01-03 22:17:09', 1001),
> ('2023-01-04 06:17:09', 1003),
> ('2023-01-04 22:17:09', 1002),
> ('2023-01-04 18:17:09', 1001),
> ('2023-01-05 21:17:09', 1003),
> ('2023-01-05 23:17:09', 1003),
> ('2023-01-06 09:17:09', 1002),
> ('2023-01-06 12:17:09', 1001),
> ('2023-01-06 09:17:09', 1002);
> -- 需求：连续3天登录的用户
> select * from tb_login;
> -- 对数据进行处理，每个用户每天只出现一次
> select uid,date(dt) login_dt from tb_login group by date(dt),uid;
> 
> -- 方式一：窗口偏移函数
> -- 连续3天登录：1号登录了 2号登录  3号登录
> -- 向上偏移的函数lead(偏移字段,偏移各个数) over(分组字段  排序字段 )
> with t as (select uid,date(dt) login_dt from tb_login group by date(dt),uid),
> t1 as (select *,
> 	lead(login_dt,1) over(partition by uid order by login_dt) second_dt,
>     lead(login_dt,2) over(partition by uid order by login_dt) third_dt
> from t)
> select distinct uid 
> from t1
> where date_add(login_dt,interval 1 day)=second_dt and
> date_add(second_dt,interval 1 day)=third_dt;
> 
> -- 方式二：使用自连接
> with t as (select uid,date(dt) login_dt from tb_login group by date(dt),uid)
> select distinct first_login.uid
> from t first_login join t second_login join t third_login
> on first_login.uid=second_login.uid and date_add(first_login.login_dt,interval 1 day)=second_login.login_dt
> and first_login.uid=third_login.uid and date_add(first_login.login_dt,interval 2 day)=third_login.login_dt;
> 
> -- 方式三：使用排名函数
> -- 上面两种方式可以实现，但是局限性较大，使用排名函数适用性更加广
> /*
> 连续登录的话：登录时间 - rk ,结果应该是一样的
> 思路：
> 	a.将登录时间向过去偏移 rk 天，得到偏移日期
>     b.按照用户与偏移后的日期进行归类，统计归类的个数
>     c.如果这个个数>=3的，表示至少3天连续登录
> */
> with t as (select uid,date(dt) login_dt from tb_login group by date(dt),uid),
> t1 as (select *,row_number() over(partition by uid order by login_dt) rk from t)
> select uid,date_sub(login_dt,interval rk day) diff,count(*) 天数
> from t1
> group by uid,date_sub(login_dt,interval rk day)
> having count(*) >=3;
> ```

#### 2.留存率问题

> ```mysql
> -- 留存率问题
> /*
> 留存：第一天登录的用户在第n天仍然登录的还有多少人
> 留存率：第一天登录的用户在第n天仍然登录的人数 / 第一天登录的人数
> 
> 作用：检验用户对产品的粘性
> 
> 关注的有：次日留存率  3日留存率   7日留存率
> 
> 以次日留存率为例
> 思路：
> 	a.统计用户第一次登录的日期
>     b.将这个日期与登录信息表进行连接，查找这个用户第二次登录的日期是否 是 第一次登录日期的第二天
>     c.按照注册日期分组，，统计这天注册的人数， 以及第二天登录的人数
> */
> -- with login_temp as (select uid,date(dt) login_dt from tb_login group by date(dt),uid)
> -- select * from login_temp;
> 
> -- 统计用户第一次登录的日期
> -- first_value
> -- with login_temp as (select uid,date(dt) login_dt from tb_login group by date(dt),uid)
> -- select distinct uid,first_value(login_dt) over(partition by uid order by login_dt) first_dt
> -- from login_temp;
> 
> -- 获取第二天依然登录的用户
> -- with login_temp as (select uid,date(dt) login_dt from tb_login group by date(dt),uid),
> -- reg_tb as (select distinct uid,first_value(login_dt) over(partition by uid order by login_dt) first_dt
> -- from login_temp)
> -- select * 
> -- from reg_tb left join login_temp second_login
> -- on reg_tb.uid=second_login.uid 
> -- and date_add(reg_tb.first_dt,interval 1 day) = second_login.login_dt;
> 
> -- 获取第二天登录的人数，次日留存率
> -- with login_temp as (select uid,date(dt) login_dt from tb_login group by date(dt),uid),
> -- reg_tb as (select distinct uid,first_value(login_dt) over(partition by uid order by login_dt) first_dt
> -- from login_temp)
> -- select 
> -- 	first_dt,count(reg_tb.uid) 注册人数,
> --     count(second_login.uid) 第二天登录的人数,
> --      count(second_login.uid) / count(reg_tb.uid) 次日留存
> -- from reg_tb left join login_temp second_login
> -- on reg_tb.uid=second_login.uid 
> -- and date_add(reg_tb.first_dt,interval 1 day) = second_login.login_dt
> -- group by first_dt;
> 
> -- 加上七日留存率
> with login_temp as (select uid,date(dt) login_dt from tb_login group by date(dt),uid),
> reg_tb as (select distinct uid,first_value(login_dt) over(partition by uid order by login_dt) first_dt
> from login_temp)
> select 
> 	first_dt,count(reg_tb.uid) 注册人数,
>     count(second_login.uid) 第二天登录的人数,
> 	count(second_login.uid) / count(reg_tb.uid) 次日留存,
> 	count(seven_login.uid) / count(reg_tb.uid) 七日留存,
>     count(three_login.uid) / count(reg_tb.uid) 三日留存
> from reg_tb 
> left join login_temp second_login
> on reg_tb.uid=second_login.uid and date_add(reg_tb.first_dt,interval 1 day) = second_login.login_dt
> left join login_temp seven_login
> on reg_tb.uid=seven_login.uid and date_add(reg_tb.first_dt,interval 6 day) = seven_login.login_dt
> left join login_temp three_login
> on reg_tb.uid=three_login.uid and date_add(reg_tb.first_dt,interval 2 day) = three_login.login_dt
> group by first_dt;
> ```

### 三、互联网常见指标查询【重点掌握】【作业】

#### 1.需求

> #### 00.数据描述
>
> 使用命令提示符工具安装3个库
>
> ```
> pip install pandas==1.2.4
> pip install sqlalchemy==1.4.45
> pip install pymysql
> ```
>
> 将互联网文件夹拖到pycharm中打开，执行导入数据的py文件， 在net数据库中产生相应的表，下面是相应表中字段解读
>
> - **tb_visit**：**访问统计表**
>   - visit_id：访问ID
>   - user_id：用户ID
>   - channel_id：渠道ID
>   - platform：访问平台
>   - stat_date：统计日期
>   - pv：浏览量
>   - click：点击量
>   - quit：退出量
>   - stay_duration：总停留时长
> - **tb_region**：**地区维度表**
>   - region_id：地区ID
>   - region_name：地区名称
>   - region_pid：上级地区ID
> - **tb_channel**：**推广渠道表**
>   - channel_id	渠道ID
>   - one_level：一级渠道名称
>   - two_level：二级渠道名称
>   - three_level：三级渠道名称
> - **tb_user**：**用户信息表**
>   - user_id：用户ID
>   - user_name：用户名称
>   - age：用户年龄
>   - sex：用户性别
>   - class：用户类型
>   - login_date：注册日期
>   - region_id：地区ID
>   - channel_id：渠道ID
>
> #### 01.题目01
>
> - 求**访问统计表**各访问平台的**浏览量**、**点击量**、**浏览至点击转化率**
>
> | platform   | pv    | click | conversion |
> | ---------- | ----- | ----- | ---------- |
> | Android    | 9784  | 3978  | 0.4066     |
> | IOS        | 11108 | 4250  | 0.3826     |
> | 移动浏览器 | 3025  | 947   | 0.3131     |
>
> #### 02.题目02
>
> - 求**用户信息表**用户数量前十的省份及相应的用户数量
>
> | province | user_num |
> | -------- | -------- |
> | 广东省   | 38       |
> | 四川省   | 21       |
> | 山东省   | 21       |
> | 河南省   | 20       |
> | 安徽省   | 18       |
> | 黑龙江省 | 16       |
> | 甘肃省   | 15       |
> | 重庆市   | 15       |
> | 山西省   | 14       |
> | 江苏省   | 14       |
>
> #### 03.题目03
>
> - 求**用户信息表**各一级渠道的VIP用户数量
>
> | one_level  | vip_num |
> | ---------- | ------- |
> | 新媒体营销 | 27      |
> | 线上渠道   | 9       |
> | 线下渠道   | 2       |
> | 自然流量   | 2       |
>
> #### 04.题目04
>
> - 求**用户信息表**各一级渠道的老用户数量占比
>
> | one_level  | old_num | total_num | old_pct |
> | ---------- | ------- | --------- | ------- |
> | 新媒体营销 | 59      | 164       | 0.3598  |
> | 线上渠道   | 24      | 59        | 0.4068  |
> | 线下渠道   | 13      | 34        | 0.3824  |
> | 自然流量   | 3       | 7         | 0.4286  |
>
> #### 05.题目05
>
> - 求**用户信息表**各年龄分组的用户数量
>
> | age_bins | user_num |
> | -------- | -------- |
> | (0, 18]  | 21       |
> | (18, 30] | 207      |
> | (30, 40] | 33       |
> | (40, +∞] | 3        |
>
> #### 06.题目06
>
> - 求**访问统计表**浏览量在2000以上的二级渠道及相应的浏览量
>
> | two_level | pv   |
> | --------- | ---- |
> | 基础上线  | 4897 |
> | 贴吧推广  | 4533 |
> | 微信推广  | 3830 |
> | 品牌推广  | 3216 |
> | 微博推广  | 2138 |
>
> #### 07.题目07
>
> - 求**用户信息表**各性别各用户类型的用户数量，以长表的结构展示
>
> | sex  | category | user_num |
> | ---- | -------- | -------- |
> | 女   | VIP用户  | 12       |
> | 女   | 新用户   | 58       |
> | 女   | 老用户   | 76       |
> | 男   | VIP用户  | 28       |
> | 男   | 新用户   | 67       |
> | 男   | 老用户   | 23       |
>
> #### 08.题目08
>
> - 求**用户信息表**各性别各用户类型的用户数量，以宽表的结构展示
>
> | sex  | new_num | old_num | vip_num |
> | ---- | ------- | ------- | ------- |
> | 女   | 58      | 76      | 12      |
> | 男   | 67      | 23      | 28      |
>
> #### 09.题目09
>
> - 求**用户信息表**每月注册的用户数量
>
> | year | month | user_num |
> | ---- | ----- | -------- |
> | 2015 | 10    | 27       |
> | 2015 | 11    | 35       |
> | 2015 | 12    | 30       |
> | 2016 | 1     | 28       |
> | 2016 | 2     | 29       |
> | 2016 | 3     | 31       |
> | 2016 | 4     | 24       |
> | 2016 | 5     | 29       |
> | 2016 | 6     | 30       |
> | 2016 | 8     | 1        |
>
> #### 10.题目10
>
> - 求**访问统计表**每月的**浏览量**、**退出量**、**浏览至点击转化率**
>
> | month   | pv   | quit | conversion |
> | ------- | ---- | ---- | ---------- |
> | 2015-07 | 1872 | 753  | 0.3365     |
> | 2015-08 | 1919 | 758  | 0.3538     |
> | 2015-09 | 1668 | 653  | 0.3795     |
> | 2015-10 | 4941 | 1290 | 0.4416     |
> | 2015-11 | 1470 | 622  | 0.3646     |
> | 2015-12 | 3045 | 947  | 0.3990     |
> | 2016-01 | 1701 | 700  | 0.3410     |
> | 2016-02 | 3769 | 1129 | 0.3940     |
> | 2016-03 | 1580 | 630  | 0.3601     |
> | 2016-04 | 1806 | 725  | 0.3372     |
> | 2016-05 | 146  | 60   | 0.3904     |
>
> #### 11.题目11
>
> - 求**访问统计表**各三级渠道的人均停留时长，并筛选大于3000的三级渠道
>
> | three_level | per_duration |
> | ----------- | ------------ |
> | 运营商      | 3516         |
> | 小号积累    | 3443         |
> | 垂直社区    | 3085         |
> | 安卓论坛    | 3024         |
>
> #### 12.题目12
>
> - 以一级渠道分组**去重合并**二级渠道，并以"/"为分隔符
>
> | one_level  | two_level                                    |
> | ---------- | -------------------------------------------- |
> | 新媒体营销 | 贴吧推广/微博推广/微信推广/品牌推广/事件营销 |
> | 线上渠道   | 基础上线                                     |
> | 线下渠道   | 行货店面/水货刷机/手机厂商预装               |
> | 自然流量   | 自然流量                                     |
>
> #### 13.题目13
>
> - 求**访问统计表**各三级渠道的浏览量，并生成降序排名序号，最终展示前十
>
> | three_level  | pv   | idx  |
> | ------------ | ---- | ---- |
> | 小号导大号   | 1369 | 1    |
> | 事件营销     | 1362 | 2    |
> | 小号积累     | 1278 | 3    |
> | 风暴论坛     | 1248 | 4    |
> | 安卓应用商店 | 1210 | 5    |
> | 微信互推     | 1183 | 6    |
> | 水货刷机     | 1177 | 7    |
> | 机锋论坛     | 1155 | 8    |
> | 手机厂商预装 | 1142 | 9    |
> | 问答类       | 1141 | 10   |
>
> #### 14.题目14
>
> - 求**访问统计表**每月的**浏览量**和**累积浏览量**
>
> | month   | pv   | cum_pv |
> | ------- | ---- | ------ |
> | 2015-07 | 1872 | 1872   |
> | 2015-08 | 1919 | 3791   |
> | 2015-09 | 1668 | 5459   |
> | 2015-10 | 4941 | 10400  |
> | 2015-11 | 1470 | 11870  |
> | 2015-12 | 3045 | 14915  |
> | 2016-01 | 1701 | 16616  |
> | 2016-02 | 3769 | 20385  |
> | 2016-03 | 1580 | 21965  |
> | 2016-04 | 1806 | 23771  |
> | 2016-05 | 146  | 23917  |
>
> #### 15.题目15
>
> - 求**访问统计表**每月的**浏览量**和**环比增长率**
>
> | month   | cur_pv | pre_pv | growth_rate |
> | ------- | ------ | ------ | ----------- |
> | 2015-07 | 1872   |        |             |
> | 2015-08 | 1919   | 1872   | 0.0251      |
> | 2015-09 | 1668   | 1919   | -0.1308     |
> | 2015-10 | 4941   | 1668   | 1.9622      |
> | 2015-11 | 1470   | 4941   | -0.7025     |
> | 2015-12 | 3045   | 1470   | 1.0714      |
> | 2016-01 | 1701   | 3045   | -0.4414     |
> | 2016-02 | 3769   | 1701   | 1.2158      |
> | 2016-03 | 1580   | 3769   | -0.5808     |
> | 2016-04 | 1806   | 1580   | 0.1430      |
> | 2016-05 | 146    | 1806   | -0.9192     |
>
> #### 16.题目16
>
> - 求**访问统计表**各一级渠道下浏览量大于1000的三级渠道数量
>
> | one_level  | cnt  |
> | ---------- | ---- |
> | 新媒体营销 | 11   |
> | 线上渠道   | 3    |
> | 线下渠道   | 3    |
>
> #### 17.题目17
>
> - 求**访问统计表**各用户最近一次访问日期距离2016-05-02的天数，并筛选天数小于30的用户
>
> | user_id  | days   |
> | -------- | ------ |
> | USER0260 | 29     |
> | USER0261 | 29     |
> | USER0262 | 29     |
> | USER0263 | 29     |
> | USER0264 | 29     |
> | USER0001 | 28     |
> | USER0002 | 28     |
> | USER0003 | 28     |
> | USER0004 | 28     |
> | ......   | ...... |
>
> #### 18.题目18
>
> - 求**访问统计表**各一级渠道的新用户、老用户、VIP用户的平均停留时长，以宽表的结构展示
>
> | one_level  | new_duration | old_duration | vip_duration |
> | ---------- | ------------ | ------------ | ------------ |
> | 线上渠道   | 2380         | 2332         | 2168         |
> | 新媒体营销 | 2431         | 2496         | 2173         |
> | 线下渠道   | 2498         | 2051         | 1782         |
> | 自然流量   | 2813         | 972          | 2798         |

#### 2.实现

> ```mysql
> -- 1.求**访问统计表**各访问平台的**浏览量**、**点击量**、**浏览至点击转化率**
> -- 流程顺序：先浏览 -- 点击进入详情   点击行为的总量/浏览的总量
> /*
> 
> | platform   | pv    | click | conversion |
> | ---------- | ----- | ----- | ---------- |
> | Android    | 9784  | 3978  | 0.4066     |
> | IOS        | 11108 | 4250  | 0.3826     |
> | 移动浏览器 | 3025  | 947   | 0.3131     |
>  * 
>  */
> 
> 
> /*
>  * # 02.题目02
> - 求**用户信息表**用户数量前十的省份及相应的用户数量
> | province | user_num |
> | -------- | -------- |
> | 广东省   | 38       |
> | 四川省   | 21       |
> | 山东省   | 21       |
> | 河南省   | 20       |
> | 安徽省   | 18       |
> | 黑龙江省 | 16       |
> | 甘肃省   | 15       |
> | 重庆市   | 15       |
> | 山西省   | 14       |
> | 江苏省   | 14       |
>  */
> 
> 
> /*
>  * # 03.题目03
> 
> - 求**用户信息表**各一级渠道的VIP用户数量
> | one_level  | vip_num |
> | ---------- | ------- |
> | 新媒体营销 | 27      |
> | 线上渠道   | 9       |
> | 线下渠道   | 2       |
> | 自然流量   | 2       |
>  */
> 
> 
> /*
>  * # 04.题目04
> 
> - 求**用户信息表**各一级渠道的老用户数量占比
> | one_level  | old_num | total_num | old_pct |
> | ---------- | ------- | --------- | ------- |
> | 新媒体营销 | 59      | 164       | 0.3598  |
> | 线上渠道   | 24      | 59        | 0.4068  |
> | 线下渠道   | 13      | 34        | 0.3824  |
> | 自然流量   | 3       | 7         | 0.4286  |
>  */
> 
> 
> /*
>  * # 05.题目05
> 
> - 求**用户信息表**各年龄分组的用户数量
> | age_bins | user_num |
> | -------- | -------- |
> | (0, 18]  | 21       |
> | (18, 30] | 207      |
> | (30, 40] | 33       |
> | (40, +∞] | 3        |
> */
> 
> 
> /*
>  * # 06.题目06
> 
> - 求**访问统计表**浏览量在2000以上的二级渠道及相应的浏览量
> | two_level | pv   |
> | --------- | ---- |
> | 基础上线  | 4897 |
> | 贴吧推广  | 4533 |
> | 微信推广  | 3830 |
> | 品牌推广  | 3216 |
> | 微博推广  | 2138 |
>  */
> 
> 
> /*# 07.题目07
> 
> - 求**用户信息表**各性别各用户类型的用户数量，以长表的结构展示
> | sex  | category | user_num |
> | ---- | -------- | -------- |
> | 女   | VIP用户  | 12       |
> | 女   | 新用户   | 58       |
> | 女   | 老用户   | 76       |
> | 男   | VIP用户  | 28       |
> | 男   | 新用户   | 67       |
> | 男   | 老用户   | 23       |
>  * 
>  */
> 
> 
> /*
>  * # 08.题目08
> 
> - 求**用户信息表**各性别各用户类型的用户数量，以宽表的结构展示
> 
> | sex  | new_num | old_num | vip_num |
> | ---- | ------- | ------- | ------- |
> | 女   | 58      | 76      | 12      |
> | 男   | 67      | 23      | 28      |
>  */
> 
> 
> 
> /*# 09.题目09
> 
> - 求**用户信息表**每月注册的用户数量
> | year | month | user_num |
> | ---- | ----- | -------- |
> | 2015 | 10    | 27       |
> | 2015 | 11    | 35       |
> | 2015 | 12    | 30       |
> | 2016 | 1     | 28       |
> | 2016 | 2     | 29       |
> | 2016 | 3     | 31       |
> | 2016 | 4     | 24       |
> | 2016 | 5     | 29       |
> | 2016 | 6     | 30       |
> | 2016 | 8     | 1        |
>  * 
>  */
> 
> /*# 10.题目10
> 
> - 求**访问统计表**每月的**浏览量**、**退出量**、**浏览至点击转化率**
> | month   | pv   | quit | conversion |
> | ------- | ---- | ---- | ---------- |
> | 2015-07 | 1872 | 753  | 0.3365     |
> | 2015-08 | 1919 | 758  | 0.3538     |
> | 2015-09 | 1668 | 653  | 0.3795     |
> | 2015-10 | 4941 | 1290 | 0.4416     |
> | 2015-11 | 1470 | 622  | 0.3646     |
> | 2015-12 | 3045 | 947  | 0.3990     |
> | 2016-01 | 1701 | 700  | 0.3410     |
> | 2016-02 | 3769 | 1129 | 0.3940     |
> | 2016-03 | 1580 | 630  | 0.3601     |
> | 2016-04 | 1806 | 725  | 0.3372     |
> | 2016-05 | 146  | 60   | 0.3904     |
>  */
> 
> 
> /*
>  * # 11.题目11
> - 求**访问统计表**各三级渠道的人均停留时长，并筛选大于3000的三级渠道
> | three_level | per_duration |
> | ----------- | ------------ |
> | 运营商      | 3516         |
> | 小号积累    | 3443         |
> | 垂直社区    | 3085         |
> | 安卓论坛    | 3024         |
>  */
> 
> 
> /*
>  * # 12.题目12
> 
> - 以一级渠道分组**去重合并**二级渠道，并以"/"为分隔符
> 
> | one_level  | two_level                                    |
> | ---------- | -------------------------------------------- |
> | 新媒体营销 | 贴吧推广/微博推广/微信推广/品牌推广/事件营销 |
> | 线上渠道   | 基础上线                                     |
> | 线下渠道   | 行货店面/水货刷机/手机厂商预装               |
> | 自然流量   | 自然流量                                     |
>  */
> 
> 
> /*
>  * # 13.题目13
> 
> - 求**访问统计表**各三级渠道的浏览量，并生成降序排名序号，最终展示前十
> | three_level  | pv   | idx  |
> | ------------ | ---- | ---- |
> | 小号导大号   | 1369 | 1    |
> | 事件营销     | 1362 | 2    |
> | 小号积累     | 1278 | 3    |
> | 风暴论坛     | 1248 | 4    |
> | 安卓应用商店 | 1210 | 5    |
> | 微信互推     | 1183 | 6    |
> | 水货刷机     | 1177 | 7    |
> | 机锋论坛     | 1155 | 8    |
> | 手机厂商预装 | 1142 | 9    |
> | 问答类       | 1141 | 10   |
>  */
> 
> 
> /*
>  * # 14.题目14
> 
> - 求**访问统计表**每月的**浏览量**和**累积浏览量**
> | month   | pv   | cum_pv |
> | ------- | ---- | ------ |
> | 2015-07 | 1872 | 1872   |
> | 2015-08 | 1919 | 3791   |
> | 2015-09 | 1668 | 5459   |
> | 2015-10 | 4941 | 10400  |
> | 2015-11 | 1470 | 11870  |
> | 2015-12 | 3045 | 14915  |
> | 2016-01 | 1701 | 16616  |
> | 2016-02 | 3769 | 20385  |
> | 2016-03 | 1580 | 21965  |
> | 2016-04 | 1806 | 23771  |
> | 2016-05 | 146  | 23917  |
>  */
> 
> /*
>  * # 15.题目15
> 
> - 求**访问统计表**每月的**浏览量**和**环比增长率**
> | month   | cur_pv | pre_pv | growth_rate |
> | ------- | ------ | ------ | ----------- |
> | 2015-07 | 1872   |        |             |
> | 2015-08 | 1919   | 1872   | 0.0251      |
> | 2015-09 | 1668   | 1919   | -0.1308     |
> | 2015-10 | 4941   | 1668   | 1.9622      |
> | 2015-11 | 1470   | 4941   | -0.7025     |
> | 2015-12 | 3045   | 1470   | 1.0714      |
> | 2016-01 | 1701   | 3045   | -0.4414     |
> | 2016-02 | 3769   | 1701   | 1.2158      |
> | 2016-03 | 1580   | 3769   | -0.5808     |
> | 2016-04 | 1806   | 1580   | 0.1430      |
> | 2016-05 | 146    | 1806   | -0.9192     |
>  */
> 
> 
> /*
>  * # 16.题目16
> 
> - 求**访问统计表**各一级渠道下浏览量大于1000的三级渠道数量
> | one_level  | cnt  |
> | ---------- | ---- |
> | 新媒体营销 | 11   |
> | 线上渠道   | 3    |
> | 线下渠道   | 3    |
>  */
>  
>  
> 
> /*
>  * # 17.题目17
> 
> - 求**访问统计表**各用户最近一次访问日期距离2016-05-02的天数，并筛选天数小于30的用户
> | user_id  | days   |
> | -------- | ------ |
> | USER0260 | 29     |
> | USER0261 | 29     |
> | USER0262 | 29     |
> | USER0263 | 29     |
> | USER0264 | 29     |
> | USER0001 | 28     |
> | USER0002 | 28     |
> | USER0003 | 28     |
> | USER0004 | 28     |
> | ......   | ...... |
> */
> 
> 
> /*
>  * # 18.题目18
> 
> - 求**访问统计表**各一级渠道的新用户、老用户、VIP用户的平均停留时长，以宽表的结构展示
> | one_level  | new_duration | old_duration | vip_duration |
> | ---------- | ------------ | ------------ | ------------ |
> | 线上渠道   | 2380         | 2332         | 2168         |
> | 新媒体营销 | 2431         | 2496         | 2173         |
> | 线下渠道   | 2498         | 2051         | 1782         |
> | 自然流量   | 2813         | 972          | 2798         |
>  */
> ```
>
> 