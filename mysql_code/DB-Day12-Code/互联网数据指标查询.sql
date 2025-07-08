use net;
select * from tb_visit;
select * from tb_user;
select * from tb_region;
select * from tb_channel;

-- 1.求**访问统计表**各访问平台的**浏览量**、**点击量**、**浏览至点击转化率**
-- 流程顺序：先浏览 -- 点击进入详情   点击行为的总量/浏览的总量
/*
| platform   | pv    | click | conversion |
| ---------- | ----- | ----- | ---------- |
| Android    | 9784  | 3978  | 0.4066     |
| IOS        | 11108 | 4250  | 0.3826     |
| 移动浏览器 | 3025  | 947   | 0.3131     |
 */
 select platform,sum(pv) pv,sum(click) click,sum(click)/sum(pv) conversion
 from tb_visit 
 group by platform;
 

/*
 * # 02.题目02
- 求**用户信息表**用户数量前十的省份及相应的用户数量
| province | user_num |
| -------- | -------- |
| 广东省   | 38       |
| 四川省   | 21       |
| 山东省   | 21       |
| 河南省   | 20       |
| 安徽省   | 18       |
| 黑龙江省 | 16       |
| 甘肃省   | 15       |
| 重庆市   | 15       |
| 山西省   | 14       |
| 江苏省   | 14       |


分析：
	1.用户来自于哪个省份
    2.按照省份进行分组，对用户进行计数，获取数量
    3.按照数量进行降序排序
    4.使用分页查询，获取前10条
 */
 -- 下面的连接只有城市，没有省份
select * from tb_user join tb_region on tb_user.region_id = tb_region.region_id;
-- 还需要知道城市是哪个省份的
-- tb_region包含了城市信息，也包含了省份信息
select * from tb_region city join tb_region province on city.region_pid=province.region_id;

-- 整合
select province.region_name province,count(user_id) user_num
from tb_region city join tb_region province join tb_user
on city.region_pid=province.region_id and tb_user.region_id = city.region_id
group by province.region_name
order by user_num desc
limit 10;

/*
 * # 03.题目03

- 求**用户信息表**各一级渠道的VIP用户数量
| one_level  | vip_num |
| ---------- | ------- |
| 新媒体营销 | 27      |
| 线上渠道   | 9       |
| 线下渠道   | 2       |
| 自然流量   | 2       |
 */
 -- 通过连接获取用户来自于哪个渠道
 select * from tb_user join tb_channel on tb_user.channel_id=tb_channel.channel_id;
 -- 整合
-- 方式一：先过滤，按照一级渠道进行分组
 select one_level, count(user_id) vip_num
 from tb_user join tb_channel 
 on tb_user.channel_id=tb_channel.channel_id
 where category='VIP用户'
 group by one_level;
 
-- 方式二：直接分组，在统计的时候判断是否为VIP，是就计数，不是就设置为null
select  one_level,count(if(category='VIP用户',user_id,null)) vip_num
from tb_user join tb_channel 
on tb_user.channel_id=tb_channel.channel_id
group by one_level
order by vip_num desc;

/*
 * # 04.题目04
- 求**用户信息表**各一级渠道的老用户数量占比
| one_level  | old_num | total_num | old_pct |
| ---------- | ------- | --------- | ------- |
| 新媒体营销 | 59      | 164       | 0.3598  |
| 线上渠道   | 24      | 59        | 0.4068  |
| 线下渠道   | 13      | 34        | 0.3824  |
| 自然流量   | 3       | 7         | 0.4286  |
 */
select  
	one_level,
	count(if(category='老用户',user_id,null)) old_num,
    count(user_id) total_num,
    count(if(category='老用户',user_id,null)) / count(user_id) old_pct
from tb_user join tb_channel 
on tb_user.channel_id=tb_channel.channel_id
group by one_level
order by old_num desc;

/*
 * # 05.题目05

- 求**用户信息表**各年龄分组的用户数量
| age_bins | user_num |
| -------- | -------- |
| (0, 18]  | 21       |
| (18, 30] | 207      |
| (30, 40] | 33       |
| (40, +∞] | 3        |
*/
-- 对年龄进行分箱操作
select *,case 
	when age<=18 then '(0, 18]'
    when age<=30 then '(18, 30]'
    when age<=40 then '(30, 40]'
    else '(40, +∞]'
    end age_bins
from tb_user;

