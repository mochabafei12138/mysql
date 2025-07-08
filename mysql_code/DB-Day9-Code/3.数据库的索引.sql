use stu_sco_cou_db;

show index from tb_student;

-- 通过主键查找【主键：索引键】
explain select * from tb_student where stu_id=1007;  -- row:1

-- 通过普通键查找
explain select * from tb_student where stu_name ='张小六'; -- rows:12

-- 为了提高查找效率，尽量使用索引键进行查找
-- 很多时候用到的键不是索引键，可以后期将其设置为索引键
create index idx_name on tb_student(stu_name);
show index from tb_student;

-- 再去查看建立索引之后的执行计划
explain select * from tb_student where stu_name ='张小六'; -- rows:1

/*
类比：索引相当于书籍的目录，把索引键的值存储于内存中，从内存中找数据的效率就高
*/

-- 前面的操作给姓名字段添加索引，相当于把每个姓名都存储在内存中
-- 最优解法：可以考虑将姓氏存储于内存中，这种索引称为前缀索引

-- 删除原有索引
drop index idx_name on tb_student;

-- 通过形式创建索引
create index idx_name on tb_student(stu_name(1)); -- 文本从1开始
explain select * from tb_student where stu_name ='张小六';

