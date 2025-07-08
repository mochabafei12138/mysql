use stu_sco_cou_db;

/*
注意：
	a.返回值不是通过returns体现的，是通过参数体现的
    b.参数的类型
		in    输入
        out		输出
        inout 输入也输出
        
		in和out都是参数的修饰符，in表示传递进来的参数，out表示需要输出的参数
*/
-- 1.获取指定学生的最高分/最低分/总成绩
delimiter $$
create procedure get_score(sid int)
begin
	select stu_id,max(score) maxs,min(score) mins,sum(score) sums 
    from tb_score where stu_id=sid;
end $$
delimiter ;

-- 调用存储过程
call get_score(1000);

-- 2.将数据传递出出来，使用select展示
delimiter $$
create procedure get_num(inout sid int,
		out max_score float,
        out min_score float,
        out sum_score float)
begin
	select stu_id,max(score) maxs,min(score) mins,sum(score) sums 
    into sid,max_score,min_score,sum_score
    from tb_score where stu_id=sid;
end $$
delimiter ;

-- out标记的参数，没有办法直接交给select展示
-- 想要交给select，需要将其交给变量接收出来
-- 定义变量，变量名必须以@开头
set @maxs := 0;
set @mins := 0;
set @sums := 0;
set @sid := 1000;
-- 调用存储过程
call get_num(@sid,@maxs,@mins,@sums);
-- 通过select展示
select @sid,@maxs,@mins,@sums;

