use stu_sco_cou_db;
select * from tb_student;

/*
mysql8.0之后，默认情况下，mysql不信任自定义的函数，信任的安全等级较低
在定义函数之前，提高自定义函数的信任度
*/
set global log_bin_trust_function_creators=1;

-- 1.函数基本的定义和调用
-- 需求：获取学生的年龄

-- 修改sql结束的符号为$$
-- 函数体【实现的具体需求】
-- 注意：函数体中每条语句的结尾需要添加分号
delimiter $$
create function get_age1(birth date) returns int
begin
    return timestampdiff(year,birth,curdate());
end $$
delimiter ;

-- 获取学生的年龄
delimiter $$
create function get_age(bitrh date) returns int
begin 
	return timestampdiff(year, bitrh,curdate());
end $$
delimiter ;

-- 注意：mysql中的函数必须设置返回值，调用函数必须结合select查看结果


-- 2.带有分支结构的函数
-- 需求：创建一个判断成年或未成年的函数


