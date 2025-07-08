```
#建学生信息表student
sno
sname 
ssex
sbirthday
#建立成绩表
sno
cno
degree

#添加学生信息
insert into student values('108','曾华','男','1977-09-01','95033');
insert into student values('105','匡明','男','1975-10-02','95031');
insert into student values('107','王丽','女','1976-01-23','95033');
insert into student values('101','李军','男','1976-02-20','95033');
insert into student values('109','王芳','女','1975-02-10','95031');
insert into student values('103','陆君','男','1974-06-03','95031');
#添加成绩表
insert into score values('103','3-245','86');
insert into score values('105','3-245','75');
insert into score values('109','3-245','68');
insert into score values('103','3-105','92');
insert into score values('105','3-105','88');
insert into score values('109','3-105','76');
insert into score values('103','3-105','64');
insert into score values('105','3-105','91');
insert into score values('109','3-105','78');
insert into score values('103','6-166','85');
insert into score values('105','6-166','79');
insert into score values('109','6-166','81');

#1、 查询student表中的所有记录的sname、ssex和class列
#2、 查询学生所有的学号即不重复的sno列
#3、 查询student表的所有记录
#4、查询score表中成绩在60到80之间的所有记录
#5、 查询score表中成绩为85，86或88的记录
#6、 查询student表中“95031”班或性别为“女”的同学记录
#7、 以class降序查询Student表的所有记录
#8、 以cno升序、degree降序查询score表的所有记录
#9、 查询“95031”班的学生人数
#10、查询score表中的最高分的学生学号和课程号
#11、查询每门课的平均成绩
#12、查询score表中至少有5名学生选修的并以3开头的课程的平均分数
#13、查询分数大于70，小于90的sno列
```

