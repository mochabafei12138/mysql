-- 日期函数的基本使用
-- 日期
select current_date();
-- 时间
select current_time();
-- 日期+时间
select current_timestamp();
select now();   --   ******

-- 分别获取指定使劲按的年月日时分秒 *****
select year(now());
select month(now());
select day(now());
select hour(now());
select minute(now());
select second(now());

-- 获取星期几，注意： 周日是1  周六是7
-- 比如：当前是星期二，查询结果为3
select dayofweek(now()); -- 3

-- 获取一年的第几天
select dayofyear(now());

-- 时间的加减运算   *****
select date_add(now(),interval 2 year);    -- 增加2年
select date_add(now(),interval -2 year);   -- 减少2年

select date_sub(now(),interval 2 year);    -- 减少2年
select date_sub(now(),interval -2 year);   -- 增加2年

select date_add('2016.12.3',interval 2 month);   
select date_sub('2016.12.3',interval 2 day);  

-- 日期格式化
select date_format(now(),'%Y/%m/%d');
select date_format(now(),'%Y.%m.%d %H:%i:%s');

-- 日期之间求差值
-- datediff：返回天数
select datediff('2024.4.16','2024.2.13');  -- 返回的是天数 ,前面的日期 - 后面的日期
-- timestrapdiff(结果的单位，date1,date2)
select timestampdiff(year,'2024.2.13','2024.4.16'); 
select timestampdiff(month,'2024.2.13','2024.4.16');   -- 后面的日期 - 前面的日期
select timestampdiff(day,'2024.2.13','2024.4.16'); 
