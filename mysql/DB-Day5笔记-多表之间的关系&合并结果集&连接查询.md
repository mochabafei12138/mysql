### 一、多表之间关系的确定和建立【重点掌握】

#### 1.表与表之间的关系

> 1. 一对一：在a表中找到一条记录，在b表中也可以匹配到一条记录，如：人和身份证号  ，公司和注册地址
> 2. ![一对一](DB-Day5-images\一对一.png)
> 3. 一对多：在a表中找到一条记录，在b表中可能会匹配到多条记录，比如：部门和员工，商品和分类
> 4. ![一对多](DB-Day5-images\一对多.png)
> 5. 多对多：在a表中找到一条记录,在b表中可能会匹配到多条记录;在b表中找到一条记录,在a表中可能会匹配到多条记录,比如：学生和课程，学生和老师
> 6. ![多对多](DB-Day5-images\多对多.png)

#### 2.多表关系的实现【重点掌握】

> 说明：
>
> ​	一对一：在任何一方添加外键，指向另一方的主键
>
> ​	一对多：在多的一方添加外键，指向另一张表的主键
>
> ​	多对多：
>
> ​		需要借助于第三张表【中间表】
>
> ​		中间表至少包含两个字段，将这两个字段设置为外键，分别指向两张主表的主键
>
> ```mysql
> use mydb1;
> -- 1.一对一关系
> -- 用户和某电商平台的购物车之间的关系
> -- 用户表：一
> create table `tb_person`(
> `pno` int comment '用户编号',
> `pname` varchar(20) not null comment '用户名',
> `birth` date not null comment '生日',
> primary key(`pno`)
> );
> 
> -- 购物车表：一
> create table `tb_shopcar`(
> `pno` int comment '用户编号',
> `car_id` int comment '购物车编号',
> constraint fk_per_car foreign key(`pno`) references tb_person(`pno`)
> );
> 
> -- 2.一对多关系
> -- 员工和部门之间的关系
> -- 部门表：一
> create table `dept`(
> `deptno` int comment '部门编号',
> `deptname` varchar(20) comment '部门名称',
> `address` varchar(10) comment '地址',
> primary key(`deptno`)
> );
> 
> -- 员工表：多
> create table `emplyee`(
> `eno` int comment '工号',
> `ename` varchar(20)  comment '员工姓名',
> `deptno` int comment '部门编号',
> constraint fk_emp_dept foreign key(`deptno`) references dept(`deptno`)
> );
> 
> -- 3.多对多的关系
> -- 用户和共享单车之间
> -- 图书馆中用户和图书的关系
> -- 用户表
> create table `user`(
> `uid` int comment '用户编号',
> `uname` varchar(20) comment '用户名称',
> `ulevel` int comment '用户等级',
> primary key(`uid`)
> );
> 
> -- 共享单车表
> create table `bike`(
> `bid` int comment '单车编号',
> `in_use` boolean comment '使用状态',
> `kind` int comment '单车类型',
> primary key(`bid`)
> );
> 
> -- 中间表：使用记录表
> create table `record`(
> `rid` int comment '流水号',
> `uid` int comment '用户编号',
> `bid` int comment '单车编号',
> `start_time` datetime comment '开始时间',
> `end_time` datetime comment '结束时间',
> `payway` varchar(10) comment '支付方式',
> `payment` int comment '支付金额',
> primary key(`rid`),
> constraint fk_rec_user foreign key(`uid`) references user(`uid`),
> constraint fk_rec_bike foreign key(`bid`) references bike(`bid`)
> );
> ```

### 二、合并结果集【掌握】

> 作用：合并结果集就是把两个select语句的查询结果合并到一起
>
> 合并结果集的两种方式：
>
> ​	union：去除重复记录
>
> ​	union all：不去除重复记录
>
> ```mysql
> create table a(
> sname varchar(20),
> num int
> );
> create table b(
> sname varchar(20),
> num int
> );
> 
> insert into a values('a',10),('b',20),('c',30);
> insert into b values('a',10),('b',40),('c',30);
> 
> -- 单独查询
> select * from a;
> select * from b;
> 
> -- 合并结果集
> -- union:去除重复记录
> select * from a
> union
> select * from b;
> 
> -- union all:不去除重复记录
> select * from a
> union all
> select * from b;
> 
> -- 问题：参与合并结果集的表，查询的结果中字段的数量必须保持一致
> create table c(
> sname varchar(20),
> num int,
> score int
> );
> insert into c values('a',10,34),('b',20,54),('c',30,56);
> 
> -- 错误sql：a和c查询之后的字段数量不一致
> select * from a
> union all
> select * from c;
> 
> -- 正确sql
> select * from a
> union all
> select sname,num from c;
> ```
>
> 总结：
>
> ​	a.如果两张表进行结果的合并，其中出现完全相同的记录，则使用union才会去除重复记录
>
> ​	b.如果两张表进行结果的合并，其中出现的记录中部分字段的值相同，则union和union all的结果是一致的，都是保留所有的数据
>
> ​	c.必须保证两张表中查询之后的结果有相同数量的字段

