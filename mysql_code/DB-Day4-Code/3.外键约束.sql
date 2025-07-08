-- 外键约束
-- 1
-- 注意1：外键约束至少发生在两张表之间
-- 注意2：需要给a表的某个字段设置主键，给b表中和a表中有关系的字段设置为外键
-- 比如：student 和 score关系中，在student表中取出一个sid,在score中可能对应这多条数据
-- student:一   score:多，给student表中的sid设置为主键，给score表中sid设置为外键
create table stu51(
sid int primary key auto_increment comment '学号',
sname varchar(20) comment '姓名',
age int comment '年龄'
)auto_increment=1001 comment '学生表';
desc stu51;

create table sco51(
sid int comment '学号',
cno int comment '课程号',
score int comment '成绩',
-- 添加外键：当前表中的sid和stu51表中的sid对应起来
-- stu_sco_51_sid是外键的名称，可以自定义，但是在同一个数据库中不要重复，建议命名：表1_表2_字段
constraint stu_sco_51_sid  foreign key(sid) references stu51(sid)
);
desc sco51;

-- 2
create table stu52(
sid int  comment '学号',
sname varchar(20) comment '姓名',
age int comment '年龄'
) comment '学生表';

create table sco52(
sid int comment '学号',
cno int comment '课程号',
score int comment '成绩'
)comment '成绩表';
-- 添加主键
alter table stu52 modify sid int primary key;
-- 添加外键
alter table sco52 add constraint stu_sco_52_sid foreign key(sid) references stu52(sid);
desc stu52;
desc sco52;

-- 3
-- 注意：一张表中只能有一个主键，但是一张表中可以有多个外键，此时至少需要三张表
create table stu53(
sid int primary key  comment '学号',
sname varchar(20) comment '姓名',
age int comment '年龄'
) comment '学生表';

create table cou53(
cno int primary key comment '课程号',
cname varchar(30) comment '课程名称'
) comment '课程表';

-- 中间表
create table sco53(
sid int comment '学号',
cno int comment '课程号',
score int comment '成绩',
constraint stu_sco_53_sid foreign key(sid) references stu53(sid),
constraint cou_sco_53_cno foreign key(cno) references cou53(cno)
)comment '成绩表';
desc stu53;
desc cou53;
desc sco53;

-- 4
create table stu54(
sid int  comment '学号',
sname varchar(20) comment '姓名',
age int comment '年龄'
) comment '学生表';

create table cou54(
cno int comment '课程号',
cname varchar(30) comment '课程名称'
) comment '课程表';

-- 中间表
create table sco54(
sid int comment '学号',
cno int comment '课程号',
score int comment '成绩'
)comment '成绩表';
-- 添加主键
alter table stu54 modify sid int primary key;
alter table cou54 modify cno int primary key;
-- 添加外键
alter table sco54 add constraint stu_sco_54_sid foreign key(sid) references stu54(sid);
alter table sco54 add constraint cou_sco_54_cno foreign key(cno) references cou54(cno);

desc stu54;
desc cou54;
desc sco54;

-- 5.删除外键
-- 注意：删除外键的时候，需要指明外键的名称，另外，删除之后，desc查看的结果中，MUL标记依然存在
alter table sco54 drop foreign key cou_sco_54_cno;

-- 注意：在有主外键关联的情况下，直接删除主键,无法删除，如果非要删除，则需要先解除外键关联
alter table sco54 drop foreign key stu_sco_54_sid;
alter table stu54 drop primary key;

