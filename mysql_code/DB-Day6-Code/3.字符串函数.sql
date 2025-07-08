-- 一、基本使用
select charset('abc');
-- char(N) 将AscII数值转成字符， N可以是一个字符，也可以是数值 【注意】在8.0中返回十六进制字符串。
select char(48);
select ord('A');  -- 65
-- concat(a, b) 将a和b拼接成一个字符串
select concat('abc','123');
-- length("子符串") 计算字符串的字节长度
select length('abc');
-- instr(str, sub) 返回sub在str的首次出现的位置， 索引位置是从1开始
select instr('adminname','n');
-- left(str, len) 从字符串str的左边截取len个字符
select left('abcdef',2);
-- right(str, len) 从字符串str的右边截取 len个字符
select right('abcdef',2);
-- replace(str, sub, replace_str) 替换子子符串
select replace('today is a good day today today','today','yesterday');
-- lpad(str,len,sub)  如果str的长度不足时，在左边填充sub字符， 同Python的str对象的rjust()
select lpad('hello',20,'*');
-- rpad(str, len, sub) 如果str的长度不足时，在右边填充sub字符, 同Python的str对象的ljust()
select rpad('hello',20,'*');
-- lower()  小写转换
select lower('JGDfjae');
-- upper()  大写转换
select upper('JGDfjae');
-- trim() 同python的strip()函数，删除两端的空白
select trim('     hello     ');
select ltrim('     hello     ');
select rtrim('     hello     ');
-- strcmp(sub1,sub2):比较两个字符串的大小,大于：1，小于：-1  等于：0
-- 注意：依据的是ASICII，但是不缺区分大小写
select strcmp('abc','HGf');

-- 二、结合表进行操作
-- 1.查询emp表中员工姓名为4个字母的员工信息
select * from emp where ename like '____';
select * from emp where length(ename)=4;

-- 2.将员工的姓名，工作通过-的方式连接
select ename,job from emp;
select concat(ename,'-',job) from emp;

-- 3.查询姓a的员工信息
select * from emp where ename like 'a%';
select * from emp where left(ename,1)='a';

-- 4.查询员工姓名最后一位为n的员工信息
select * from emp where ename like '%n';
select * from emp where right(ename,1)='n';




