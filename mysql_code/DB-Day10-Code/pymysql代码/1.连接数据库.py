import  pymysql

# 方式一
def connect_mysql():
    # 1.连接数据库
    db = pymysql.connect(
        host='localhost',      # 127.0.0.1,数据库服务器地址
        port=3306,    # 端口号
        user='root',        # 用户名
        password='123456',   # 密码
        database='mydb1'    # 数据库名称
    )
    print('数据库成功~~~~~~')

    # 2.获取数据库游标，注意：相当于一个指针，可以从数据表中的一行移动到下一行
    cursor = db.cursor()
    # 3.执行sql语句
    sql = 'select year(now());'
    cursor.execute(sql)
    # 4.获取查询结果
    r = cursor.fetchall()
    print(r)
    # 5.关闭数据库，类似于文件读写之后关闭文件的操作
    db.close()

# 方式二
def connect_mysql2():
    # 1.将需要的内容定义为字典
    info_dict = {
        'host':'localhost',
        'port':3306,
        'user':'root',
        'password':'123456',
        'database':'mydb1'
    }
    db = pymysql.Connection(**info_dict)
    print('数据库连接成功~~~~~')

    # 用with简化操作,最后无需手动关闭数据库
    with db.cursor() as cursor:
        sql = 'select year(now());'
        cursor.execute(sql)
        r = cursor.fetchall()
        print(r)


if __name__ == '__main__':
    connect_mysql2()


# 复习：打包和拆包
def a(a,b,c,d):
    print(a,b,c,d)
def f1(*num):
    print(num)   # 打包：元组
    a(*num)    # 拆包
f1(34,78,7,9)


def b(x,y,z):
    print(x,y,z)
def f2(**num):
    print(num)   # 打包：字典
    b(**num)     # 拆包
f2(x=10,y=20,z=30)