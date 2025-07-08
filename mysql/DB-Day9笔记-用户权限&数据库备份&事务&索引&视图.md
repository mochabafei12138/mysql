### 1.创建用户及分配权限

> 一个项目对应着一个数据库，管理这个项目的人才具有操作这个数据库的权限；为每一个项目单独创建一个用户，给这个用户分配操作对应数据库的权限 【超级管理员root，创建用户 给用户分配权限】
>
> ```mysql
> -- 语法
> -- 创建用户
> create user 用户名@'IP地址' identified by '用户密码';
> 
> /*
> ip地址代表着用户可以在哪台计算机上进行登录连接数据库服务器【ip地址是计算机的唯一标识】
> 	如果写的是localhost/127.0.0.1 【数据库服务所在的本机地址】
> 	如果写的是192.168.10.1 
> 			登录者只能在这个ip地址的电脑上进行登录
> 			一般限定ip地址的  工作的网络都是局域网 -- 只能在公司里做
> 	如果写的是%  代表可以使用任意的电脑 通过用户连接数据库服务
> */
> 
> -- 删除用户 
> drop user 用户名@'IP地址';
> 
> -- 修改用户登录数据库服务器的ip地址
> alter user 用户名@'ip地址' rename to 用户名@'新的IP地址';
> 
> -- 给用户分配权限 
> grant 权限1,权限2,权限3,... on 数据库名.数据表名 to 用户名@'ip地址';
> /*
> 权限:就是操作数据库的核心指令
> 	如：create	drop alter insert  update  delete  select...
> 	
> 	所有的权限都给到的话，可以使用grant all on 数据库名.数据表名 to 用户名@'ip地址';
> 	如果要把某个数据库下所有的表分配给该用户，则数据表名可以设置为*，泛指所有的数据表，格式：数据库名.*
> 	如果要把所有的数据库下所有的数据表分配给用户，则可以设置为*.*
> */
> 
> -- 撤销权限 
> revoke 权限1,权限2,权限3,... on 数据库名.数据表名 from 用户名@'ip地址';
> ```
>

> ```mysql
> -- 创建用户
> --  qianfeng是用户名，123456是密码
> -- ip地址：127.0.0.1，表示本机地址
> create user qianfeng@'127.0.0.1' identified by  '123456';
> 
> show databases;
> -- 用户管理的数据库mysql
> -- mysql库中有一张表user,专门存储用户的信息
> use mysql;
> select * from user;
> 
> -- 给用户分配权限
> grant select on mydb1.emp  to qianfeng@'127.0.0.1';
> grant update on mydb1.emp  to qianfeng@'127.0.0.1';
> grant delete on mydb1.emp  to qianfeng@'127.0.0.1';
> -- 刷新权限
> flush privileges;
> 
> -- 撤销权限
> revoke update on mydb1.emp from  qianfeng@'127.0.0.1';
> -- 刷新权限
> flush privileges;
> ```

### 2.数据库的备份和恢复【重点掌握】

> 备份：生成SQL脚本，导出数据
>
> 恢复：将磁盘中sql脚本恢复到数据库中
>
> ​	在控制台使用mysqldump命令可以用来生成指定数据库的脚本文本，但要注意，脚本文本中只包含数据库的内容，而不会存在创建数据库的语句，所以在恢复数据时，还需要自己手动创建一个数据库之后再去恢复数据
>
> 注意：
>
> ​	在windows上，通过windows+r,输入cmd,然后执行命令
>
> ​	在mac上，直接打开终端，然后执行命令
>
> ```
> 补充命令：
> 	windows:	
> 		dir:列出当前路径下所有的内容
> 		cd xxx:切换工作路径，可以使用相对路径，也可以使用绝对路径
> 		cd  ..:回退到上一级目录
> 		d:   切换到d盘
> 		e:	 切换到e盘
> 	Mac:
> 		ls:列出当前路径下所有的内容
> 		cd xxx:切换工作路径，可以使用相对路径，也可以使用绝对路径
> 		cd..:回退到上一级目录
> ```
>
> ```
> 1.备份和还原数据库
> 	备份数据库指的是将服务器里面的数据库备份成一个.sql文件，还原数据库指的是将.sql文件再还原到数据库
> 
> 	备份：mysqldump -u用户名  -p   --databases 数据库名称 > 备份路径
> 	还原：mysql -u用户名 -p  < 还原路径 
> 
> 说明：
> 	windows中：
> 		mysqldump -uroot -p --databases t01 > t01.sql   相对路径
> 		mysqldump -uroot -p --databases t01 > C:\user\xxx\Downloads\t01.sql   绝对路径
> ```
>
> ```
> 2.备份和还原数据库中的表
> 	备份：mysqldump  -u用户名  -p  数据库名称  表名称  > 备份路径 
> 	还原：mysql  -u用户名  -p  要还原到的数据库名称  < 还原路径 
> 注意：数据库的备份和还原都需要先登录数据库，否则无法操作
> ```
>

