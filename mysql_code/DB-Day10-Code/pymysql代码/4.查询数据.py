import  pymysql

def query_data():
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
    with db.cursor() as cursor:
        sql = 'select * from emp;'
        cursor.execute(sql)

        # a.fetchone():获取sql执行完毕后的第一条记录
        # r1 = cursor.fetchone()    # 等价于:select * from emp limit 1;
        # print(r1)

        # b.fetchall():获取sql执行完毕后的所有记录,注意:返回二维元组
        # r2 = cursor.fetchall()
        # print(r2)

        # c.fetchmany(size):获取sql执行完毕止后的size条记录
        r3 = cursor.fetchmany(3)   # select * from emp limit size;
        print(r3)

if __name__ == '__main__':
    query_data()