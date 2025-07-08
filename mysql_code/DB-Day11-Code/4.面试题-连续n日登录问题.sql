use mydb1;
create table if not exists tb_login(
id int primary key auto_increment comment '记录编号',
dt datetime comment '登录时间',
uid int comment '用户ID'
);
insert into tb_login(dt, uid) values('2023-01-01 08:17:09', 1001),
('2023-01-01 12:17:09', 1001),
('2023-01-01 09:17:09', 1002),
('2023-01-01 23:17:09', 1002),
('2023-01-01 10:17:09', 1003),
('2023-01-02 12:17:09', 1001),
('2023-01-02 16:17:09', 1002),
('2023-01-02 18:17:09', 1001),
('2023-01-03 05:17:09', 1003),
('2023-01-03 12:17:09', 1001),
('2023-01-03 22:17:09', 1001),
('2023-01-04 06:17:09', 1003),
('2023-01-04 22:17:09', 1002),
('2023-01-04 18:17:09', 1001),
('2023-01-05 21:17:09', 1003),
('2023-01-05 23:17:09', 1003),
('2023-01-06 09:17:09', 1002),
('2023-01-06 12:17:09', 1001),
('2023-01-06 09:17:09', 1002);
-- 需求：连续3天登录的用户
select * from tb_login;
-- 对数据进行处理，每个用户每天只出现一次
select uid,date(dt) login_dt from tb_login group by date(dt),uid;

-- 方式一：窗口偏移函数
-- 连续3天登录：1号登录了 2号登录  3号登录
-- 向上偏移的函数lead(偏移字段,偏移各个数) over(分组字段  排序字段 )
with t as (select uid,date(dt) login_dt from tb_login group by date(dt),uid),
t1 as (select *,
	lead(login_dt,1) over(partition by uid order by login_dt) second_dt,
    lead(login_dt,2) over(partition by uid order by login_dt) third_dt
from t)
select distinct uid 
from t1
where date_add(login_dt,interval 1 day)=second_dt and
date_add(second_dt,interval 1 day)=third_dt;

-- 方式二：使用自连接
with t as (select uid,date(dt) login_dt from tb_login group by date(dt),uid)
select distinct first_login.uid
from t first_login join t second_login join t third_login
on first_login.uid=second_login.uid and date_add(first_login.login_dt,interval 1 day)=second_login.login_dt
and first_login.uid=third_login.uid and date_add(first_login.login_dt,interval 2 day)=third_login.login_dt;

-- 方式三：使用排名函数
-- 上面两种方式可以实现，但是局限性较大，使用排名函数适用性更加广
/*
连续登录的话：登录时间 - rk ,结果应该是一样的
思路：
	a.将登录时间向过去偏移 rk 天，得到偏移日期
    b.按照用户与偏移后的日期进行归类，统计归类的个数
    c.如果这个个数>=3的，表示至少3天连续登录
*/
with t as (select uid,date(dt) login_dt from tb_login group by date(dt),uid),
t1 as (select *,row_number() over(partition by uid order by login_dt) rk from t)
select uid,date_sub(login_dt,interval rk day) diff,count(*) 天数
from t1
group by uid,date_sub(login_dt,interval rk day)
having count(*) >=3;


