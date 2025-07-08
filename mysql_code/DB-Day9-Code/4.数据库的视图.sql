
-- with 将查询语句的结果制作成一个临时表，查询完成之后 表被销毁了
with avg_score as (select course_id,avg(score) avgs from tb_score group by course_id)
select * from tb_student join tb_score join avg_score
on tb_student.stu_id=tb_score.stu_id and tb_score.course_id=avg_score.course_id
where score<avgs;

-- 报错：不存在
-- select * from avg_score;

-- 可以把查询的结果设置为视图。可以反复使用
-- 视图相当于是原表的快捷方式【快照】，如果表中的数据发生更高，视图也会随着更改
create view v_avgs_score as (select course_id,avg(score) avgs from tb_score group by course_id);

-- 查询视图
select * from v_avgs_score;
select * from v_avgs_score where avgs<70;

-- 使用场景：把公开的数据制作为视图
create view v_stu as (select stu_id,stu_name from tb_student);
select * from v_stu;

-- 允许其他用户访问
grant select on stu_sco_cou_db.v_stu to qianfeng@'127.0.0.1';
