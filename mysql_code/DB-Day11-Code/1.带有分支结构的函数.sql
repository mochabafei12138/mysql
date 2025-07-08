use stu_sco_cou_db;
select * from tb_student;

/*
mysql8.0之后，默认情况下，mysql不信任自定义的函数，信任的安全等级较低
在定义函数之前，提高自定义函数的信任度
*/
set global log_bin_trust_function_creators=1;

-- 1.函数基本的定义和调用
-- 需求：获取学生的年龄

/*
注意：
	1.因为定义函数的过程中，每条语句的后面需要添加分号，但是分号又是sql语句结束的标记
    2.自定义函数之前，一般都会将结束符修改为$$
    3.begin和end之间的内容是函数体【实现的具体需求】
	4.函数体中每条语句的结尾需要添加分号
    5.当函数定义完毕之后，修改sql结束的符号为分号
    6.自定义函数的过程中，尽量不要在sql之间添加注释，有可能会识别不到
*/
delimiter $$
create function get_age(birth date) returns int
begin
    return timestampdiff(year,birth,curdate());
end $$
delimiter ;

-- 注意：mysql中的函数必须设置返回值，调用函数必须结合select查看结果
select *,get_age(birth) age from tb_student;

-- 2.带有分支结构的函数
-- 双分支
-- 需求：创建一个判断成年或未成年的函数
delimiter $$
create function is_adult(age int) returns varchar(10)
begin
	if age>= 18 then return '成年';
    else return '未成年';
    end if;
end $$
delimiter ;
select is_adult(10) res;
select *,is_adult(age) is_a from (select *,timestampdiff(year,birth,curdate()) age from tb_student) new_stu;

-- 多分支
-- 需求：判断某个月份属于哪个季度
delimiter $$
create function get_quarter(monthly int) returns varchar(20)
begin
	if monthly>=1 and monthly<=3 then return '第一季度';
    elseif monthly>=4 and monthly<=6 then return '第二季度';
    elseif monthly>=7 and monthly<=9 then return '第三季度';
    else return '第四季度';
    end if;
end $$
delimiter ;
select get_quarter(8) res;
select birth,get_quarter(month(birth)) res from tb_student;


