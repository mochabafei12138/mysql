-- 需求：求1~n之间所有整数的和
/*
注意：
	if-end if 
    while-end while
    repeat-end repeat
    loop-end loop
    
i = 1
total = 0
while i < 10:
	total += i
    i += 1

*/

-- a.while
delimiter $$
create function get_sum_while(n int) returns int
begin
	declare i int default 1; -- 定义变量i，默认初始值为1
    declare total int default 0; -- 定义变量total。默认初始值为0，记录和
    while i <= n do
		set total = total + i;
        set i = i + 1;
	end while;
    return total;
end $$
delimiter ;
select get_sum_while(100) res;

-- b.repeat
delimiter $$
create function get_sum_repeat(n int) returns int
begin
	declare i int default 1; -- 定义变量i，默认初始值为1
    declare total int default 0; -- 定义变量total。默认初始值为0，记录和
    repeat
		set total = total + i;
        set i = i + 1;
	until i > n end repeat;
    return total;
end $$
delimiter ;

-- 函数定义有误的话，删除函数
drop function get_sum_repeat;
select get_sum_repeat(100) res;

-- c.loop
delimiter $$
create function get_sum_loop(n int) returns int
begin
	declare i int default 1; -- 定义变量i，默认初始值为1
    declare total int default 0; -- 定义变量total。默认初始值为0，记录和
    A:loop
		set total = total + i;
        set i = i + 1;
		if i > n then leave A;
        end if;
	end loop;
    return total;
end $$
delimiter ;
select get_sum_loop(100) res;