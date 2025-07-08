-- 1.sql函数的返回值有且只能有一个
-- 需求：返回按照生日排名第n的学生学号

-- 排名第1的学生学号
select *,row_number() over(order by birth) rk from tb_student where birth is not null;

with t as (select *,row_number() over(order by birth) rk from tb_student where birth is not null)
select stu_id from t where rk=1;

delimiter $$
create function get_sid(n int) returns int
begin
	declare sid int;  -- 声明一个变量，用于接受查询到的学生的学号
    with t as (select *,row_number() over(order by birth) rk from tb_student where birth is not null)
	select stu_id into sid from t where rk=n;
    return sid;
end $$
delimiter ;
select get_sid(7) res;

-- 2.函数只能返回一个值，如果要多个值同时返回，处理方案：拼接
-- a.同一条数据的多个字段值拼接，用concat_ws()
-- 需求：获取第n名学生的学号和姓名

-- 注意：声明的类型和实际的数据类型要保持一致
delimiter $$
create function get_info(n int) returns varchar(20)
begin
	declare info varchar(20);  
    with t as (select *,row_number() over(order by birth) rk from tb_student where birth is not null)
	select concat_ws('-',stu_id,stu_name) into info from t where rk=n;
    return info;
end $$
delimiter ;
select get_info(7) res;

-- b.多条数据的同一个字段值拼接，用group_concat()
-- 需求：返回前n名的学生学号
delimiter $$
create function get_rk(n int) returns varchar(20)
begin
	declare info varchar(20);  
    with t as (select *,row_number() over(order by birth) rk from tb_student where birth is not null)
	select group_concat(stu_id) into info from t where rk<=n;
    return info;
end $$
delimiter ;
select get_rk(4) res;
