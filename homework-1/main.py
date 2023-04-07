"""Скрипт для заполнения данными таблиц в БД Postgres."""
import psycopg2
import os

customers = []
employees = []
orders = []
password = os.getenv('PSQL_pass')

with open('C://Users//KO77-31//Desktop//skypro//SQL//postgres-homeworks//homework-1//north_data//employees_data.csv',
          'r') as file:
    for row in file:
        res = row.split('",')
        red_res =[]
        for item in res:
            item = item.replace('"', '')
            item = item.replace('\n', '')
            item = item.replace("'", '')
            red_res.append(item)
        employees.append(red_res)
    employees = employees[1:len(employees)]


with open('C://Users//KO77-31//Desktop//skypro//SQL//postgres-homeworks//homework-1//north_data//customers_data.csv',
          'r') as file:
    for row in file:
        res = row.split(',')
        red_res =[]
        for item in res:
            item = item.replace('"', '')
            item = item.replace('\n', '')
            item = item.replace("'", '')
            red_res.append(item)
        customers.append(red_res)
    customers = customers[1:len(customers)]

with open('C://Users//KO77-31//Desktop//skypro//SQL//postgres-homeworks//homework-1//north_data//orders_data.csv',
          'r') as file:
    for row in file:
        res = row.split(',')
        red_res =[]
        for item in res:
            item = item.replace('"', '')
            item = item.replace('\n', '')
            item = item.replace("'", '')
            red_res.append(item)
        orders.append(red_res)
    orders = orders[1:len(orders)]

with psycopg2.connect(
    host="localhost",
    database="north1",
    user="postgres",
    password=password
) as conn:
    with conn.cursor() as cur:
        for item in customers:
            cur.execute(f"INSERT INTO customers values ('{item[0]}', '{item[1]}', '{item[2]}')")
        id = 1
        for item in employees:
            cur.execute(f"INSERT INTO employees values ({id}, '{item[0]}', '{item[1]}', '{item[2]}', '{item[3]}', '{item[4]}')")
            id += 1
        for item in orders:
            cur.execute(f"INSERT INTO orders values ('{item[0]}', '{item[1]}', '{item[2]}', '{item[3]}', '{item[4]}')")

