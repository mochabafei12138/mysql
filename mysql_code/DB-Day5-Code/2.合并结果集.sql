create table a(
sname varchar(20),
num int
);
create table b(
sname varchar(20),
num int
);

insert into a values('a',10),('b',20),('c',30);
insert into b values('a',10),('b',40),('c',30);

-- 单独查询
select * from a;
select * from b;

-- 合并结果集
-- union:去除重复记录
select * from a
union
select * from b;

-- union all:不去除重复记录
select * from a
union all
select * from b;

-- 问题：参与合并结果集的表，查询的结果中字段的数量必须保持一致
create table c(
sname varchar(20),
num int,
score int
);
insert into c values('a',10,34),('b',20,54),('c',30,56);

-- 错误sql：a和c查询之后的字段数量不一致
select * from a
union all
select * from c;

-- 正确sql
select * from a
union all
select sname,num from c;
