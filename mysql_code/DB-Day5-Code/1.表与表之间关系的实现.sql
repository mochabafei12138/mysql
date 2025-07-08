use mydb1;
-- 1.一对一关系
-- 用户和某电商平台的购物车之间的关系
-- 用户表：一
create table `tb_person`(
`pno` int comment '用户编号',
`pname` varchar(20) not null comment '用户名',
`birth` date not null comment '生日',
primary key(`pno`)
);

-- 购物车表：一
create table `tb_shopcar`(
`pno` int comment '用户编号',
`car_id` int comment '购物车编号',
constraint fk_per_car foreign key(`pno`) references tb_person(`pno`)
);

-- 2.一对多关系
-- 员工和部门之间的关系
-- 部门表：一
create table `dept`(
`deptno` int comment '部门编号',
`deptname` varchar(20) comment '部门名称',
`address` varchar(10) comment '地址',
primary key(`deptno`)
);

-- 员工表：多
create table `emplyee`(
`eno` int comment '工号',
`ename` varchar(20)  comment '员工姓名',
`deptno` int comment '部门编号',
constraint fk_emp_dept foreign key(`deptno`) references dept(`deptno`)
);

-- 3.多对多的关系
-- 用户和共享单车之间
-- 图书馆中用户和图书的关系
-- 用户表
create table `user`(
`uid` int comment '用户编号',
`uname` varchar(20) comment '用户名称',
`ulevel` int comment '用户等级',
primary key(`uid`)
);

-- 共享单车表
create table `bike`(
`bid` int comment '单车编号',
`in_use` boolean comment '使用状态',
`kind` int comment '单车类型',
primary key(`bid`)
);

-- 中间表：使用记录表
create table `record`(
`rid` int comment '流水号',
`uid` int comment '用户编号',
`bid` int comment '单车编号',
`start_time` datetime comment '开始时间',
`end_time` datetime comment '结束时间',
`payway` varchar(10) comment '支付方式',
`payment` int comment '支付金额',
primary key(`rid`),
constraint fk_rec_user foreign key(`uid`) references user(`uid`),
constraint fk_rec_bike foreign key(`bid`) references bike(`bid`)
);

