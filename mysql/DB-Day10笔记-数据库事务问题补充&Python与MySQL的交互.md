### 一、数据库事务问题补充说明

> 原因：同时在workbench和cmd中在同一个节点处开启了事务，导致被锁住了
>
> 解决方案：只在其中一个工具中操作就没问题

### 注意：视频中出现的【函数和存储过程】在下节课继续讲解

### 二、MySQL和Python的交互【重点掌握】

#### 1.概念

> 为了实现MySQL和Python的交互，则需要使用第三方模块pymysql
>
> pymysql模块相当于从Python连接到mysql数据库服务器的接口，并包含了mysql的客户端

#### 2.准备工作

> 注意：在终端中安装和卸载第三方模块
>
> a.安装和卸载
>
> ​	安装pymysql:  pip   intsall     pymysql       注意:mac下使用pip3
>
> ​	卸载pymysql : pip  uninstall   pymysql 
>
> ```
> 说明：
> 	a.在windows的cmd中，直接使用pip  install xxx安装第三方模块，如果速度较慢，可以借助于国内镜像，使用命令：pip  install xxx  -i  镜像
> 	b.常用的国内镜像：
> 	  1）阿里云 http://mirrors.aliyun.com/pypi/simple/
> 	（2）豆瓣http://pypi.douban.com/simple/
> 	（3）清华大学 https://pypi.tuna.tsinghua.edu.cn/simple/
> 	（4）中国科学技术大学 http://pypi.mirrors.ustc.edu.cn/simple/
> 	（5）华中科技大学http://pypi.hustunique.com/
>     c.pip list和pip freeze查看当前python环境中安装的第三方模块
>     d.在cmd中执行python，报错：python不是内部或外部的命令，则表示python未设置环境变量
>     e.如果已经设置了python的环境变量，pip命令仍然不能使用，则需要单独安装pip
>     f.如果当前pip版本较低，则可以在cmd中执行pip install --upgrade pip更新pip
> ```

#### 3.实现

##### 3.1连接数据库

> 在连接到MySQL数据库之前，请确保以下几点：
>
> ​	a.已经创建了一个数据库：如`testdb`。
>
> ​	b.已经在`testdb`中创建了一个表:如`student`。
>
> ​		`student`表格包含字段,:如`id`，`name`，`age`，`sex`字段。
>
> ​	c.MySQL用户名“root”和密码“root”可以访问：`testdb`。
>
> ​	d.Python模块PyMySQL已正确安装在您的计算机上
>
> ```Python
> import  pymysql
> 
> # 方式一
> def connect_mysql():
>     # 1.连接数据库
>     db = pymysql.connect(
>         host='localhost',      # 127.0.0.1,数据库服务器地址
>         port=3306,    # 端口号
>         user='root',        # 用户名
>         password='123456',   # 密码
>         database='mydb1'    # 数据库名称
>     )
>     print('数据库成功~~~~~~')
> 
>     # 2.获取数据库游标，注意：相当于一个指针，可以从数据表中的一行移动到下一行
>     cursor = db.cursor()
>     # 3.执行sql语句
>     sql = 'select year(now());'
>     cursor.execute(sql)
>     # 4.获取查询结果
>     r = cursor.fetchall()
>     print(r)
>     # 5.关闭数据库，类似于文件读写之后关闭文件的操作
>     db.close()
> 
> # 方式二
> def connect_mysql2():
>     # 1.将需要的内容定义为字典
>     info_dict = {
>         'host':'localhost',
>         'port':3306,
>         'user':'root',
>         'password':'123456',
>         'database':'mydb1'
>     }
>     db = pymysql.Connection(**info_dict)
>     print('数据库连接成功~~~~~')
> 
>     # 用with简化操作,最后无需手动关闭数据库
>     with db.cursor() as cursor:
>         sql = 'select year(now());'
>         cursor.execute(sql)
>         r = cursor.fetchall()
>         print(r)
> 
> 
> if __name__ == '__main__':
>     connect_mysql2()
> 
> 
> # 复习：打包和拆包
> def a(a,b,c,d):
>     print(a,b,c,d)
> def f1(*num):
>     print(num)   # 打包：元组
>     a(*num)    # 拆包
> f1(34,78,7,9)
> 
> 
> def b(x,y,z):
>     print(x,y,z)
> def f2(**num):
>     print(num)   # 打包：字典
>     b(**num)     # 拆包
> f2(x=10,y=20,z=30)
> ```

##### 3.2插入数据

> ```Python
> import  pymysql
> 
> def insert_data():
>     # 1.连接数据库
>     db = pymysql.connect(
>         host='localhost',      # 127.0.0.1,数据库服务器地址
>         port=3306,    # 端口号
>         user='root',        # 用户名
>         password='123456',   # 密码
>         database='mydb1'    # 数据库名称
>     )
>     print('数据库成功~~~~~~')
> 
>     # 2.获取数据库游标，注意：相当于一个指针，可以从数据表中的一行移动到下一行
> 
>     # 注意:在mysql中,但凡涉及到DML[insert,update,delete]操作.都涉及到事务的操作
>     # 直接书写sql语句时,一般都是隐式事务,但是书写python代码,一定要显式操作事务[commit ,rollback]
>     with db.cursor() as cursor:
>         try:
>             sql = 'insert into stu value(100,1001,"张三","唱歌");'
>             cursor.execute(sql)
>             # 事务提交
>             db.commit()
>             print('数据插入成功')
>         except Exception as e:
>             # 如果sql执行有误,则回滚
>             db.rollback()
>             print('数据插入失败')
> 
> if __name__ == '__main__':
>     insert_data()
> 
> ```