-- 整合
with tb_age as (select *,case 
	when age<=18 then '(0, 18]'
    when age<=30 then '(18, 30]'
    when age<=40 then '(30, 40]'
    else '(40, +∞]'
    end age_bins from tb_user)
select age_bins,count(user_id) user_num
from tb_age
group by age_bins
order by age_bins;


/*
 * # 06.题目06

- 求**访问统计表**浏览量在2000以上的二级渠道及相应的浏览量
| two_level | pv   |
| --------- | ---- |
| 基础上线  | 4897 |
| 贴吧推广  | 4533 |
| 微信推广  | 3830 |
| 品牌推广  | 3216 |
| 微博推广  | 2138 |

分析：
	1.对二级渠道进行分组，求浏览量的总和
    2.分组之后的基础上，筛选浏览总量在2000以上
 */
 select two_level,sum(pv) pv
 from tb_visit join tb_channel 
 on tb_visit.channel_id=tb_channel.channel_id
 group by two_level
 having sum(pv)>2000
 order by pv desc;
 

/*# 07.题目07
- 求**用户信息表**各性别各用户类型的用户数量，以长表的结构展示
| sex  | category | user_num |
| ---- | -------- | -------- |
| 女   | VIP用户  | 12       |
| 女   | 新用户   | 58       |
| 女   | 老用户   | 76       |
| 男   | VIP用户  | 28       |
| 男   | 新用户   | 67       |
| 男   | 老用户   | 23       |
 * 
 */
 select sex,category,count(user_id) user_num
 from tb_user
 group by sex,category
 order by sex;
 
/*
 * # 08.题目08

- 求**用户信息表**各性别各用户类型的用户数量，以宽表的结构展示

| sex  | new_num | old_num | vip_num |
| ---- | ------- | ------- | ------- |
| 女   | 58      | 76      | 12      |
| 男   | 67      | 23      | 28      |
 */
 select sex,
	count(if(category='新用户',user_id,null)) new_num,
    count(if(category='老用户',user_id,null)) old_num,
    count(if(category='VIP用户',user_id,null)) vip_num
 from tb_user
 group by sex
 order by sex;
 

/*# 09.题目09
- 求**用户信息表**每月注册的用户数量
| year | month | user_num |
| ---- | ----- | -------- |
| 2015 | 10    | 27       |
| 2015 | 11    | 35       |
| 2015 | 12    | 30       |
| 2016 | 1     | 28       |
| 2016 | 2     | 29       |
| 2016 | 3     | 31       |
| 2016 | 4     | 24       |
| 2016 | 5     | 29       |
| 2016 | 6     | 30       |
| 2016 | 8     | 1        |
 * 
 */
 select year(login_date) `year`,month(login_date) `month`,count(user_id) user_num
 from tb_user
 group by year(login_date),month(login_date)
 order by `year`,`month`;
 
 
/*# 10.题目10

- 求**访问统计表**每月的**浏览量**、**退出量**、**浏览至点击转化率**
| month   | pv   | quit | conversion |
| ------- | ---- | ---- | ---------- |
| 2015-07 | 1872 | 753  | 0.3365     |
| 2015-08 | 1919 | 758  | 0.3538     |
| 2015-09 | 1668 | 653  | 0.3795     |
| 2015-10 | 4941 | 1290 | 0.4416     |
| 2015-11 | 1470 | 622  | 0.3646     |
| 2015-12 | 3045 | 947  | 0.3990     |
| 2016-01 | 1701 | 700  | 0.3410     |
| 2016-02 | 3769 | 1129 | 0.3940     |
| 2016-03 | 1580 | 630  | 0.3601     |
| 2016-04 | 1806 | 725  | 0.3372     |
| 2016-05 | 146  | 60   | 0.3904     |
 */
select date_format(stat_date,'%Y-%m') `month`,
	sum(pv) pv,
    sum(quit) quit,
    sum(click)/sum(pv) conversion
from tb_visit
group by date_format(stat_date,'%Y-%m')
order by `month`;

/*
 * # 11.题目11
- 求**访问统计表**各三级渠道的人均停留时长，并筛选大于3000的三级渠道
| three_level | per_duration |
| ----------- | ------------ |
| 运营商      | 3516         |
| 小号积累    | 3443         |
| 垂直社区    | 3085         |
| 安卓论坛    | 3024         |
分析：
	访问统计表中记录的是不同时间用户访问的信息，表中存在：同一个用户在不同日期进行了访问【用户会重复】
    注意：人均停留时长=总时长/人的个数【去重】
	实现：访问表和渠道表进行连接，按照三级渠道进行分组，求总停留时长 和 去重之后的人数
 */
 -- count(distinct user_id):先对字段进行去重，然后进行计数
 select three_level,
	sum(stay_duration) total,
    count(distinct user_id) user_num,
    round(sum(stay_duration)/count(distinct user_id),0) per_duration
 from tb_visit join tb_channel 
 on tb_visit.channel_id = tb_channel.channel_id
 group by three_level
 having sum(stay_duration)/count(distinct user_id)>3000
 order by per_duration desc;
 
