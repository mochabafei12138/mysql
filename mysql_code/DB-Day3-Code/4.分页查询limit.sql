select * from emp;

-- 从头开始，查询2条，注意：索引默认从0开始，且索引可以省略
select * from emp limit 0,2;
select * from emp limit 2;

-- 从索引3开始，查询4条
select * from emp limit 3,4;