##### 3.3删除数据和修改数据

> ```Python
> import  pymysql
> 
> def update_or_delete_data(sql):
>     # 1.连接数据库
>     db = pymysql.connect(
>         host='localhost',      # 127.0.0.1,数据库服务器地址
>         port=3306,    # 端口号
>         user='root',        # 用户名
>         password='123456',   # 密码
>         database='mydb1'    # 数据库名称
>     )
>     print('数据库成功~~~~~~')
> 
>     # 2.获取数据库游标，注意：相当于一个指针，可以从数据表中的一行移动到下一行
> 
>     # 注意:在mysql中,但凡涉及到DML[insert,update,delete]操作.都涉及到事务的操作
>     # 直接书写sql语句时,一般都是隐式事务,但是书写python代码,一定要显式操作事务[commit ,rollback]
>     with db.cursor() as cursor:
>         try:
>             cursor.execute(sql)
>             # 事务提交
>             db.commit()
>             print('数据更新或删除成功')
>         except Exception as e:
>             # 如果sql执行有误,则回滚
>             db.rollback()
>             print('数据更新或删除失败')
> 
> if __name__ == '__main__':
>     # 删除
>     # sql = 'delete from emp where deptno=20;'
>     # update_or_delete_data(sql)
> 
>     # 如果字段原本是个数字,在原数字的基础上增加或减少,如:score = score+10
>     sql = 'update emp set extra=100 where extra is null;'
>     update_or_delete_data(sql)
> ```

##### 3.4查询数据

> ```Python
> import  pymysql
> 
> def query_data():
>     # 1.连接数据库
>     db = pymysql.connect(
>         host='localhost',      # 127.0.0.1,数据库服务器地址
>         port=3306,    # 端口号
>         user='root',        # 用户名
>         password='123456',   # 密码
>         database='mydb1'    # 数据库名称
>     )
>     print('数据库成功~~~~~~')
> 
>     # 2.获取数据库游标，注意：相当于一个指针，可以从数据表中的一行移动到下一行
>     with db.cursor() as cursor:
>         sql = 'select * from emp;'
>         cursor.execute(sql)
> 
>         # a.fetchone():获取sql执行完毕后的第一条记录
>         # r1 = cursor.fetchone()    # 等价于:select * from emp limit 1;
>         # print(r1)
> 
>         # b.fetchall():获取sql执行完毕后的所有记录,注意:返回二维元组
>         # r2 = cursor.fetchall()
>         # print(r2)
> 
>         # c.fetchmany(size):获取sql执行完毕止后的size条记录
>         r3 = cursor.fetchmany(3)   # select * from emp limit size;
>         print(r3)
> 
> if __name__ == '__main__':
>     query_data()
> ```

##### 3.5练习

> ```Python
> import  pymysql
> 
> # 1.Python---->mysql
> # Python:定义类---->mysql:建表
> class Person():
>     def __init__(self,pid,name,age):
>         self.pid = pid
>         self.name = name
>         self.age = age
>     def __str__(self):
>         return f'{self.pid}-{self.name}-{self.age}'
> 
> # Python:创建对象---->mysql:插入数据
> p1 = Person('1001','aaa',10)
> p2 = Person('1002','bbb',20)
> 
> def func1():
>     db = pymysql.connect(
>         host='localhost',  # 127.0.0.1,数据库服务器地址
>         port=3306,  # 端口号
>         user='root',  # 用户名
>         password='123456',  # 密码
>         database='mydb1'  # 数据库名称
>     )
>     print('数据库成功~~~~~~')
>     with db.cursor() as cursor:
>         sql = """create table person(
>         pid varchar(4) primary key comment '用户id',
>         name varchar(20) comment '姓名',
>         age int comment '年龄'
>         );
>         """
>         cursor.execute(sql)
> 
>         # 插入
>         try:
>             sql = 'insert into person value(%s,%s,%s);'
>             cursor.execute(sql,[p1.pid,p1.name,p1.age])
>             # 事务提交
>             db.commit()
>             print('数据插入成功')
>         except Exception as e:
>             # 如果sql执行有误,则回滚
>             db.rollback()
>             print('数据插入失败')
> 
> 
> # 2.mysql---->Python
> def query_data():
>     # 1.连接数据库
>     db = pymysql.connect(
>         host='localhost',      # 127.0.0.1,数据库服务器地址
>         port=3306,    # 端口号
>         user='root',        # 用户名
>         password='123456',   # 密码
>         database='mydb1'    # 数据库名称
>     )
>     print('数据库成功~~~~~~')
> 
>     # 2.获取数据库游标，注意：相当于一个指针，可以从数据表中的一行移动到下一行
>     with db.cursor() as cursor:
>         sql = 'select * from person;'
>         cursor.execute(sql)
> 
>         r1 = cursor.fetchone()
>         print(r1)
> 
>         # 将数据库中获取的数据创建Python中的对象
>         p3 = Person(*r1)
>         print(p3)
> 
> if __name__ == '__main__':
>     # func1()
>     query_data()
> ```

