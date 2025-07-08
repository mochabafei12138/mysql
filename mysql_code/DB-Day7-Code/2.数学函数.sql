-- 一、基本使用
select abs(-30);
select ceil(18.11),ceil(18.99);
select floor(18.11),floor(18.99);

select PI();

select rand(); -- 获取0~1之间的随机数
select rand() * 80 + 20; -- 获取20~100之间的随机数

select pow(5,3);

-- 二、结合表使用
select ename,birth,floor(datediff(now(),birth) / 365) 年龄 from emp; -- 周岁
select ename,birth,ceil(datediff(now(),birth) / 365) 年龄 from emp; -- 虚岁
select ename,birth,year(now()) - year(birth) 年龄 from emp;