> 演示命令：
>
> ```sql
> C:\Users\19621>dir
>  驱动器 C 中的卷是 Windows
>  卷的序列号是 1EFC-F824
> 
>  C:\Users\19621 的目录
> 
> 2024  00:35    <DIR>          .
> 2023  20:17    <DIR>          ..
> 2023  21:22    <DIR>          .astropy
> 2023  20:38    <DIR>          .cache
> 2023  21:45    <DIR>          .conda
> 2024  16:45    <DIR>          .ipython
> 2024  16:45    <DIR>          .jupyter
> 2023  21:29    <DIR>          .matplotlib
> 2023  19:45                50 .python_history
> 2023  20:20    <DIR>          Contacts
> 2023  20:53    <DIR>          Desktop
> 2023  09:52    <DIR>          Documents
> 2024  19:12    <DIR>          Downloads
> 2023  20:20    <DIR>          Favorites
> 2023  20:20    <DIR>          Links
> 2023  20:20    <DIR>          Music
> 2023  21:48    <DIR>          OneDrive
> 2023  10:15    <DIR>          Pictures
> 2023  19:42    <DIR>          PycharmProjects
> 2023  20:20    <DIR>          Saved Games
> 2023  20:20    <DIR>          Searches
> 2023  20:20    <DIR>          Videos
> 2024  19:08    <DIR>          WPS Cloud Files
>                1 个文件             50 字节
>               22 个目录 179,312,119,808 可用字节
> 
> C:\Users\19621>cd Desktop
> 
> C:\Users\19621\Desktop>dir
>  驱动器 C 中的卷是 Windows
>  卷的序列号是 1EFC-F824
> 
>  C:\Users\19621\Desktop 的目录
> 
> 2023  20:53    <DIR>          .
> 2024  00:35    <DIR>          ..
> 2023  20:53        26,552,298 线上数据分析开班典礼2-常用.pptx
>                1 个文件     26,552,298 字节
>                2 个目录 179,312,115,712 可用字节
> 
> C:\Users\19621\Desktop>cd C:\Users\19621\Desktop
> 
> C:\Users\19621\Desktop>cd ..
> 
> C:\Users\19621>d:
> 
> D:\>dir
>  驱动器 D 中的卷是 Windows
>  卷的序列号是 14AE-043C
> 
>  D:\ 的目录
> 
> 2024  17:20    <DIR>          BaiduNetdiskDownload
> 2024  19:36    <DIR>          Desktop
> 2024  21:58    <DIR>          Downloads
> 2023  07:02    <DIR>          Program Files (x86)
> 2023  20:00    <DIR>          software
> 2023  22:35    <DIR>          yangyang
>                0 个文件              0 字节
>                6 个目录 230,220,656,640 可用字节
> 
> D:\>cd Desktop
> 
> D:\Desktop>dir
>  驱动器 D 中的卷是 Windows
>  卷的序列号是 14AE-043C
> 
>  D:\Desktop 的目录
> 
> 2024  19:36    <DIR>          .
> 2023  14:58         7,204,052 2023【线上班】Python数据分析课程大纲.pdf
> 
> -- 备份数据库【相对路径】
> D:\Desktop>mysqldump -uroot -p --databases mydb1 > t01.sql
> Enter password: ******
> 
> -- 恢复数据库【相对路径】
> D:\Desktop>mysql -uroot -p < t01.sql
> Enter password: ******
> 
> C:\Users\19621>d:
> 
> -- 备份数据表【绝对路径】
> D:\>mysqldump -uroot -p mydb1 emp  > d:\Desktop\coding\MySQL数据库\DB-Day9\DB-Day9-Code\emp.sql
> Enter password: ******
> 
> -- 恢复数据表【绝对路径】
> D:\>mysql -uroot -p mydb1 < d:\Desktop\coding\MySQL数据库\DB-Day9\DB-Day9-Code\emp.sql
> Enter password: ******
> ```

### 3.数据库的事务

> MySQL 事务主要用于处理操作量大，复杂度高的数据。比如说，在人员管理系统中，你删除一个人员，你即需要删除人员的基本资料，也要删除和该人员相关的信息，如信箱，文章等等，这样，这些数据库操作语句就构成一个事务！
>
> 事务： 处理某一件事件或功能的过程，在MySQL中处理事件的过程中，单独提供某一通道（Channel）,在事件处理之前可以开启事件点，处理完成后，在结束时关闭事件点。在关闭事件之前，可以回滚到事件起点。
>
> 注意事项：
>
> - 在 MySQL 中只有使用了 Innodb 数据库引擎的数据库或表才支持事务。
> - 事务处理可以用来维护数据库的完整性，保证成批的 SQL 语句要么全部执行，要么全部不执行。
> - 事务用来管理 insert,update,delete 语句

