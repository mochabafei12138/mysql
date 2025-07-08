/*
frame子窗口
	在大窗口的基础上进行细分，对每个细分的窗口进行相应的运算
    
进行窗口细分的方式：
1.按照行进行细分
	over(partition by 分组字段 order by 排序字段  rows between A and B) 
    A和B数据有以下信息：
		current row:当前行
        unbounded preceding:窗口的第一行
        unbounded following:窗口的最后一行
        N preceding:前n行【建立在当前行为基础之上】
        N following:后n行【建立在当前行为基础之上】
*/

-- 需求：求近三个月的销售和
-- 近xx的时候都是右参照点的，比如近3天，以今天作为基准点，就是前天，昨天和今天
-- 实现的前提条件：必须要排序，保证数据计算的顺序【整个结果集是一个大窗口】
-- 在大窗口的基础上设定小窗口，按照当前行进行移动，直到当前行为窗口中的最后一行则结束
select *,sum(sales) over(order by yearly,monthly  rows between 2 preceding and current row) 近三个月的销量
from tb_ym_sales;

/*
2.按照范围进行细分
	over(partition by 分组字段 order by 排序字段  range between A and B) 
    A和B数据有以下信息：
		current row:当前行
        unbounded preceding:窗口的第一个数据
        unbounded following:窗口的最后一个数据
        N preceding：当前数据 - n【建立在当前行为基础之上】
        N following: 当前数据 + n【建立在当前行为基础之上】
*/
-- 需求：统计当前月销量上下偏移30的，在这个范围内的月的个数
select *,count(monthly) over(order by sales  range between 30 preceding and 30 following) 上下浮动30月份个数
from tb_ym_sales;


-- 思考问题：近3个月，如果月份的数据是连续的，可以使用行的概念来划分子窗口，但是如果月份的数据不连续，再使用行的概念会 不准确
/*
1  27
2  84
3  30
4  52
6  77
7  88

以6月份为基准，近3个月----》4月+5月+6月
但是以行的概念来说，6月份求销售和的时候，3 + 4 + 6的销售额，这是不准确的

像这种不连续的数据如何处理？
	需要从时间维度处理，从时间范围进行偏移，而不是行
    可以把给定的数据设置为时间格式，建立一个时间辅助表，该表中的时间数据是连续的，该表和原表进行连接查询
*/

-- 删除2021.5的数据
delete from tb_ym_sales where yearly=2021 and monthly=5;
-- 按照行偏移求近3个月的销售和
select *,sum(sales) over(order by yearly,monthly  rows between 2 preceding and current row) 近三个月的销量
from tb_ym_sales;


-- 解决方案
-- 第一步：生成一个辅助表
-- recursive：控制的逻辑是一个循环的机制
with recursive tb_month(monthly) as (
	select 1 monthly   -- 相当于python中monthly=1
    union all 
    select monthly + 1 from tb_month where monthly<12
)select * from tb_month;

-- 上述循环等价于下面的写法：
select 1 monthly  
union all 
select 2 monthly 
union all 
select 3 monthly 
union all 
select 4 monthly 
union all 
select 5 monthly 
union all 
select 6 monthly 
union all 
select 7 monthly 
union all 
select 8 monthly 
union all 
select 9 monthly 
union all 
select 10 monthly 
union all 
select 11 monthly 
union all 
select 12 monthly ;

-- 第二步：循环生成一个日期
with recursive tb_month(dt) as (
	select '2021-01-01' dt    -- 初始化第一个日期
    union all 
    select date_add(dt,interval 1 month) from tb_month where dt<'2022-12-01'
)select year(dt) yearly,month(dt) monthly from tb_month;

-- 第三步：连接查询
with recursive tb_month(dt) as (
	select '2021-01-01' dt    -- 初始化第一个日期
    union all 
    select date_add(dt,interval 1 month) from tb_month where dt<'2022-12-01'
)select year(dt) yearly,month(dt) monthly,tb_ym_sales.* from tb_month left join tb_ym_sales 
on year(dt) = yearly and month(dt)=monthly;

-- 第四步：此时进行行偏移，求近三个月的销售和
with recursive tb_month(dt) as (
	select '2021-01-01' dt    -- 初始化第一个日期
    union all 
    select date_add(dt,interval 1 month) from tb_month where dt<'2022-12-01'
)select year(dt) yearly,month(dt) monthly,sales,
sum(sales) over(order by year(dt),month(dt)  rows between 2 preceding and current row) 近三个月和
 from tb_month left join tb_ym_sales 
on year(dt) = yearly and month(dt)=monthly;





