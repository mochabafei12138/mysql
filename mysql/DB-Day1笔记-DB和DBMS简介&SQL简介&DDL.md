## 一、数据库简介

### 1.数据库

> ​	数据库，简单来说，就是数据的仓库，被称为DataBase(简称DB)，指长期保存在计算机的存储设备上，按照一定规则组织起来，可以被各种用户或应用共享的数据集合
>
> ​	与普通的“数据仓库”不同的是，数据库依据“数据结构”来组织数据，因为“数据结构”，所以我们看到的数据是比较“条理化”的
>
> 数据库的本质：存储，维护和管理数据的集合
>
> 简单理解：用于存储数据的地方，可视为存储数据的容器
>
> ```
> 【面试题】数据库的特点及作用
> a.有极高的查询效率
> b.实现数据的共享，减少数据的冗余
> c.数据之间具有较高的独立性
> d.统一管理数据，达到控制数据的目的【约束】
> ```

### 2.数据库管理系统

> ​	DataBase Management System(简称DBMS)，指一种操作和管理数据库的大型软件，用于建立、使用和维护数据库，对数据库进行统一管理和控制，以保证数据库的安全性和完整性，用户通过数据库管理系统访问数据库中的数据
>
> 常见的DBMS:MySQL、oracle、sql server、sqlite、Mongodb、redis等
>

### 3.数据库的发展史

> ```
> 1.用文件来存储数据
>
> 2.层次型数据库
> 	数据结构比较简单清晰，查询效率比较高
> 	现实生活中的数据很多不是具有层次型的 而且不支持多对多的结构的查询
> 	<html>
> 		<head>
> 			<title></title>
> 		</head>
> 		<body></body>
> 	</html>
> 	
> 3.网状型数据库
> 	能够直观的描述现实的一些数据
> 	数据量太大，结构比较复杂的情况，网状的结构数据显得非常的杂乱无章
>
> 4.关系型数据库(MySQL SQLServer Oracle)
> 	体现的是实体和实体之间的关系，实体和实体之间的联系根据实体自身的关系可以进行连接查询，复杂的数据结构的数据分成对应的实体，利用实体和实体之间的联系完成数据结构
> ```

### 4.关系型数据库

> ​	关系型数据库是依据关系模型来创建的数据库，所谓关系模型就是“一对一、一对多、多对多”等关系模型，关系模型就是指二维表格模型,因而一个关系型数据库就是由二维表及其之间的联系组成的一个数据组织，关系模型是我们生活中能经常遇见的模型
>
> ​	MySQL 是一个关系型数据库管理系统，由瑞典 MySQL AB 公司开发，目前属于 Oracle 公司。MySQL 是一种关联数据库管理系统， MySQL 是最流行的关系型数据库管理系统，在 WEB 应用方面，MySQL是最好的 RDBMS (Relational Database Management System，关系数据库管理系统) 应用软件之一。
>
> 关联数据库将数据保存在不同的表中，而不是将所有数据放在一个大仓库内，这样就增加了速度并提高了灵活性。
>
> 使用MySQL的优点：
>
> - MySQL 支持大型的数据库。可以处理拥有上千万条记录的大型数据库。
> - MySQL 使用标准的SQL数据语言形式。
> - MySQL 可以运行于多个系统上，并且支持多种语言。这些编程语言包括C、C++、Python、Java、PHP等。
> - MySQL 支持大型数据库，支持5000万条记录的数据仓库，32位系统表文件最大可支持4GB，64位系统支持最大的表文件为8TB。

## 二、MySQL环境配置【重点】

### 1.下载

> 官网下载地址：https://dev.mysql.com/downloads/mysql/
>
> 1、选择操作系统，直接下载，但是直接下载，可供选择的版本较少
>
> ![安装包下载1](MySQL下载和安装流程\安装包下载1.png)
>
> 2、点击下载之后，可以选择注册Oracle账号，也可以跳过直接下载
>
> ![安装包下载3](MySQL下载和安装流程\安装包下载3.png)
>
> 3、如果要下载其他版本的，则可以点击Archive
>
> ![安装包下载2](MySQL下载和安装流程\安装包下载2.png)
>
> 4、如果官网进不去或龟速下载，则可以使用下面的镜像，速度较快
>
> MySQL国内镜像：http://mirrors.sohu.com/mysql/MySQL-8.0/
>
> ![安装包下载4](MySQL下载和安装流程\安装包下载4.png)