> ```
> 【重要,面试题】事务的四个特征ACID
> 	原子性(Atomicity) - 不可分割性
> 		事务中的操作要么全部完成， 要么就是全部不完成， 不会卡在中间一个点
> 			转账  A -- 减少金额  B --- 增加金额
> 	一致性(Consistency ) -- 事务开启之前和事务结束之后， 数据库的完整性没有被破坏
> 		输出的资料和输入的资料是对等的
> 	隔离性(Isolation) --- 事务和事务之间是相互隔离的 互不干扰的
> 	持久性(Durability) --- 事务结束之后 对数据库的修改是永久的
> 
> 注意：需要手动设置事务时，进行多个操作形成的事务的时候 需要开启事务， 否则会默认把每个操作都当做一个事务的
> ```

> 一般分为隐式事务和显式事务
>
> 隐式事务：没有明显的事务开始和结束的标记，语句执行后会自动提交结果并结束事务。 比如: insert/delete/update
>
> 显式事务： 具有明显的事务开始与结束的标记；使用场景一般是将多条sql语句组成一个逻辑完成的单元；
>
> 显式相关指令：
>
> ```mysql
> -- 开启事务
> begin;  或者 start transaction;
> 
> -- 结束事务
> -- 1. 结束事务 提交结果
> commit;
> 
> -- 2. 结束事务 把数据回滚到事务开启之前[执行操作出现问题]
> rollback;
> ```
>

> ```mysql
> -- 需求：张三给李四转账
> -- 逻辑操作1：更新张三的账户，减少 update
> -- 逻辑操作2：更新李四的账户，增加  update
> 
> use mydb1;
> 
> create table tb_account(
> aid int comment '用户id',
> uname varchar(20) comment '账户名',
> money  double comment '余额'
> );
> insert into tb_account values(1,'张三',10000),(2,'李四',800);
> select * from tb_account;
> 
> -- 隐式事务
> -- update tb_account set money=money+100 where aid=1;
> -- delete from tb_accout;
> 
> -- 显式事务
> -- 1.正常完成操作，提交事务
> begin;
> update tb_account set money=money-1000 where aid=1;
> select * from tb_account;
> update tb_account set money=money+1000 where aid=2;
> select * from tb_account;
> -- 同步数据，需要结束事务，并把结果提交
> commit;   -- 9000   1800
> 
> -- 2.未正常完成操作，回滚事务
> begin;
> update tb_account set money=money-1000 where aid=1;
> select * from tb_account;
> update tb_account set money=money+1000 where aid=2;
> select * from tb_account;
> -- 同步数据，需要结束事务，需要回滚数据
> rollback;  -- 10000 800
> 
> ```

> 总结：
>
> ```
> 【面试题】mysql事务处理的注意事项:	
> 	a.关键字commit和rollback主要用于mysql的事务,主要针对的是DML[update,insert,delete]
> 	b.当一个事务成功之后,commit发出的命令涉及到的工作表都会生效
> 	c.如果发生故障,rollback命名发出之后,事务中涉及到的工作表都会恢复到最初的状态
> 	d.如果不手动begin,则事务的开启和提交是自动完成的
> 	e.如果手动begin,则commit或者rollback需要手动完成
> 	f.不管commit还是rollback,针对的是begin之后所有的操作
> 	g.@@autocommit的值为1，则表示自动开启和关闭事务，如果将@@autocommit的值设置为0，则需要手动开启和关闭事务
> ```

### 4.索引

> 作用：提高查询效率的。
>
> 创建表的时候 ，给字段添加主键约束/外键约束/唯一约束的时候，被约束的字段就会形成索引键。 查看表中有哪些字段是索引`show index from 表名;`
>
> 索引键在存储的时候采用的是B+树，查询的时候应用的是`二分法查找`，查找方式:
>
> ```
> 前提： 数据是排好序的 [升序或者降序  以升序为例  数据是从小到大的]
> 1. 设定查找范围  范围是通过下标来定义的  [0,长度-1]
> 2. 找到范围的中间位置mid，将该位置的元素与待查找的元素 进行对比
> 3. 对比的结果
> 	1. 相等 --- 我们找到了
> 	2. 中间位置对应的元素 > 待查找的元素  缩小查找范围 [0, mid]
> 	3. 中间位置的元素 < 待查找的元素  缩小范围 [mid, 长度-1]
> 4. 在新的范围中，定位该范围的中间位置，将该位置的元素与待查找的元素，进行对比
> 5. 依次类推，直到计算完毕
> 
> 扩展作业：Python实现二分法查找
> ```
>
> 查看语句的执行计划，可以看出语句的执行效率的问题
>
> ```sql
> explain sql语句;
> ```
>
> 查找的时候，会经常使用到的字段，但是这些字段没有主键约束/外键约束/唯一约束; 可以后期将其设置为索引键， 以提高查询效率
>
> ```sql
> -- 将字段设置为索引 
> create index idx_索引名 on 表名(字段名);
> ```
>
> 前缀索引 
>
> ```sql
> create index idx_索引名 on 表名(字段名(索引));  -- 文本索引是从1开始的
> ```
>
> 删除索引
>
> ```
> drop index 索引名 on 表名;
> ```
>

