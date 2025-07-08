### 一、Workbench的使用

> MySQL可视化工具：Navicat、DBweaer、Workbench等
>
> ```mysql
> -- 注意1：每次打开workbench，点击连接，相当于登录了mysql，一定要记得先选择数据库【use xxx;】
> -- 注意2:一个连接一旦建立完成，就可以重复使用，只要双击即可
> -- 注意3：所有的sql语句都可以书写在当前workbench文件中，不管是建库，建表，删除，修改，增加等操作都是可以的
> -- 注意4：书写在文件中的sql语句，是可以持久化的，只需要保存文件即可，按下ctrl + s即可
> -- 注意5：如果需要创建一个新的query文件，则通过左上角file---->New Query 
> ```

### 二、DML

> 查询表中所有记录：
>
> ```python
> select * from 表名;      # *表示所有字段（列）
> ```

#### 1.添加记录insert

> a.向所有字段添加数据
>
> ```sql
> insert into 表名 value(值1, 值2, 值3, ...);
> ```
>
> b.向指定字段添加数据
>
> ```sql
> insert into 表名 (字段1,字段2,...) values (值1,值2,...);
> ```
>
> c.批量添加（所有字段）
>
> ```sql
> insert into 表名 values (值1, 值2, 值3, ...),(值1, 值2, 值3, ...),...;
> ```
>
> d.批量添加（指定字段）
>
> ```sql
> insert into 表名 (字段1,字段2,...) values (值1,值2,...),(值1,值2,...),...;
> ```

> sql演示：
>
> ```mysql
> use mydb1;
> 
> -- DML:数据表的增删改的操作
> -- 建表
> -- 创建表的时候，不严谨写法如下：
> create table a1(
> sid int,
> name varchar(10),
> score int
> );
> 
> -- 问题1：自定义的字段和关键字重名
> -- 解决方案：创建表的时候，为了避免自定义的表名，字段名和系统的关键字重名，则可以通过反引号区分【反引号和波浪线是同一个键】
> -- 下面是严谨的写法
> create table `b1`(
> `sid` int,
> `name` varchar(10),
> `score` int
> );
> 
> -- 注意：每条sql语句的后面最好【一定】加分号
> 
> -- 问题2：对于陌生的表，不知道字段的含义，则无法确定其中的业务逻辑
> -- 解决方案：给表或字段添加注释，注释只是一个普通的字符串，直接添加普通引号即可
> create table `student`(
> `sid` int comment '学号',
> `name` varchar(20) comment '姓名',
> `score` int comment '成绩',
> `age` int comment '年龄'
> )engine=InnoDB comment '学生表';
> -- engine=InnoDB是MySQL默认的驱动
> 
> # insert:向指定表中插入数据
> select * from student;
> 
> -- a.给所有字段插入单条数据,注意：默认给所有字段插入数据，值的个数和字段的个数一定要完全匹配
> -- insert into student value (1001,'aaa');  -- 错误写法
> -- 添加注释的快捷键：选中-----》ctrl + /
> insert into student value (1001,'aaa',100,10);
> 
> -- b.给指定字段插入单条数据，注意：未指定的字段根据建表的设定会插入空值
> insert into student (sid,name) value (1002,'bbb');
> 
> -- c.给所有字段插入多条数据
> insert into student value(1004,'faf',89,9),(1006,'zzz',66,11),(1003,'xiaoming',90,12),(1005,'zhangsan',77,8);
> 
> -- d.给指定字段插入多条数据
> insert into student (sid,name) value (1007,'wangwu'),(1009,'kjs'),(1010,'fahf'),(1012,'jack');
> insert into student (sid,name,age) value (1007,'yuw',12),(1009,'cnhf',8),(1010,'lks',9),(1012,'tom',10);
> 
> -- 注意：1.值不要超出列定义的长度  2.如果要插入空值，使用null,默认情况下，没有传值也是null
> -- 3.插入日期类型的时候，和字符串的用法一样，也是用引号表示
> ```

#### 2.删除记录delete

> a.删除表中所有记录
>
> ```sql
> delete from 表名;
> ```
>
> b.删除表中所有记录
>
> ```sql
> truncate table 表名;
> ```
>
> c.根据条件删除指定记录
>
> ```python
> delete from 表名 where 条件;
>
> # 注意：delete和truncate的区别
> 	delete：删除表中的数据，表结构还在，删除后的数据可以找回
> 	truncate：把表直接drop掉，然后再创建一个同样的新表，删除的数据不能找回，执行速度比delete快
> 	
> 	#1
> 	当表被TRUNCATE 后，这个表和索引所占用的空间会恢复到初始大小
> 	DELETE操作不会减少表或索引所占用的空间
> 	drop语句将表所占用的空间全释放掉
> 	drop > truncate > delete
> 	
> 	#2.
> 	TRUNCATE 只能对TABLE；         
> 	DELETE可以是table和view
> 	
> 	#3
> 	TRUNCATE 和DELETE只删除数据， DROP则删除整个表（结构和数据）
> 	
> 	#4
> 	drop是DDL
> 	truncate,delete语句为DML
> ```

#### 3.修改记录update

> a.根据条件修改指定记录
>
> ```sql
> update 表名 set 字段名1 = 字段值1,字段名2 = 字段值2,... where 条件;
> ```
>
> b.修改所有记录
>
> ```sql
> update 表名 set 字段名1 = 字段值1,字段名2 = 字段值2,...;
> ```