> 5、下载完成后，选择指定目录放置并将压缩包解压即可

### 2.卸载

> 第一步：控制面板-----》卸载程序-----》找到MySQL相关的内容，选中，右键，卸载
>
> 第二步：找到MySQL的安装路径，如：C:\Program Files\MySQL，删除该路径下的所有内容
>
> 第三步：找到C盘下的ProgramData隐藏文件夹，如：C:\ProgramData，删除该路径下的MySQL文件夹
>
> ​	注意：ProgramData是一个隐藏文件夹，很多情况下，隐藏文件或文件夹没有显示，需要显示出来，步骤：选项-----》查看-----》显示隐藏的文件夹，文件和驱动器

### 3.安装

> 注意：
>
> ​	1.从盘符开始的安装目录必须都是纯英文的
>
> ​	2.已经安装完毕，整个过程没有问题，但是登录的时候显示：MySQL 不是内部或外部的命令
>
> ​		原因：未配置mysql的环境变量
>
> ​		解决方案：环境变量-----》将mysql的安装路径下的bin目录添加进去，如：C:\Program Files\MySQL\MySQL Server 8.0\bin
>
> ​	3.卸载旧版本的时候未卸载干净，有遗留
>
> ​	4.电脑/设备用户名为中文

### 4.基本使用

#### 4.1登录数据库

> 登录数据库其实是进入mysql数据库的shell交互环境对其进行管理
>
> 方式一：
>
> ```Python
> mysql -uroot -pxxxx      # 密码显式输入，直接登录
> ```
>
> 方式二：
>
> ```Python
> mysql -u  root -p        # 密码隐式输入，进行登录
> ```
>
> 方式三：
>
> ```Python
> mysql -uroot -p          # 密码隐式输入，进行登录   ********
> ```

> 演示命令：
>
> ```mysql
> C:\Users\19621>mysql -uroot  -p
> Enter password: ******
> Welcome to the MySQL monitor.  Commands end with ; or \g.
> Your MySQL connection id is 15
> Server version: 8.0.30 MySQL Community Server - GPL
> 
> Copyright (c) 2000, 2022, Oracle and/or its affiliates.
> 
> Oracle is a registered trademark of Oracle Corporation and/or its
> affiliates. Other names may be trademarks of their respective
> owners.
> 
> Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.
> 
> mysql>
> ```

#### 4.2退出数据库

> ```Python
> 方式一：quit
> 方式二：exit
>
> #注意：如要再次使用数据库，则需要重新登录
> ```

#### 4.3启动和停止MySQL服务

> ```Python
> net start mysql     # 启动服务
> net stop mysql      # 停止服务
> ```

### 5.问题说明

> 参考博客：https://blog.csdn.net/weixin_42827025/article/details/122173805
>

## 三、SQL概述

### 1.简介

> SQL：结构化查询语言【Structure  Query  Language】
>
> ​	SQL被美国国家标准局（ANSI）确定为关系型数据库语言的美国标准，后来被国际化标准组织（ISO）
>
> ​	各数据库厂商都支持ISO的SQL标准 ------>普通话
>
> ​	各数据库厂商在标准的基础上做了自己的扩展------》方言

### 2.数据库结构

> 数据库服务器，只是在机器上安装了一个数据库管理程序，这个管理程序可以管理多个数据库，一般开发员会针对每一个应用创建一个数据库
>
> 为保存应用中实体的数据，一般会在数据库创建多个表，以保存程序中实体的数据
>

> 1. 数据库中的表相当于代码中的实体类：
>
>    例如：要研究护士这个实体类，在对护士对象进行数据管理时就应该有一张对应的护士表
>
> 2. 数据库中的字段（列）相当于代码中实体类的属性：
>
>    例如：宠物具有寿命属性，在宠物表中就应该定义寿命字段
>
> 3. 根据类创建出的对象相当于数据库表中的一行（一条记录）：
>
>    例如：当我们获取了一个卡车对象时，我们就能够知道该卡车所具有的所有信息；同样当我们查询到一条指定的卡车记录时也就可以明确该卡车的所有信息

