# Домашнее задание к занятию 2. «SQL». https://github.com/netology-code/virt-homeworks/tree/virt-11/06-db-02-sql

## Выполнил Шарафуков Ильшат

### Задание 1: Используя Docker, поднимите инстанс PostgreSQL (версию 12) c 2 volume, в который будут складываться данные БД и бэкапы. Приведите получившуюся команду или docker-compose-манифест.

Развернул инстанс Pgsql 12 версии с помощью docker-compose 2 volume.

![pgsql_docker.png](img/1_1.png)


### Задание 2:
```
В БД из задачи 1:

создайте пользователя test-admin-user и БД test_db;
в БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже);
предоставьте привилегии на все операции пользователю test-admin-user на таблицы БД test_db;
создайте пользователя test-simple-user;
предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE этих таблиц БД test_db.
Таблица orders:

id (serial primary key);
наименование (string);
цена (integer).
Таблица clients:

id (serial primary key);
фамилия (string);
страна проживания (string, index);
заказ (foreign key orders).
Приведите:

итоговый список БД после выполнения пунктов выше;
описание таблиц (describe);
SQL-запрос для выдачи списка пользователей с правами над таблицами test_db;
список пользователей с правами над таблицами test_db.
```

Ответы:

Выполнил все указанные задания:
```
psql --username=postgres --dbname=postgres

create database test_db;

\c test_db

CREATE TABLE orders (
id serial PRIMARY KEY,
name varchar(200) NOT NULL,
price integer NOT NULL);

CREATE TABLE IF NOT EXISTS clients (
id serial PRIMARY KEY,
surname varchar(200) NOT NULL,
country varchar(200) NOT NULL,
orders integer REFERENCES orders (id) NOT NULL);

CREATE ROLE test_admin_user LOGIN PASSWORD 'Zaq12wsx';
CREATE ROLE test_simple_user LOGIN PASSWORD 'Zaq12wsx12';

GRANT ALL PRIVILEGES ON TABLE clients,orders TO test_admin_user;

GRANT SELECT,INSERT,UPDATE,DELETE ON TABLE clients,orders TO test_simple_user;

```
Описание всех таблиц:
![pgsql_table.png](img/2_1.png)

Список всех БД:
![pgsql_db_list.png](img/2_2.png)

SQL-запрос для выдачи списка пользователей с правами над таблицами test_db:
```
SELECT * from information_schema.table_privileges WHERE grantee in ('test_admin_user','test_simple_user') and table_name in ('clients','orders');
```
Список пользователей с правами над таблицами test_db:

![pgsql_user_select.png](img/2_3.png)