/*
 * # 12.题目12

- 以一级渠道分组**去重合并**二级渠道，并以"/"为分隔符

| one_level  | two_level                                    |
| ---------- | -------------------------------------------- |
| 新媒体营销 | 贴吧推广/微博推广/微信推广/品牌推广/事件营销 |
| 线上渠道   | 基础上线                                     |
| 线下渠道   | 行货店面/水货刷机/手机厂商预装               |
| 自然流量   | 自然流量                                     |
 */
 -- group_concat():拼接，其中可以用separator设置分隔符
 select one_level,
	group_concat(distinct two_level order by two_level desc separator '/') two_level
 from tb_channel
 group by  one_level;

/*
 * # 13.题目13

- 求**访问统计表**各三级渠道的浏览量，并生成降序排名序号，最终展示前十
| three_level  | pv   | idx  |
| ------------ | ---- | ---- |
| 小号导大号   | 1369 | 1    |
| 事件营销     | 1362 | 2    |
| 小号积累     | 1278 | 3    |
| 风暴论坛     | 1248 | 4    |
| 安卓应用商店 | 1210 | 5    |
| 微信互推     | 1183 | 6    |
| 水货刷机     | 1177 | 7    |
| 机锋论坛     | 1155 | 8    |
| 手机厂商预装 | 1142 | 9    |
| 问答类       | 1141 | 10   |
 */
 --  方式一:子查询
 select * 
 from
 (select 
	three_level,
    sum(pv) pv,
    row_number() over(order by sum(pv) desc) idx
 from tb_visit join tb_channel 
 on tb_visit.channel_id=tb_channel.channel_id
 group by three_level) tb_rk
 where idx<=10;
 
 -- 方式二：with
 with tb_rk as 
 (select 
	three_level,
    sum(pv) pv,
    row_number() over(order by sum(pv) desc) idx
 from tb_visit join tb_channel 
 on tb_visit.channel_id=tb_channel.channel_id
 group by three_level)
 select * from tb_rk
 where idx<=10;

/*
 * # 14.题目14

- 求**访问统计表**每月的**浏览量**和**累积浏览量**
| month   | pv   | cum_pv | 
| ------- | ---- | ------ |
| 2015-07 | 1872 | 1872   |
| 2015-08 | 1919 | 3791   |
| 2015-09 | 1668 | 5459   |
| 2015-10 | 4941 | 10400  |
| 2015-11 | 1470 | 11870  |
| 2015-12 | 3045 | 14915  |
| 2016-01 | 1701 | 16616  |
| 2016-02 | 3769 | 20385  |
| 2016-03 | 1580 | 21965  |
| 2016-04 | 1806 | 23771  |
| 2016-05 | 146  | 23917  |
 */
 -- 累积浏览量：在每月的基础上进行累加。需要求出每月的浏览量
 -- 方式一：
 with tb_pv as (select date_format(stat_date,'%Y-%m') `month`,sum(pv) pv
 from tb_visit 
 group by  date_format(stat_date,'%Y-%m'))
 select 
	*,   
	sum(pv) over(order by `month` rows between unbounded preceding and current row) cum_pv 
 from tb_pv;
 
 -- 方式二：这里的子窗口可以简化，默认是从第一行到当前行
 with tb_pv as (select date_format(stat_date,'%Y-%m') `month`,sum(pv) pv
 from tb_visit 
 group by  date_format(stat_date,'%Y-%m'))
 select 
	*,   
	sum(pv) over(order by `month`) cum_pv 
 from tb_pv;
 
