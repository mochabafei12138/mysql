### 一、数据的完整性/约束

> 概念：对表中字段进行限定
>
> 确保数据库完整性的实质就是在创建表时给表中字段添加约束,也可以修改现有的表,修改其中的某些字段
>
> 【面试题】约束分类：
>
> 1. 非空约束：not null
> 2. 唯一约束：unique
> 3. 默认值约束：default 
> 4. 主键约束：primary key      ***********
> 5. 外键约束：foreign key       *******

#### 1.非空约束not null

> 作用：限定字段值不能为空
>
> 创建表时，添加非空约束
>
> ```sql
> create table 表名(字段名 字段类型 not null, 字段名 字段类型 [约束], ...);
> ```
>
> 创建表后，添加非空约束
>
> ```python
> alter table 表名 modify 字段名 字段类型 not null ;  
> ```
>
> 删除非空约束（设置字段允许有空值）
>
> ```sql
> alter table 表名 modify 字段名 字段类型;
> ```

> ```mysql
> use mydb1;
> 
> -- 非空约束
> -- 1.
> create table stu11(
> sid int not null comment '学号',
> sname varchar(20) not null comment '姓名'
> );
> desc stu11;
> -- insert into stu11 (sid) value(1001); -- 报错
> -- insert into stu11 value (null,null);  -- 报错
> 
> -- 2.
> create table stu12(
> sid int comment '学号',
> sname varchar(20) comment '姓名'
> );
> desc stu12;
> insert into stu12 (sid) value(1001);
> insert into stu12 value (null,null); 
> 
> -- 问题：如果表已经存在，且表中的指定字段已经存在空值null，给字段添加非空约束不会成功
> alter table stu12 modify sid int not null;
> 
> -- 解决方案：先处理掉表中已经存在的null值
> update stu12 set sid=1002 where sid is null; 
> select * from stu12;
> 
> -- 3.删除
> alter table stu12 modify sid int;
> ```

#### 2.默认值约束default

> 创建表时，添加默认值约束
>
> ```python
> create table 表名(字段名 字段类型 default  xxxx, 字段名 字段类型 [约束], ...);
> ```

> ```mysql
> -- 默认值约束
> -- 1.
> create table stu21(
> sid int not null comment '学号',
> sname varchar(20) comment '姓名',
> address varchar(50) default '北京' comment '家庭住址'
> );
> desc stu21;
> insert into stu21 (sid) value(1001);
> insert into stu21  value(1002,'aaa','上海');
> select * from stu21;
> 
> -- 2.not null和default可以同时添加给同一个字段
> create table stu22(
> sid int not null comment '学号',
> sname varchar(20) comment '姓名',
> address varchar(50) not null default '北京' comment '家庭住址'
> );
> desc stu22;
> ```

#### 3.唯一约束 unique

> 作用：限定某一字段的字段值不能有重复，一般用于确保在非主键列中输入不重复的值
>
> 创建表时，添加唯一约束
>
> ```sql
> create table 表名(字段名 字段类型 unique, 字段名 字段类型 [约束], ...);
> ```
>
> 创建表后，添加唯一约束
>
> ```sql
> alter table 表名 modify 字段名 字段类型 unique;
> ```
>
> 删除唯一约束（设置字段允许有重复值）
>
> ```sql
> alter table 表名 drop index 字段名;
> ```

> ```mysql
> -- 唯一约束
> -- 唯一约束和非空约束的用法非常相似
> -- 1
> -- 注意：一般用于确保在非主键列中输入不重复的值
> create table stu31(
> sid int not null comment '学号',
> sname varchar(20) comment '姓名',
> card_id varchar(18) comment '身份证号' unique
> );
> desc stu31;
> insert into stu31 value (1001,'aaa','23456789');
> -- insert into stu31 value (1002,'bbb','23456789');  -- 报错，Duplicate:重复
> -- 注意：unique只针对非空值做出检测，可以插入多次null
> insert into stu31  value (1001,'aaa',null);
> insert into stu31  value (1001,'aaa',null);
> select * from stu31;
> 
> -- 2
> create table stu32(
> sid int not null comment '学号',
> sname varchar(20) comment '姓名',
> card_id varchar(18) comment '身份证号'
> );
> desc stu32;
> alter table stu32 modify card_id varchar(18) unique;
> 
> -- 3
> -- 注意：后期手动修改字段的约束为unique，再次取消，取消不了，插入数据依然会检测到
> alter table stu32 modify card_id varchar(18);
> insert into stu32 value (1001,'aaa','23456789');
> -- insert into stu32 value (1001,'aaa','23456789');  -- 报错，Duplicate:重复
> 
> -- 注意：唯一约束一般给添加给值肯定唯一的字段，比如：身份证号，手机号，银行卡号等
> 
> -- 注意：在确定创建表之前，字段的默认值或是否唯一一般就要确定好，在建表的过程中就可以直接添加
> ```