> sql演示：
>
> ```mysql
> -- delete和update
> -- DDL:drop   alter，主要针对数据库或数据表操作
> -- DML:delete  update,主要针对数据/记录进行操作
> 
> select  * from student;
> 
> -- 1
> -- a.删除所有记录
> -- 默认情况下，打开了安全模式，无法直接删除表中所有记录，必须有where子句
> delete from student;
> 
> -- b.删除指定条件的数据
> delete from student where age is null;
> 
> -- 2.
> -- 修改所有记录
> update student set age=10;
> -- 修改指定条件的数据
> update student set age=10 where age is null;
> 
> 
> -- 注意：使用drop,delete,update关键字的时候，一定要非常谨慎
> ```

#### 三、DQL

> 数据查询语言
>
> 数据库执行DQL语言不会对数据进行改变，而是让数据库发送结果集给客户端
>
> 查询返回的结果集是一张虚拟表
>
> 语法：
>
> ```python
> SELECT 列名 FROM 表名【WHERE --> GROUP BY -->HAVING--> ORDER BY】
> ```

#### 1.基础查询

> 查询全部
>
> ```sql
> select * from 表名;
> ```
>
> 根据指定字段查询
>
> ```sql
> select 字段名1,字段名2,... from 表名;
> ```

#### 2.条件查询-where

> 主要结合where子句使用，在where关键字后跟上条件，查询时根据条件进行筛选
>
> 注意：where子句其实就是一个操作符，类似于Python中的if语句，可以做数据的筛选
>
> ```
> 筛选条件
> 
> 逻辑运算符
> 	and、or、!
> 
> 关系运算符
> 	大于、大于等于、小于、小于等于、等于(=)、不等于(!=)
> 
> 指定范围之内
> 	between  ... and …   注意：包头包尾【闭区间】
> 
> 在指定列表中
> 	in (值1，值2，值3，...)
> 	不在指定列表中 not in	
> 
> 空和非空
> 	判断为空 is null
> 	判断不为空 is not null
> ```
>
> 具体如下：
>
> | 符号            | 说明                                    |
> | --------------- | --------------------------------------- |
> | =               | 判断两个数据是否相等  sname='侯林沅'    |
> | >               | 判断前者是否大于后者                    |
> | `>=`            | 判断前者是否大于等于后者                |
> | <               | 判断前者是否小于后者                    |
> | <=              | 判断前者是否小于等于后者                |
> | !=              | 判断两个数据是否不相等                  |
> | between A and B | 判断某个数据是否在区间[A,B]内,闭区间    |
> | in              | 判断数据是否在某个容器中                |
> | not in          | 判断数据是否不在某个容器中              |
> | is null         | 判断某个数据是否是空值                  |
> | is not null     | 判断某个数据是否不是空值                |
> | like            | 模块查询  _表示单个符号   %匹配多个符号 |
> | regexp          | 判断是否满足某个正则表达式              |
> |                 | 逻辑与  逻辑或  逻辑非                  |

#### 3.模糊查询-like

> where等于子句号(=)，用来精确匹配工作，如 author='习大大‘。 但也有可能，我们要求过滤掉所有的结果，author应包含的名称："习"。这时需要使用where子句结合like子句使用
>
> 通配符：
>
> ​	_： 单个任意一个字符
>
> ​	%：任意0~n个字符【n大于等于1】
>
> ```mysql
> -- a.查询姓张的学生信息    
> -- b.查询姓名中有'小'的学生信息
> -- c.查询姓名由3个字符组成，最后一个字符为b的学生信息
> -- d.查询姓名中第2个字符为b的学生信息
> -- e.查询姓名为四个字的学生信息
> ```

#### 4.字段控制查询

> as:可以给表、字段起别名，为了区分，为了简化
>
> ​	用法：select 字段  as  别名
>
> ​	注意：as可以省略
>
> ifnull():将null转化为其他数据
>
> distinct：去除重复记录

> sql演示：
>
> ```mysql
> -- DQL
> 
> -- 1.基础查询
> -- 查询指定表中的所有字段
> select * from student;
> 
> -- 查询指定表中的指定字段
> select sid,name from student;
> 
> -- 2.条件查询
> -- where子句
> -- 格式：select * from  xxx where 条件
> 
> -- a.查询成绩大于90分的学生信息
> select * from student where score>90;
> 
> -- b.查询成绩在70分~90分之间的学生信息
> select * from student where score>=70 and score<=90;
> select * from student where score between 70 and 90;
> 
> -- c.查询成绩是66，77，88，99的学生信息
> select * from student where score=66 or score=77 or score=88 or score=99;
> select * from student where score in (66,77,88,99);
> 
> -- d.查询成绩不是66，77，88，99的学生信息
> select * from student where score not in (66,77,88,99);
> 
> -- e.查询未参加考试的学生信息【成绩为空】
> select * from student where score is null;
> 
> -- f.查询姓名为abc或成绩为80的学生信息
> select * from student where name='abc' or score=80;
> 
> -- 3.模糊查询
> -- where结合like关键字使用
> -- a.查询姓张的学生信息 
> select * from student where name like '张%';
>    
> -- b.查询姓名中有'小'的学生信息
> select * from student where name like '%小%';
> 
> -- c.查询姓名由3个字符组成，最后一个字符为w的学生信息
> select * from student where name like '__w';
> 
> -- d.查询姓名中第2个字符为a的学生信息
> select * from student where name like '_a%';
> 
> -- e.查询姓名为四个字的学生信息
> select * from student where name like '____';
> 
> -- 4.字段控制查询
> -- as:起别名，可以省略,经常用于多表查询中
> select sid as 学号,name as 姓名 from student;
> select sid  学号,name  姓名 from student;
> select sid as 学号,name as 姓名 from student s;
> 
> -- ifnull(字段,value),如果指定字段的值为null，则显示为value
> select ifnull(score,0) from student;
> 
> -- c.distinct:去重的
> -- 针对整条数据去重
> select distinct * from student;
> -- 针对字段去重
> select distinct age from student;
> ```
