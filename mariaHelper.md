# MariaDB SQL Server

[SQL help page](https://dev.mysql.com/doc/mysql-getting-started/en/#mysql-getting-started-basic-ops)

| topic | Task                        | command                                                        |
| --- | --------------------------- | -------------------------------------------------------------- |
| maria | login                       | sudo mysql -u root -p                                          |
| maria | show existing databases     | SHOW DATABASES;                                                |
| maria | create new database         | CREATE DATABASE _name_;                                        |
| maria | set context                 | USE _name_;                                                    |
| maria | show tables                 | SHOW TABLES;                                                   |
| maria | define table                | create table _name_ (id int unsigned not null auto_increment,  |
| maria |                             | name varchar(50) not null,                                     |
| maria |                             | primary key (id));                                             |
| maria | info for table              | DESCRIBE _name_;                                               |
| maria | add records to table        | insert into greifvogel (name, ruf,schwanz) values              |
| maria |                             | ('Adler','kein','breit'),                                      |
| maria |                             | ('Milan','kein','gabel'),                                      |
| maria |                             | ('Bussard','piae','breit');                                    |
| maria | get records from table      | SELECT name FROM greifvogel WHERE schwanz = 'breit';           |
| maria | delete record               | DELETE FROM greifvogel WHERE name='Adler';                     |
| maria | create user                 | CREATE USER 'python-user'@'%' IDENTIFIED BY 'Password1$';      |
| maria | grant access                | GRANT ALL PRIVILEGES ON greifvoegel . \* TO 'python-user'@'%'; |
| maria | Flush privileges to mariadb | FLUSH PRIVILEGES;                                              |

> MariaDB neu starten: `sudo service mysql restart`


