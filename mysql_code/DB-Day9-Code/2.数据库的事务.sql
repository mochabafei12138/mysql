-- 需求：张三给李四转账
-- 逻辑操作1：更新张三的账户，减少 update
-- 逻辑操作2：更新李四的账户，增加  update

use mydb1;

create table tb_account(
aid int comment '用户id',
uname varchar(20) comment '账户名',
money  double comment '余额'
);
insert into tb_account values(1,'张三',10000),(2,'李四',800);
select * from tb_account;

-- 隐式事务
-- update tb_account set money=money+100 where aid=1;
-- delete from tb_accout;

-- 显式事务
-- 1.正常完成操作，提交事务
begin;
update tb_account set money=money-1000 where aid=1;
select * from tb_account;
update tb_account set money=money+1000 where aid=2;
select * from tb_account;
-- 同步数据，需要结束事务，并把结果提交
commit;   -- 9000   1800

-- 2.未正常完成操作，回滚事务
begin;
update tb_account set money=money-1000 where aid=1;
select * from tb_account;
update tb_account set money=money+1000 where aid=2;
select * from tb_account;
-- 同步数据，需要结束事务，需要回滚数据
rollback;  -- 10000 800