> ```mysql
> use stu_sco_cou_db;
> 
> show index from tb_student;
> 
> -- 通过主键查找【主键：索引键】
> explain select * from tb_student where stu_id=1007;  -- row:1
> 
> -- 通过普通键查找
> explain select * from tb_student where stu_name ='张小六'; -- rows:12
> 
> -- 为了提高查找效率，尽量使用索引键进行查找
> -- 很多时候用到的键不是索引键，可以后期将其设置为索引键
> create index idx_name on tb_student(stu_name);
> show index from tb_student;
> 
> -- 再去查看建立索引之后的执行计划
> explain select * from tb_student where stu_name ='张小六'; -- rows:1
> 
> /*
> 类比：索引相当于书籍的目录，把索引键的值存储于内存中，从内存中找数据的效率就高
> */
> 
> -- 前面的操作给姓名字段添加索引，相当于把每个姓名都存储在内存中
> -- 最优解法：可以考虑将姓氏存储于内存中，这种索引称为前缀索引
> 
> -- 删除原有索引
> drop index idx_name on tb_student;
> 
> -- 通过形式创建索引
> create index idx_name on tb_student(stu_name(1)); -- 文本从1开始
> explain select * from tb_student where stu_name ='张小六';
> 
> ```

> 【面试题】
>
> 优点：
>
> - 可以大大提高MySQL的检索速度
> - 唯一索引可以保证数据的唯一性
> - 可以降低分组，排序的时间
> - 可以使用查询优化器提高系统性能
>
> 缺点：
>
> - 建立索引会建立对应的索引文件，会占用大量的磁盘空间
> - 会降低表的更新速度，因为更新表，MySQL不仅要更新数据，还要更新索引
> - 会降低增加和删除的速率
>
> 不建议建立索引的情况：
>
> - 频繁更新的字段不要建立索引
> - 没出现 where，having，order by 不要建立索引
> - 数据量少的表没必要建立索引
> - 唯一性比较差的字段不要建立索引
>
> 【面试题】如果想让MySQL数据库更加优化，该怎么做
>
> - 如果查询次数较多，则建立索引
> - 添加约束，如主外键约束,非空约束,唯一约束
> - 尽量避免书写较为复杂的sql语句，目的是为了提高sql语句的可读性
> - 可以考虑将字段较多的表分解为多张表

### 5.视图

> with 将查询语句的结果制作成一个临时表，查询完成之后 表被销毁了；view视图的作用类似于with, 区别与with的是视图是永久的
>
> 作用：
>
> 1. 对查询结果做个快照，对查询的数据做个保存
>
> 2. 控制其他用户访问列的权限
>
>    例如：人力部门会查看考勤  需要有一张表存储员工的信息
>
>    员工的信息中 编号 姓名 手机号 考勤  薪资信息
>
>    但是公司中员工之间薪资信息是保密
>
> with语句作用是将查询结果制作成临时表
>
> 视图类似于with语句，但是视图是永久的
>
> ```mysql
> -- 创建视图
> create view v_视图名 as select查询语句;
> 
> -- 修改视图对应的查询结果
> alter view v_视图名 as 新的select查询语句;
> 
> -- 删除视图
> drop view v_视图名;
> ```

> ```mysql
> 
> -- with 将查询语句的结果制作成一个临时表，查询完成之后 表被销毁了
> with avg_score as (select course_id,avg(score) avgs from tb_score group by course_id)
> select * from tb_student join tb_score join avg_score
> on tb_student.stu_id=tb_score.stu_id and tb_score.course_id=avg_score.course_id
> where score<avgs;
> 
> -- 报错：不存在
> -- select * from avg_score;
> 
> -- 可以把查询的结果设置为视图。可以反复使用
> -- 视图相当于是原表的快捷方式【快照】，如果表中的数据发生更高，视图也会随着更改
> create view v_avgs_score as (select course_id,avg(score) avgs from tb_score group by course_id);
> 
> -- 查询视图
> select * from v_avgs_score;
> select * from v_avgs_score where avgs<70;
> 
> -- 使用场景：把公开的数据制作为视图
> create view v_stu as (select stu_id,stu_name from tb_student);
> select * from v_stu;
> 
> -- 允许其他用户访问
> grant select on stu_sco_cou_db.v_stu to qianfeng@'127.0.0.1';
> 
> ```