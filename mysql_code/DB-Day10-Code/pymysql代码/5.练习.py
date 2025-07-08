import  pymysql

# 1.Python---->mysql
# Python:定义类---->mysql:建表
class Person():
    def __init__(self,pid,name,age):
        self.pid = pid
        self.name = name
        self.age = age
    def __str__(self):
        return f'{self.pid}-{self.name}-{self.age}'

# Python:创建对象---->mysql:插入数据
p1 = Person('1001','aaa',10)
p2 = Person('1002','bbb',20)

def func1():
    db = pymysql.connect(
        host='localhost',  # 127.0.0.1,数据库服务器地址
        port=3306,  # 端口号
        user='root',  # 用户名
        password='123456',  # 密码
        database='mydb1'  # 数据库名称
    )
    print('数据库成功~~~~~~')
    with db.cursor() as cursor:
        sql = """create table person(
        pid varchar(4) primary key comment '用户id',
        name varchar(20) comment '姓名',
        age int comment '年龄'
        );
        """
        cursor.execute(sql)

        # 插入
        try:
            sql = 'insert into person value(%s,%s,%s);'
            cursor.execute(sql,[p1.pid,p1.name,p1.age])
            # 事务提交
            db.commit()
            print('数据插入成功')
        except Exception as e:
            # 如果sql执行有误,则回滚
            db.rollback()
            print('数据插入失败')


# 2.mysql---->Python
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
        sql = 'select * from person;'
        cursor.execute(sql)

        r1 = cursor.fetchone()
        print(r1)

        # 将数据库中获取的数据创建Python中的对象
        p3 = Person(*r1)
        print(p3)

if __name__ == '__main__':
    # func1()
    query_data()