# -*- coding: utf-8 -*-
import pandas as pd 
from sqlalchemy import create_engine
# pip install pandas==1.2.4
# pip install sqlalchemy==1.4.45
# pip install pymysql   python程序和数据库的连接池

# 连接
engine = create_engine('mysql+pymysql://root:123456@localhost:3306/mydb1?charset=utf8mb4')
# 连接MySQL的第三方库：pymysql
# 用户：root，密码：123456，服务器：localhost，端口号：3306，库名：mydb1，编码格式：utf8

# 创建数据库，库名：net
engine.execute('create database if not exists net;')

channel = pd.read_csv('tb_channel.csv')
region = pd.read_csv('tb_region.csv')
user = pd.read_csv('tb_user.csv')
visit = pd.read_csv('tb_visit.csv')

channel.to_sql('tb_channel', engine, schema='net', index=False, if_exists='replace')
region.to_sql('tb_region', engine, schema='net', index=False, if_exists='replace')
user.to_sql('tb_user', engine, schema='net', index=False, if_exists='replace')
visit.to_sql('tb_visit', engine, schema='net', index=False, if_exists='replace')
