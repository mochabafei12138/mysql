-- 创建用户
--  qianfeng是用户名，123456是密码
-- ip地址：127.0.0.1，表示本机地址
create user qianfeng@'127.0.0.1' identified by  '123456';

show databases;
-- 用户管理的数据库mysql
-- mysql库中有一张表user,专门存储用户的信息
use mysql;
select * from user;

-- 给用户分配权限
grant select on mydb1.emp  to qianfeng@'127.0.0.1';
grant update on mydb1.emp  to qianfeng@'127.0.0.1';
grant delete on mydb1.emp  to qianfeng@'127.0.0.1';
-- 刷新权限
flush privileges;

-- 撤销权限
revoke update on mydb1.emp from  qianfeng@'127.0.0.1';
-- 刷新权限
flush privileges;