#### 4.主键约束primary key

> 【面试题】主键约束primary key的特点：
>
> 1. 非空且唯一
> 2. 一张表只能有一个字段是主键
> 3. 主键是表中记录的唯一标识
>
> 创建表时，添加主键约束
>
> ```python
> create table 表名(字段名 字段类型 primary key, 字段名 字段类型 [约束], ...);
> create table 表名(字段名 字段类型 [约束], 字段名 字段类型 [约束], ... , primary key(主键字段));
> ```
>
> 创建表后，添加主键约束
>
> ```python
> alter table 表名 modify 字段名 字段类型 primary key;
> ```
>
> 删除主键
>
> ```python
> alter table 表名 drop primary key;
> 注意：删除主键约束后，主键仍有非空约束
> ```

> 主键自增长：
>
> 概念：如果某个字段是数值类型的主键字段，可以使用 auto_increment 来实现主键自增长
>
> 一般给主键添加自动增长的数值，列只能是整数类型，但是如果删除之前增长的序号，后面再添加的时候序号不会重新开始，而是接着被删除的那一列的序号

> 创建表时，添加主键自增长
>
> ```sql
> create table 表名(字段名 字段类型 primary key auto_increment, 字段名 字段类型 [约束], ...);
> ```
>
> 创建表后，添加主键自增长
>
> ```sql
> alter table 表名 modify 主键字段 字段类型 auto_increment;
> ```
>
> 创建表后，添加主键约束的同时，设置自增长
>
> ```sql
> alter table 表名 modify 字段名 字段类型 primary key auto_increment
> ```
>
> 删除自增长
>
> ```sql
> alter table 表名 modify 字段名 字段类型;
> ```

> ```mysql
> -- 主键约束
> -- 1
> create table stu41(
> sid int primary key comment '学号',
> sname varchar(20) comment '姓名'
> );
> desc stu41;
> insert into stu41 value(1,'aff');
> -- insert into stu41 (sname) value('aff');  -- 报错
> 
> -- 2
> create table stu42(
> sid int comment '学号',
> sname varchar(20) comment '姓名'
> );
> desc stu42;
> alter table stu42 modify sid int primary key;
> 
> -- 3.删除
> -- 注意1：因为主键非空且唯一，所以删除的时候可以直接drop primary key
> -- 注意2：当删除主键之后，非空约束还存在，如果需要插入null,则可以手动删除非空约束
> alter table stu42 drop primary key; -- 删除主键约束
> alter table stu42 modify sid int;  -- 删除非空约束
> 
> -- 4.主键自增长
> -- 1
> create table stu43(
> sid int primary key auto_increment comment '学号',
> sname varchar(20) comment '姓名'
> );
> desc stu43;
> insert into stu43 value(3,'aaaa');
> insert into  stu43 (sname) value('bbb');
> insert into  stu43 (sname) value('ccc');
> insert into  stu43 (sname) value('eee');
> insert into  stu43 (sname) value('ddd');
> select * from stu43;
> 
> -- 如果删除之前增长的序号，后面再添加的时候序号不会重新开始，而是接着被删除的那一列的序号
> delete from stu43 where sid=7;  -- 删除7
> insert into  stu43 (sname) value('uuu'); -- 再插入数据，并不是7.是8
> 
> -- 2
> create table stu44(
> sid int primary key comment '学号',
> sname varchar(20) comment '姓名'
> );
> alter table stu44 modify sid int auto_increment;
> desc stu44;
> 
> -- 3
> -- 建表的时候，可以设置第一条数据的主键值
> create table stu45(
> sid int primary key auto_increment comment '学号',
> sname varchar(20) comment '姓名'
> )engine=InnoDB auto_increment=6 comment '学生表';   -- sid的初始值为6
> -- 在上述表的基础上，插入数据的时候，就可以不用插入sid的值
> -- insert into stu45 value('aaaa');   -- 报错，不匹配
> insert into stu45 (sname) value('aaaa');
> insert into stu45 (sname) value('ddd');
> insert into stu45 (sname) value('bbb');
> select * from stu45;
> 
> -- 注意：会员号，学号，工号，会员卡号等表示非空且唯一，而且在表中用来作为标识的数据，就可以设置为主键
> -- 根据使用的情况，如果主键为数字类型，则可以设置主键自增长
> ```

#### 2.外键约束foreign key