### 3.SQL分类【面试题】

> DDL:数据定义语言【Data Definenition Language】
>
> ​	作用：针对数据库，数据表进行创建，修改和删除操作
>
> ​	关键字：create     alter    drop
>
> DML:数据操作语言【Data  Manipulation   Language】
>
> ​	作用：针对表中的记录，字段进行增删改的操作
>
> ​	关键字：insert   update   delete
>
> DQL:数据查询语言【Data Query Language】    *********
>
> ​	作用：针对数据表中的记录，字段进行查询
>
> ​	关键字：select , where , order by ,group by ,limit,having等
>
> DCL：数据控制语言【Data Control Language】
>
> ​	作用：针对数据库的安全级别和访问权限进行控制
>
> ​	关键字：commit,rollback等

## 四、基本使用

### 1.DDL-操作数据库

> 查看已有的数据库：
>
> ```mysql
> show databases;					*******
> ```
>
> 创建数据库【建库】：
>
> ```sql
> create database 库名;
> ```
>
> 创建数据库的同时指定编码格式：
>
> ```Python
> # 注意：编码格式只对当前数据库有效
> # 方式一
> create database 库名 character set 编码格式;
> 
> # 方式二：
> create database 库名 charset 编码格式;
> ```
>
> 判断数据库是否存在，不存在才创建：
>
> ```sql
> create database if not exists 库名;
> ```
>
> 删除数据库【删库】：
>
> **注意：在实际工作中，轻易不要删除数据库**
>
> ```sql
> drop database 库名;
> ```
>
> 判断数据库是否存在，存在才删除：
>
> ```sql
> drop database if exists 库名;
> ```
>
> 修改数据库的编码格式：
>
> ```sql
> alter database 库名 character set 编码格式;
> ```
>
> 查询数据库的创建语句及编码格式：
>
> ```python
> show create database 库名;
> ```
>
> 指定要使用的数据库【连接数据库】，注意：每次打开数据操作之前，一定要先use  xxx;
>
> ```sql
> use 库名;				*******
> ```
>
> 查看当前正在使用的数据库：
>
> ```sql
> select database();     ********
> ```

### 2.DDL-操作数据表

> 注意：严格来说，sql语句应该使用大写，但是大写看起来不方便，所以一般情况下都使用小写
>
> create  / CREATE

#### 2.1基本操作

> 查看当前数据库中所有的表：
>
> ```sql
> show tables;
> ```
>
> 创建表：
>
> ```Python
> create table 表名(字段名 字段类型 [约束], 字段名 字段类型 [约束], ...);
> ```
>
> 判断表是否已存在，不存在才创建：
>
> ```sql
> create table if not exists  表名(字段名 字段类型 [约束], 字段名 字段类型 [约束], ...);
> ```
>
> 创建表，同时指明编码格式
>
> ```Python
> create table xxx () charset=xxx;
> ```
>
> 删除表：
>
> ```Python
> drop table 表名;
> ```
>
> 判断表是否已存在，存在才删除：
>
> ```sql
> drop table if exists 表名;
> ```
>
> 复制表结构：
>
> ```Python
> create table 新表名 like 被复制的表名;
> ```
>
> 查看表格的创建细节:
>
> ```Python
> show create table 表名;
> ```
>
> 查看表结构：
>
> ```sql
> desc 表名;
> ```

> 修改表结构：
>
> 修改表名：
>
> ```python
> alter table 旧表名 rename to 新表名;
> rename table 旧表名 to 新表名;
> ```
>
> 添加新字段
>
> ```Python
> alter table 表名 add 新字段 字段类型 [约束];
> ```
>
> 修改表的字符集为gbk:
>
> ```Python
> alter table 表名 character set 新的编码格式;
> ```
>
> 删除字段
>
> ```Python
> alter table 表名 drop 字段;    
> ```
>
> 修改字段的排列位置:
>
> ```Python
> alter table table_name modify 字段1 数据类型 first|after 字段2
> 	first: 设置成第一个
> 	after 字段2： 在指定字段2的后面
> ```
>
> 修改字段数据类型
>
> ```Python
> alter table 表名 modify 字段 类型; 
> ```
>
> 修改字段名
>
> ```Python
> alter table 表名 change 旧字段名 新字段名 类型;
> # change也可以只修改数据类型，实现与 modify 同样的效果，方法是将 SQL 语句中的新字段与旧字段名相同，只改变数据类型
> ```

