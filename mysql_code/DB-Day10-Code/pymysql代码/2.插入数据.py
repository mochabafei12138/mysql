import  pymysql

def insert_data():
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

    # 注意:在mysql中,但凡涉及到DML[insert,update,delete]操作.都涉及到事务的操作
    # 直接书写sql语句时,一般都是隐式事务,但是书写python代码,一定要显式操作事务[commit ,rollback]
    with db.cursor() as cursor:
        try:
            sql = 'insert into stu value(100,1001,"张三","唱歌");'
            cursor.execute(sql)
            # 事务提交
            db.commit()
            print('数据插入成功')
        except Exception as e:
            # 如果sql执行有误,则回滚
            db.rollback()
            print('数据插入失败')

if __name__ == '__main__':
    insert_data()