> 外键约束可以使表与表之间产生关系
>
> 创建表时，添加外键约束
>
> ```sql
> create table 表名 (字段名 字段类型 primary key, 字段名 字段类型 [约束], ... , 外键字段 外键类型 ,[constraint 外键名] foreign key (外键字段) references 主表名 (主表主键字段));
> ```
>
> 创建表后，添加外键约束
>
> ```sql
> alter table 表名 add [constraint 外键名] foreign key (外键字段) references 主表名 (主表主键字段));
> ```
>
> 删除外键约束
>
> ```sql
> alter table 表名 drop foreign key 外键名;   
> ```

> 中间表的创建以及联合主键
>
> ```
> create table 表名 (
> 	外键字段1 外键类型, 外键字段2 外键类型, primary key (外键字段1,外键字段2), 
> 	foreign key (外键字段1) references 主表1(主键字段),
> 	foreign key (外键字段2) references 主表2(主键字段),
> );
> ```

> ```mysql
> -- 外键约束
> -- 1
> -- 注意1：外键约束至少发生在两张表之间
> -- 注意2：需要给a表的某个字段设置主键，给b表中和a表中有关系的字段设置为外键
> -- 比如：student 和 score关系中，在student表中取出一个sid,在score中可能对应这多条数据
> -- student:一   score:多，给student表中的sid设置为主键，给score表中sid设置为外键
> create table stu51(
> sid int primary key auto_increment comment '学号',
> sname varchar(20) comment '姓名',
> age int comment '年龄'
> )auto_increment=1001 comment '学生表';
> desc stu51;
> 
> create table sco51(
> sid int comment '学号',
> cno int comment '课程号',
> score int comment '成绩',
> -- 添加外键：当前表中的sid和stu51表中的sid对应起来
> -- stu_sco_51_sid是外键的名称，可以自定义，但是在同一个数据库中不要重复，建议命名：表1_表2_字段
> constraint stu_sco_51_sid  foreign key(sid) references stu51(sid)
> );
> desc sco51;
> 
> -- 2
> create table stu52(
> sid int  comment '学号',
> sname varchar(20) comment '姓名',
> age int comment '年龄'
> ) comment '学生表';
> 
> create table sco52(
> sid int comment '学号',
> cno int comment '课程号',
> score int comment '成绩'
> )comment '成绩表';
> -- 添加主键
> alter table stu52 modify sid int primary key;
> -- 添加外键
> alter table sco52 add constraint stu_sco_52_sid foreign key(sid) references stu52(sid);
> desc stu52;
> desc sco52;
> 
> -- 3
> -- 注意：一张表中只能有一个主键，但是一张表中可以有多个外键，此时至少需要三张表
> create table stu53(
> sid int primary key  comment '学号',
> sname varchar(20) comment '姓名',
> age int comment '年龄'
> ) comment '学生表';
> 
> create table cou53(
> cno int primary key comment '课程号',
> cname varchar(30) comment '课程名称'
> ) comment '课程表';
> 
> -- 中间表
> create table sco53(
> sid int comment '学号',
> cno int comment '课程号',
> score int comment '成绩',
> constraint stu_sco_53_sid foreign key(sid) references stu53(sid),
> constraint cou_sco_53_cno foreign key(cno) references cou53(cno)
> )comment '成绩表';
> desc stu53;
> desc cou53;
> desc sco53;
> 
> -- 4
> create table stu54(
> sid int  comment '学号',
> sname varchar(20) comment '姓名',
> age int comment '年龄'
> ) comment '学生表';
> 
> create table cou54(
> cno int comment '课程号',
> cname varchar(30) comment '课程名称'
> ) comment '课程表';
> 
> -- 中间表
> create table sco54(
> sid int comment '学号',
> cno int comment '课程号',
> score int comment '成绩'
> )comment '成绩表';
> -- 添加主键
> alter table stu54 modify sid int primary key;
> alter table cou54 modify cno int primary key;
> -- 添加外键
> alter table sco54 add constraint stu_sco_54_sid foreign key(sid) references stu54(sid);
> alter table sco54 add constraint cou_sco_54_cno foreign key(cno) references cou54(cno);
> 
> desc stu54;
> desc cou54;
> desc sco54;
> 
> -- 5.删除外键
> -- 注意：删除外键的时候，需要指明外键的名称，另外，删除之后，desc查看的结果中，MUL标记依然存在
> alter table sco54 drop foreign key cou_sco_54_cno;
> 
> -- 注意：在有主外键关联的情况下，直接删除主键,无法删除，如果非要删除，则需要先解除外键关联
> alter table sco54 drop foreign key stu_sco_54_sid;
> alter table stu54 drop primary key;
> ```