#### 2.2数据类型

> ```Python
> 1.数字数据类型
> # - INT - 正常大小的整数，可以带符号。如果是有符号的，它允许的范围是从-2147483648到2147483647。如果是无符号，允许的范围是从0到4294967295。 可以指定多达11位的宽度。
> - TINYINT - 一个非常小的整数，可以带符号。如果是有符号，它允许的范围是从-128到127。如果是无符号，允许的范围是从0到255，可以指定多达4位数的宽度。
> - SMALLINT - 一个小的整数，可以带符号。如果有符号，允许范围为-32768至32767。如果无符号，允许的范围是从0到65535，可以指定最多5位的宽度。
> - MEDIUMINT - 一个中等大小的整数，可以带符号。如果有符号，允许范围为-8388608至8388607。 如果无符号，允许的范围是从0到16777215，可以指定最多9位的宽度。
> - BIGINT - 一个大的整数，可以带符号。如果有符号，允许范围为-9223372036854775808到9223372036854775807。如果无符号，允许的范围是从0到18446744073709551615. 可以指定最多20位的宽度。
> # - FLOAT(M,D) - 不能使用无符号的浮点数字。可以定义显示长度(M)和小数位数(D)。这不是必需的，并且默认为10,2。其中2是小数的位数，10是数字(包括小数)的总数。小数精度可以到24个浮点。
> - DOUBLE(M,D) - 不能使用无符号的双精度浮点数。可以定义显示长度(M)和小数位数(D)。 这不是必需的，默认为16,4，其中4是小数的位数。小数精度可以达到53位的DOUBLE。 REAL是DOUBLE同义词。
> - DECIMAL(M,D) - 非压缩浮点数不能是无符号的。在解包小数，每个小数对应于一个字节。定义显示长度(M)和小数(D)的数量是必需的。 NUMERIC是DECIMAL的同义词。
>
> 2.日期和时间类型
> # - DATE - 以YYYY-MM-DD格式的日期，在1000-01-01和9999-12-31之间。 例如，1973年12月30日将被存储为1973-12-30。
> - DATETIME - 日期和时间组合以YYYY-MM-DD HH:MM:SS格式，在1000-01-01 00:00:00 到9999-12-31 23:59:59之间。例如，1973年12月30日下午3:30，会被存储为1973-12-30 15:30:00。
> - TIMESTAMP - 1970年1月1日午夜之间的时间戳，到2037的某个时候。这看起来像前面的DATETIME格式，无需只是数字之间的连字符; 1973年12月30日下午3点30分将被存储为19731230153000(YYYYMMDDHHMMSS)。
> - TIME - 存储时间在HH:MM:SS格式。
> - YEAR(M) - 以2位或4位数字格式来存储年份。如果长度指定为2(例如YEAR(2))，年份就可以为1970至2069(70〜69)。如果长度指定为4，年份范围是1901-2155，默认长度为4。
>
> 3.字符串类型
> 虽然数字和日期类型比较有意思，但存储大多数数据都可能是字符串格式。 下面列出了在MySQL中常见的字符串数据类型。
> - CHAR(M) - 固定长度的字符串是以长度为1到255之间个字符长度(例如：CHAR(5))，存储右空格填充到指定的长度。 限定长度不是必需的，它会默认为1。
> # - VARCHAR(M) - 可变长度的字符串是以长度为1到255之间字符数(高版本的MySQL超过255); 例如： VARCHAR(25). 创建VARCHAR类型字段时，必须定义长度。
> # - BLOB or TEXT - 字段的最大长度是65535个字符。 BLOB是“二进制大对象”，并用来存储大的二进制数据，如图像或其他类型的文件。定义为TEXT文本字段还持有大量的数据; 两者之间的区别是，排序和比较上存储的数据，BLOB大小写敏感，而TEXT字段不区分大小写。不用指定BLOB或TEXT的长度。
> - TINYBLOB 或 TINYTEXT - BLOB或TEXT列用255个字符的最大长度。不指定TINYBLOB或TINYTEXT的长度。
> - MEDIUMBLOB or MEDIUMTEXT - BLOB或TEXT列具有16777215字符的最大长度。不指定MEDIUMBLOB或MEDIUMTEXT的长度。
> - LONGBLOB 或 LONGTEXT -  BLOB或TEXT列具有4294967295字符的最大长度。不指定LONGBLOB或LONGTEXT的长度。
> - ENUM - 枚举，这是一个奇特的术语列表。当定义一个ENUM，要创建它的值的列表，这些是必须用于选择的项(也可以是NULL)。例如，如果想要字段包含“A”或“B”或“C”，那么可以定义为ENUM为 ENUM(“A”，“B”，“C”)也只有这些值(或NULL)才能用来填充这个字段。
> ```
>
> 【面试题】主要掌握char 和 varchar 的区别
>
> ```
> char(M)是固定长度的字符串， 在定义时指定字符串列长。当保存数据时如果长度不够在右侧填充空格以达到指定的长度。M 表示列的长度，M 的取值范围是0-255个字符
> 如：char(100) ，假设存储的是abc ，这个内容只需要3个字节，但是开辟内存的时候依然开辟的是5个字节，存储的时候如果存储的内容小于指定的字节个数的，会在内容的末尾添加空格到达指定的字节长度然后进行保存，取出数据的时候会把数据末尾的空格去除之后再返回数据
>
> varchar(M)是长度可变的字符串，M 表示最大的列长度。M 的取值范围是0-65535。varchar的最大实际长度是由最长的行的大小和使用的字符集确定的，而实际占用的空间为字符串的实际长度+1
> 如：varchar(100)，存储的是abc，这个内容只需要3个字节，开辟的时候4个字节
> ```