### 三、连接查询【重点掌握】

> 作用：求出多个表的乘积，例如t1连接t2，那么查询出的结果就是t1*t2

#### 1.内连接-[inner] join on

> 内连接的特点：查询结果必须满足条件
>
> ```mysql
> select * from student;
> select * from score;
> 
> select count(*) from student; -- 6
> select count(*) from score;  -- 12
> 
> -- 连接查询
> -- 问题：结果集中的数据是两张表中的乘积，该结果被称为笛卡尔积，其中包含无用的数据甚至错误的数据
> select * from student,score;
> select count(*) from student,score;   -- 72
> 
> -- 解决：需要去除无用的数据甚至错误的数据，可以根据条件进行筛选
> -- a.不规范的写法：表之间未建立主外键关系
> -- 注意1：在多张表中有相同的字段，则可以通过  表名.字段名  进行区分
> select * from student,score where student.sno=score.sno;
> -- 注意2：连接查询之后，如果有相同字段，则可以按照需求查询需要的字段即可
> select student.sno,sname,cno,degree from student,score where student.sno=score.sno;
> -- 注意3：在连接查询中，可以设置别名
> select s.sno,sname,cno,degree from student s,score c where s.sno=c.sno;
> select 
> 	s.sno 学号,
>     sname 姓名,
>     cno 课程号,
>     degree 分数
> from 
> 	student s,score c 
> where s.sno=c.sno;
> -- 上述几种写法就是连接查询，属于内连接，但它不是sql中标准的查询方式，可以理解为方言
> 
> -- b.规范写法：设置主外键关系
> -- 一对多【一：student,多：score】
> desc student;
> desc score;
> alter table student modify sno varchar(5) primary key;
> -- alter table student drop primary key;
> -- 注意：要建立连接的两个字段的数据类型需要保持一致，否则会报错21:16:06	alter table score add constraint fk_stu_sco foreign key(sno) references student(sno)	Error Code: 3780. Referencing column 'sno' and referenced column 'sno' in foreign key constraint 'fk_stu_sco' are incompatible.	0.000 sec
> -- incompatible:不相容，不兼容
> alter table score add constraint stu_sco_sno foreign key(sno) references student(sno);
> 
> -- 1.内连接:两张表中根据筛选条件获取到的公共数据
> select 
> 	s.sno 学号,
>     sname 姓名,
>     cno 课程号,
>     degree 分数
> from 
> 	student s inner join score c 
> on s.sno=c.sno;
> 
> select 
> 	s.sno 学号,
>     sname 姓名,
>     cno 课程号,
>     degree 分数
> from 
> 	student s join score c 
> on s.sno=c.sno;
> ```

#### 2.外连接

> 分类：
>
> 左外连接：left [outer] join on，左外连接是指定除内连接的数据之外，增加左边表中的其它的数据。即左表选择全部数据，右表选择交集（都存在的）的数据
>
> 右外连接：right [outer] join on，同左外连接相反，除内连接的数据之外，额外选择右表中的其它数据。
>
> 全外连接（MySQL不支持）：full join，将内连接、左外连接、右外连接的全部数据选择出来，可以尝试使用union的合并查询关键字，将左外和右外查询的结果合并到一块，union查询，要求两个查询的列名保持一致。对于重复的行会自动去重
>
> 特点：不管是左外连接还是右外连接，都是以其中一个表为参照连接另外一个表
>
> ```mysql
> -- 2.外连接
> select 
> 	s.sno 学号,
>     sname 姓名,
>     cno 课程号,
>     degree 分数
> from 
> 	student s left outer join score c    -- outer可以省略，此时左表是stdent,右表是score
> on s.sno=c.sno;
> 
> select 
> 	s.sno 学号,
>     sname 姓名,
>     cno 课程号,
>     degree 分数
> from 
> 	score c right  join student s    -- 此时左表是score,右表是student
> on s.sno=c.sno;
> 
> select 
> 	s.sno 学号,
>     sname 姓名,
>     cno 课程号,
>     degree 分数
> from 
> 	score c left  join student s    -- 此时左表是score,右表是student
> on s.sno=c.sno;
> ```

#### 3.自然连接-natural join

> 直接连接查询会产生无用笛卡尔积，通常使用主外键关系等式来去除它，而自然连接无需你给出主外键等式，它会自动找到这一等式,将两张连接的表中名称和类型完全一致的列作为条件，通过自然连接自动进行匹配
>
> ```mysql
> -- 3.自然连接:会自动找到两张表中的等价关系，进行自动的筛选
> -- 内连接的简化
> 
> -- 内连接
> select 
> 	s.sno 学号,
>     sname 姓名,
>     cno 课程号,
>     degree 分数
> from 
> 	student s inner join score c 
> on s.sno=c.sno;
> 
> -- 自然连接
> select 
> 	s.sno 学号,
>     sname 姓名,
>     cno 课程号,
>     degree 分数
> from 
> 	student s natural join score c; 
> ```