-- 留存率问题
/*
留存：第一天登录的用户在第n天仍然登录的还有多少人
留存率：第一天登录的用户在第n天仍然登录的人数 / 第一天登录的人数

作用：检验用户对产品的粘性

关注的有：次日留存率  3日留存率   7日留存率

以次日留存率为例
思路：
	a.统计用户第一次登录的日期
    b.将这个日期与登录信息表进行连接，查找这个用户第二次登录的日期是否 是 第一次登录日期的第二天
    c.按照注册日期分组，，统计这天注册的人数， 以及第二天登录的人数
*/
-- with login_temp as (select uid,date(dt) login_dt from tb_login group by date(dt),uid)
-- select * from login_temp;

-- 统计用户第一次登录的日期
-- first_value
-- with login_temp as (select uid,date(dt) login_dt from tb_login group by date(dt),uid)
-- select distinct uid,first_value(login_dt) over(partition by uid order by login_dt) first_dt
-- from login_temp;

-- 获取第二天依然登录的用户
-- with login_temp as (select uid,date(dt) login_dt from tb_login group by date(dt),uid),
-- reg_tb as (select distinct uid,first_value(login_dt) over(partition by uid order by login_dt) first_dt
-- from login_temp)
-- select * 
-- from reg_tb left join login_temp second_login
-- on reg_tb.uid=second_login.uid 
-- and date_add(reg_tb.first_dt,interval 1 day) = second_login.login_dt;

-- 获取第二天登录的人数，次日留存率
-- with login_temp as (select uid,date(dt) login_dt from tb_login group by date(dt),uid),
-- reg_tb as (select distinct uid,first_value(login_dt) over(partition by uid order by login_dt) first_dt
-- from login_temp)
-- select 
-- 	first_dt,count(reg_tb.uid) 注册人数,
--     count(second_login.uid) 第二天登录的人数,
--      count(second_login.uid) / count(reg_tb.uid) 次日留存
-- from reg_tb left join login_temp second_login
-- on reg_tb.uid=second_login.uid 
-- and date_add(reg_tb.first_dt,interval 1 day) = second_login.login_dt
-- group by first_dt;

-- 加上七日留存率
with login_temp as (select uid,date(dt) login_dt from tb_login group by date(dt),uid),
reg_tb as (select distinct uid,first_value(login_dt) over(partition by uid order by login_dt) first_dt
from login_temp)
select 
	first_dt,count(reg_tb.uid) 注册人数,
    count(second_login.uid) 第二天登录的人数,
	count(second_login.uid) / count(reg_tb.uid) 次日留存,
	count(seven_login.uid) / count(reg_tb.uid) 七日留存,
    count(three_login.uid) / count(reg_tb.uid) 三日留存
from reg_tb 
left join login_temp second_login
on reg_tb.uid=second_login.uid and date_add(reg_tb.first_dt,interval 1 day) = second_login.login_dt
left join login_temp seven_login
on reg_tb.uid=seven_login.uid and date_add(reg_tb.first_dt,interval 6 day) = seven_login.login_dt
left join login_temp three_login
on reg_tb.uid=three_login.uid and date_add(reg_tb.first_dt,interval 2 day) = three_login.login_dt
group by first_dt;