/*
 * # 15.题目15

- 求**访问统计表**每月的**浏览量**和**环比增长率**
| month   | cur_pv | pre_pv | growth_rate |
| ------- | ------ | ------ | ----------- |
| 2015-07 | 1872   |        |             |
| 2015-08 | 1919   | 1872   | 0.0251      |
| 2015-09 | 1668   | 1919   | -0.1308     |
| 2015-10 | 4941   | 1668   | 1.9622      |
| 2015-11 | 1470   | 4941   | -0.7025     |
| 2015-12 | 3045   | 1470   | 1.0714      |
| 2016-01 | 1701   | 3045   | -0.4414     |
| 2016-02 | 3769   | 1701   | 1.2158      |
| 2016-03 | 1580   | 3769   | -0.5808     |
| 2016-04 | 1806   | 1580   | 0.1430      |
| 2016-05 | 146    | 1806   | -0.9192     |
 */
 /*
 环比增长率：(本月-上月)/上月 ---》本月/上月 -1
 从上往下偏移：lag()
 从下往上偏移：lead()
 */
 -- 每月的浏览量
 select date_format(stat_date,'%Y-%m') `month`,sum(pv) cur_pv
 from tb_visit 
 group by  date_format(stat_date,'%Y-%m');
 
 -- 方式一：分开写
 with tb_cur as (
 select date_format(stat_date,'%Y-%m') `month`,sum(pv) cur_pv
 from tb_visit 
 group by  date_format(stat_date,'%Y-%m')),
 tb_pv as (select *,lag(cur_pv) over(order by `month`) pre_pv from tb_cur)
 select *,cur_pv/pre_pv -1 growth_rate from tb_pv;
 
 -- 方式二:整合写
select 
	date_format(stat_date,'%Y-%m') `month`,
    sum(pv) cur_pv,
	lag(sum(pv)) over(order by date_format(stat_date,'%Y-%m')) pre_pv,
	sum(pv)/lag(sum(pv)) over(order by date_format(stat_date,'%Y-%m') ) - 1 growth_rate
from tb_visit
group by  date_format(stat_date,'%Y-%m');

/*
 * # 16.题目16

- 求**访问统计表**各一级渠道下浏览量大于1000的三级渠道数量
| one_level  | cnt  |
| ---------- | ---- |
| 新媒体营销 | 11   |
| 线上渠道   | 3    |
| 线下渠道   | 3    |
分析：
	1.各一级渠道各三级渠道的浏览量
    2.以1为基础，找到各一级渠道下浏览量大于1000的数据
    3.对筛选出来的数据进行计数
 */
 with tb_level as (select 
	one_level,
    three_level,
    sum(pv) pv
 from tb_visit join tb_channel 
 on tb_visit.channel_id=tb_channel.channel_id
 group by one_level,three_level having sum(pv)>1000)
 select one_level,count(three_level) cnt
 from tb_level
 group by one_level
 order by cnt desc;
 
 
/*
 * # 17.题目17

- 求**访问统计表**各用户最近一次访问日期距离2016-05-02的天数，并筛选天数小于30的用户
| user_id  | days   |
| -------- | ------ |
| USER0260 | 29     |
| USER0261 | 29     |
| USER0262 | 29     |
| USER0263 | 29     |
| USER0264 | 29     |
| USER0001 | 28     |
| USER0002 | 28     |
| USER0003 | 28     |
| USER0004 | 28     |
| ......   | ...... |
分析：
	1.最近一次访问：求每个用户访问日期的最大值
    2.使用datediff求两个日期的差值
    3.筛选查找小于30天的
*/
select user_id,datediff('2016-05-02',max(stat_date)) days
from tb_visit
group by user_id
having datediff('2016-05-02',max(stat_date))<30
order by days desc;

/*
 * # 18.题目18

- 求**访问统计表**各一级渠道的新用户、老用户、VIP用户的平均停留时长，以宽表的结构展示
| one_level  | new_duration | old_duration | vip_duration |
| ---------- | ------------ | ------------ | ------------ |
| 线上渠道   | 2380         | 2332         | 2168         |
| 新媒体营销 | 2431         | 2496         | 2173         |
| 线下渠道   | 2498         | 2051         | 1782         |
| 自然流量   | 2813         | 972          | 2798         |
 */
 select * from tb_visit join tb_channel 
 on tb_visit.channel_id=tb_channel.channel_id;
 
 
 -- 整合
select 
	one_level,
    round(avg(if(category='新用户',stay_duration,null)),0) new_duration,
    round(avg(if(category='老用户',stay_duration,null)),0) old_duration,
    round(avg(if(category='VIP用户',stay_duration,null)),0) vip_duration
from tb_visit join tb_channel join tb_user
on tb_visit.channel_id=tb_channel.channel_id and tb_visit.user_id=tb_user.user_id
group by one_level
order by new_duration;
 