>  演示命令：
>
> ```mysql
> mysql> show databases;
> +--------------------+
> | Database           |
> +--------------------+
> | information_schema |
> | mysql              |
> | performance_schema |
> | sys                |
> +--------------------+
> 4 rows in set (0.00 sec)
> 
> mysql> create database mydb1;
> Query OK, 1 row affected (0.00 sec)
> 
> mysql> show databases;
> +--------------------+
> | Database           |
> +--------------------+
> | information_schema |
> | mydb1              |
> | mysql              |
> | performance_schema |
> | sys                |
> +--------------------+
> 5 rows in set (0.00 sec)
> 
> mysql> create database mydb2 charset gbk
>     -> ;
> Query OK, 1 row affected (0.00 sec)
> 
> mysql> show databases;
> +--------------------+
> | Database           |
> +--------------------+
> | information_schema |
> | mydb1              |
> | mydb2              |
> | mysql              |
> | performance_schema |
> | sys                |
> +--------------------+
> 6 rows in set (0.00 sec)
> 
> mysql> show create database mydb1;
> +----------+---------------------------------------------------------------------------------------------------------------------------------+
> | Database | Create Database
>                                                    |
> +----------+---------------------------------------------------------------------------------------------------------------------------------+
> | mydb1    | CREATE DATABASE `mydb1` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */ |
> +----------+---------------------------------------------------------------------------------------------------------------------------------+
> 1 row in set (0.00 sec)
> 
> mysql> show create database mydb2;
> +----------+--------------------------------------------------------------------------------------------------+
> | Database | Create Database
>                     |
> +----------+--------------------------------------------------------------------------------------------------+
> | mydb2    | CREATE DATABASE `mydb2` /*!40100 DEFAULT CHARACTER SET gbk */ /*!80016 DEFAULT ENCRYPTION='N' */ |
> +----------+--------------------------------------------------------------------------------------------------+
> 1 row in set (0.00 sec)
> 
> mysql> drop database mydb2;
> Query OK, 0 rows affected (0.00 sec)
> 
> mysql> show databases;
> +--------------------+
> | Database           |
> +--------------------+
> | information_schema |
> | mydb1              |
> | mysql              |
> | performance_schema |
> | sys                |
> +--------------------+
> 5 rows in set (0.00 sec)
> 
> mysql> create database mydb2 charset gbk;
> Query OK, 1 row affected (0.01 sec)
> 
> mysql> show create database mydb2;
> +----------+--------------------------------------------------------------------------------------------------+
> | Database | Create Database
>                     |
> +----------+--------------------------------------------------------------------------------------------------+
> | mydb2    | CREATE DATABASE `mydb2` /*!40100 DEFAULT CHARACTER SET gbk */ /*!80016 DEFAULT ENCRYPTION='N' */ |
> +----------+--------------------------------------------------------------------------------------------------+
> 1 row in set (0.00 sec)
> 
> mysql> alter database mydb2 character set utf8mb4;
> Query OK, 1 row affected (0.00 sec)
> 
> mysql> show create database mydb2;
> +----------+---------------------------------------------------------------------------------------------------------------------------------+
> | Database | Create Database
>                                                    |
> +----------+---------------------------------------------------------------------------------------------------------------------------------+
> | mydb2    | CREATE DATABASE `mydb2` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */ |
> +----------+---------------------------------------------------------------------------------------------------------------------------------+
> 1 row in set (0.00 sec)
> 
> mysql> show databases;
> +--------------------+
> | Database           |
> +--------------------+
> | information_schema |
> | mydb1              |
> | mydb2              |
> | mysql              |
> | performance_schema |
> | sys                |
> +--------------------+
> 6 rows in set (0.00 sec)
> 
> mysql> select database();
> +------------+
> | database() |
> +------------+
> | NULL       |
> +------------+
> 1 row in set (0.00 sec)
> 
> mysql> use mydb1;
> Database changed
> mysql> select database();
> +------------+
> | database() |
> +------------+
> | mydb1      |
> +------------+
> 1 row in set (0.00 sec)
> 
> mysql> show tables;
> Empty set (0.01 sec)
> 
> mysql> create table user(
>     -> uid int,
>     -> uname varchar(10),
>     -> salary float,
>     -> hobby varchar(20)
>     -> );
> Query OK, 0 rows affected (0.02 sec)
> 
> mysql> show tables;
> +-----------------+
> | Tables_in_mydb1 |
> +-----------------+
> | user            |
> +-----------------+
> 1 row in set (0.00 sec)
> 
> mysql> create table worker like user;
> Query OK, 0 rows affected (0.02 sec)
> 
> mysql> show tables;
> +-----------------+
> | Tables_in_mydb1 |
> +-----------------+
> | user            |
> | worker          |
> +-----------------+
> 2 rows in set (0.00 sec)
> 
> mysql> desc user;
> +--------+-------------+------+-----+---------+-------+
> | Field  | Type        | Null | Key | Default | Extra |
> +--------+-------------+------+-----+---------+-------+
> | uid    | int         | YES  |     | NULL    |       |
> | uname  | varchar(10) | YES  |     | NULL    |       |
> | salary | float       | YES  |     | NULL    |       |
> | hobby  | varchar(20) | YES  |     | NULL    |       |
> +--------+-------------+------+-----+---------+-------+
> 4 rows in set (0.00 sec)
> 
> mysql> desc worker;
> +--------+-------------+------+-----+---------+-------+
> | Field  | Type        | Null | Key | Default | Extra |
> +--------+-------------+------+-----+---------+-------+
> | uid    | int         | YES  |     | NULL    |       |
> | uname  | varchar(10) | YES  |     | NULL    |       |
> | salary | float       | YES  |     | NULL    |       |
> | hobby  | varchar(20) | YES  |     | NULL    |       |
> +--------+-------------+------+-----+---------+-------+
> 4 rows in set (0.00 sec)
> 
> mysql> show create table user;
> +-------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
> | Table | Create Table
> 
>                                                |
> +-------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
> | user  | CREATE TABLE `user` (
>   `uid` int DEFAULT NULL,
>   `uname` varchar(10) DEFAULT NULL,
>   `salary` float DEFAULT NULL,
>   `hobby` varchar(20) DEFAULT NULL
> ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci |
> +-------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
> 1 row in set (0.00 sec)
> 
> mysql> alter table user rename to stu;
> Query OK, 0 rows affected (0.01 sec)
> 
> mysql> show tables;
> +-----------------+
> | Tables_in_mydb1 |
> +-----------------+
> | stu             |
> | worker          |
> +-----------------+
> 2 rows in set (0.00 sec)
> 
> mysql> alter table stu add score int;
> Query OK, 0 rows affected (0.01 sec)
> Records: 0  Duplicates: 0  Warnings: 0
> 
> mysql> desc stu;
> +--------+-------------+------+-----+---------+-------+
> | Field  | Type        | Null | Key | Default | Extra |
> +--------+-------------+------+-----+---------+-------+
> | uid    | int         | YES  |     | NULL    |       |
> | uname  | varchar(10) | YES  |     | NULL    |       |
> | salary | float       | YES  |     | NULL    |       |
> | hobby  | varchar(20) | YES  |     | NULL    |       |
> | score  | int         | YES  |     | NULL    |       |
> +--------+-------------+------+-----+---------+-------+
> 5 rows in set (0.00 sec)
> 
> mysql> alter table stu drop salary;
> Query OK, 0 rows affected (0.01 sec)
> Records: 0  Duplicates: 0  Warnings: 0
> 
> mysql> desc stu;
> +-------+-------------+------+-----+---------+-------+
> | Field | Type        | Null | Key | Default | Extra |
> +-------+-------------+------+-----+---------+-------+
> | uid   | int         | YES  |     | NULL    |       |
> | uname | varchar(10) | YES  |     | NULL    |       |
> | hobby | varchar(20) | YES  |     | NULL    |       |
> | score | int         | YES  |     | NULL    |       |
> +-------+-------------+------+-----+---------+-------+
> 4 rows in set (0.00 sec)
> 
> mysql> alter table stu modify score int first;
> Query OK, 0 rows affected (0.02 sec)
> Records: 0  Duplicates: 0  Warnings: 0
> 
> mysql> desc stu;
> +-------+-------------+------+-----+---------+-------+
> | Field | Type        | Null | Key | Default | Extra |
> +-------+-------------+------+-----+---------+-------+
> | score | int         | YES  |     | NULL    |       |
> | uid   | int         | YES  |     | NULL    |       |
> | uname | varchar(10) | YES  |     | NULL    |       |
> | hobby | varchar(20) | YES  |     | NULL    |       |
> +-------+-------------+------+-----+---------+-------+
> 4 rows in set (0.00 sec)
> 
> mysql> alter table stu modify hobby varchar(20) after uid;
> Query OK, 0 rows affected (0.02 sec)
> Records: 0  Duplicates: 0  Warnings: 0
> 
> mysql> desc stu;
> +-------+-------------+------+-----+---------+-------+
> | Field | Type        | Null | Key | Default | Extra |
> +-------+-------------+------+-----+---------+-------+
> | score | int         | YES  |     | NULL    |       |
> | uid   | int         | YES  |     | NULL    |       |
> | hobby | varchar(20) | YES  |     | NULL    |       |
> | uname | varchar(10) | YES  |     | NULL    |       |
> +-------+-------------+------+-----+---------+-------+
> 4 rows in set (0.00 sec)
> 
> mysql> alter table stu change uname username varchar(10);
> Query OK, 0 rows affected (0.01 sec)
> Records: 0  Duplicates: 0  Warnings: 0
> 
> mysql> desc stu;
> +----------+-------------+------+-----+---------+-------+
> | Field    | Type        | Null | Key | Default | Extra |
> +----------+-------------+------+-----+---------+-------+
> | score    | int         | YES  |     | NULL    |       |
> | uid      | int         | YES  |     | NULL    |       |
> | hobby    | varchar(20) | YES  |     | NULL    |       |
> | username | varchar(10) | YES  |     | NULL    |       |
> +----------+-------------+------+-----+---------+-------+
> 4 rows in set (0.00 sec)
> 
> mysql>
> ```