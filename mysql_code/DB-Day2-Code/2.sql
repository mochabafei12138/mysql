-- delete和update
-- DDL:drop   alter，主要针对数据库或数据表操作
-- DML:delete  update,主要针对数据/记录进行操作

select  * from student;

-- 1
-- a.删除所有记录
-- 默认情况下，打开了安全模式，无法直接删除表中所有记录，必须有where子句
delete from student;

-- b.删除指定条件的数据
delete from student where age is null;

-- 2.
-- 修改所有记录
update student set age=10;
-- 修改指定条件的数据
update student set age=10 where age is null;


-- 注意：使用drop,delete,update关键字的时候，一定要非常谨慎