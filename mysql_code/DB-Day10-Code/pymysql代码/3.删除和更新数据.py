import  pymysql

def update_or_delete_data(sql):
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
            cursor.execute(sql)
            # 事务提交
            db.commit()
            print('数据更新或删除成功')
        except Exception as e:
            # 如果sql执行有误,则回滚
            db.rollback()
            print('数据更新或删除失败')

if __name__ == '__main__':
    # 删除
    # sql = 'delete from emp where deptno=20;'
    # update_or_delete_data(sql)

    # 如果字段原本是个数字,在原数字的基础上增加或减少,如:score = score+10
    sql = 'update emp set extra=100 where extra is null;'
    update_or_delete_data(sql)