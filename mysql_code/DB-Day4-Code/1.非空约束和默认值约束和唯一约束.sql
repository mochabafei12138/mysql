use mydb1;

-- 非空约束
-- 1.
create table stu11(
sid int not null comment '学号',
sname varchar(20) not null comment '姓名'
);
desc stu11;
-- insert into stu11 (sid) value(1001); -- 报错
-- insert into stu11 value (null,null);  -- 报错

-- 2.
create table stu12(
sid int comment '学号',
sname varchar(20) comment '姓名'
);
desc stu12;
insert into stu12 (sid) value(1001);
insert into stu12 value (null,null); 

-- 问题：如果表已经存在，且表中的指定字段已经存在空值null，给字段添加非空约束不会成功
alter table stu12 modify sid int not null;

-- 解决方案：先处理掉表中已经存在的null值
update stu12 set sid=1002 where sid is null; 
select * from stu12;

-- 3.删除
alter table stu12 modify sid int;

-- 默认值约束
-- 1.
create table stu21(
sid int not null comment '学号',
sname varchar(20) comment '姓名',
address varchar(50) default '北京' comment '家庭住址'
);
desc stu21;
insert into stu21 (sid) value(1001);
insert into stu21  value(1002,'aaa','上海');
select * from stu21;

-- 2.not null和default可以同时添加给同一个字段
create table stu22(
sid int not null comment '学号',
sname varchar(20) comment '姓名',
address varchar(50) not null default '北京' comment '家庭住址'
);
desc stu22;

-- 唯一约束
-- 唯一约束和非空约束的用法非常相似
-- 1
-- 注意：一般用于确保在非主键列中输入不重复的值
create table stu31(
sid int not null comment '学号',
sname varchar(20) comment '姓名',
card_id varchar(18) comment '身份证号' unique
);
desc stu31;
insert into stu31 value (1001,'aaa','23456789');
-- insert into stu31 value (1002,'bbb','23456789');  -- 报错，Duplicate:重复
-- 注意：unique只针对非空值做出检测，可以插入多次null
insert into stu31  value (1001,'aaa',null);
insert into stu31  value (1001,'aaa',null);
select * from stu31;

-- 2
create table stu32(
sid int not null comment '学号',
sname varchar(20) comment '姓名',
card_id varchar(18) comment '身份证号'
);
desc stu32;
alter table stu32 modify card_id varchar(18) unique;

-- 3
-- 注意：后期手动修改字段的约束为unique，再次取消，取消不了，插入数据依然会检测到
alter table stu32 modify card_id varchar(18);
insert into stu32 value (1001,'aaa','23456789');
-- insert into stu32 value (1001,'aaa','23456789');  -- 报错，Duplicate:重复

-- 注意：唯一约束一般给添加给值肯定唯一的字段，比如：身份证号，手机号，银行卡号等

-- 注意：在确定创建表之前，字段的默认值或是否唯一一般就要确定好，在建表的过程中就可以直接添加



