use mydb1;

-- DML:数据表的增删改的操作
-- 建表
-- 创建表的时候，不严谨写法如下：
create table a1(
sid int,
name varchar(10),
score int
);

-- 问题1：自定义的字段和关键字重名
-- 解决方案：创建表的时候，为了避免自定义的表名，字段名和系统的关键字重名，则可以通过反引号区分【反引号和波浪线是同一个键】
-- 下面是严谨的写法
create table `b1`(
`sid` int,
`name` varchar(10),
`score` int
);

-- 注意：每条sql语句的后面最好【一定】加分号

-- 问题2：对于陌生的表，不知道字段的含义，则无法确定其中的业务逻辑
-- 解决方案：给表或字段添加注释，注释只是一个普通的字符串，直接添加普通引号即可
create table `student`(
`sid` int comment '学号',
`name` varchar(20) comment '姓名',
`score` int comment '成绩',
`age` int comment '年龄'
)engine=InnoDB comment '学生表';
-- engine=InnoDB是MySQL默认的驱动

# insert:向指定表中插入数据
select * from student;

-- a.给所有字段插入单条数据,注意：默认给所有字段插入数据，值的个数和字段的个数一定要完全匹配
-- insert into student value (1001,'aaa');  -- 错误写法
-- 添加注释的快捷键：选中-----》ctrl + /
insert into student value (1001,'aaa',100,10);

-- b.给指定字段插入单条数据，注意：未指定的字段根据建表的设定会插入空值
insert into student (sid,name) value (1002,'bbb');

-- c.给所有字段插入多条数据
insert into student value(1004,'faf',89,9),(1006,'zzz',66,11),(1003,'xiaoming',90,12),(1005,'zhangsan',77,8);

-- d.给指定字段插入多条数据
insert into student (sid,name) value (1007,'wangwu'),(1009,'kjs'),(1010,'fahf'),(1012,'jack');
insert into student (sid,name,age) value (1007,'yuw',12),(1009,'cnhf',8),(1010,'lks',9),(1012,'tom',10);

-- 注意：1.值不要超出列定义的长度  2.如果要插入空值，使用null,默认情况下，没有传值也是null
-- 3.插入日期类型的时候，和字符串的用法一样，也是用引号表示

