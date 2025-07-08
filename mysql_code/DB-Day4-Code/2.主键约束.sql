-- 主键约束
-- 1
create table stu41(
sid int primary key comment '学号',
sname varchar(20) comment '姓名'
);
desc stu41;
insert into stu41 value(1,'aff');
-- insert into stu41 (sname) value('aff');  -- 报错

-- 2
create table stu42(
sid int comment '学号',
sname varchar(20) comment '姓名'
);
desc stu42;
alter table stu42 modify sid int primary key;

-- 3.删除
-- 注意1：因为主键非空且唯一，所以删除的时候可以直接drop primary key
-- 注意2：当删除主键之后，非空约束还存在，如果需要插入null,则可以手动删除非空约束
alter table stu42 drop primary key; -- 删除主键约束
alter table stu42 modify sid int;  -- 删除非空约束

-- 4.主键自增长
-- 1
create table stu43(
sid int primary key auto_increment comment '学号',
sname varchar(20) comment '姓名'
);
desc stu43;
insert into stu43 value(3,'aaaa');
insert into  stu43 (sname) value('bbb');
insert into  stu43 (sname) value('ccc');
insert into  stu43 (sname) value('eee');
insert into  stu43 (sname) value('ddd');
select * from stu43;

-- 如果删除之前增长的序号，后面再添加的时候序号不会重新开始，而是接着被删除的那一列的序号
delete from stu43 where sid=7;  -- 删除7
insert into  stu43 (sname) value('uuu'); -- 再插入数据，并不是7.是8

-- 2
create table stu44(
sid int primary key comment '学号',
sname varchar(20) comment '姓名'
);
alter table stu44 modify sid int auto_increment;
desc stu44;

-- 3
-- 建表的时候，可以设置第一条数据的主键值
create table stu45(
sid int primary key auto_increment comment '学号',
sname varchar(20) comment '姓名'
)engine=InnoDB auto_increment=6 comment '学生表';   -- sid的初始值为6
-- 在上述表的基础上，插入数据的时候，就可以不用插入sid的值
-- insert into stu45 value('aaaa');   -- 报错，不匹配
insert into stu45 (sname) value('aaaa');
insert into stu45 (sname) value('ddd');
insert into stu45 (sname) value('bbb');
select * from stu45;

-- 注意：会员号，学号，工号，会员卡号等表示非空且唯一，而且在表中用来作为标识的数据，就可以设置为主键
-- 根据使用的情况，如果主键为数字类型，则可以设置主键自增长





