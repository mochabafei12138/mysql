use mydb1;

create table if not exists tb_ym_sales(
    yearly int comment '年份',
    monthly int comment '月份',
    sales int comment '销量',
  	primary key(yearly, monthly)
);
insert into tb_ym_sales values
(2021, 1, 84),
(2021, 2, 24),
(2021, 3, 50),
(2021, 4, 73),
(2021, 5, 65),
(2021, 6, 91),
(2021, 7, 52),
(2021, 8, 85),
(2021, 9, 57),
(2021, 10, 32),
(2021, 11, 64),
(2021, 12, 69),
(2022, 1, 82),
(2022, 2, 13),
(2022, 3, 52),
(2022, 4, 55),
(2022, 5, 87),
(2022, 6, 32),
(2022, 7, 46),
(2022, 8, 81),
(2022, 9, 14),
(2022, 10, 68),
(2022, 11, 51),
(2022, 12, 56);

select * from tb_ym_sales;

/*
注意：偏移函数的本质是窗口函数，所以仍然遵循窗口函数的语法

偏移函数的使用场景：
环比：相比于上一个月增长了多少
	计算公式：(本月数据-上月数据)/上月数据-----》本月数据/上月数据 - 1
    lag(偏移字段，偏移个数，如如果不存在相应的数据的填充值)：把数据向下偏移
    lead(偏移字段，偏移个数，如如果不存在相应的数据的填充值):把数据向上偏移
    注意：偏移个数不书写，则默认为1
		  如果不存在相应的数据的填充值，默认的填充值是null
          
同比：和去年相同月份进行对比增长了多少
	计算公式：(本月数据-去年相同月份的数据)/去年相同月份的数据 -----》本月数据/去年相同月份的数据 - 1
    lag(字段,12)

定比：和固定的某一个值进行比较，比如：相对于同年一月份增长了多少
	first_value(字段)：获取窗口中出现的第一个数据
    计算公式：(本月数据-固定数据)/固定数据-----》本月数据/固定数据 - 1
*/

-- 1.环比
-- 需要把数据值，按照年份月份从小到大的顺序，将salas的数据向下偏移1个
-- 向下偏移    *******
select *,lag(sales) over(order by yearly,monthly) 上个月的销量,
 (sales/lag(sales) over(order by yearly,monthly) - 1) 环比
from  tb_ym_sales;

-- 向上偏移
select *,lead(sales) over(order by yearly,monthly) 下个月的销量
from  tb_ym_sales;

-- 2.定比
select *,first_value(sales) over(order by yearly,monthly)  第一个销量,   -- 未分组，获取的是整个窗口的第一个数据
(sales/first_value(sales) over(order by yearly,monthly) - 1)  定比
from tb_ym_sales;

-- 3.同比
select *,lag(sales,12) over(order by yearly,monthly) 去年相同月份的销量,
(sales/lag(sales,12) over(order by yearly,monthly) - 1) 同比
from tb_ym_sales;

-- 4.整合
select *,lag(sales) over(order by yearly,monthly) 上个月的销量,
 (sales/lag(sales) over(order by yearly,monthly) - 1) 环比,
 lead(sales) over(order by yearly,monthly) 下个月的销量,
 first_value(sales) over(order by yearly,monthly)  第一个销量,
 (sales/first_value(sales) over(order by yearly,monthly) - 1)  定比,
 lag(sales,12) over(order by yearly,monthly) 去年相同月份的销量,
 (sales/lag(sales,12) over(order by yearly,monthly) - 1) 同比
from  tb_ym_sales;

-- 5.上述求环比，定比和同比，是没有区分年的，只是直接获取上个月
-- 在同一年中检查指标【数据偏移的时候不能跨年，每年是独立的------》每年是一个单独的窗口】
-- 通过分组实现不同的窗口，在每个窗口的内部，实现排序
select *,lag(sales) over(partition by yearly order by monthly) 上个月的销量,
first_value(sales) over(partition by yearly order by monthly) 	1月份销量,
(sales/lag(sales) over(partition by yearly order by monthly) - 1) 环比,
(sales/first_value(sales) over(partition by yearly order by monthly) - 1)  定比
from  tb_ym_sales;


