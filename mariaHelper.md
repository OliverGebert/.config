# MariaDB SQL Server

[SQL help page](https://dev.mysql.com/doc/mysql-getting-started/en/#mysql-getting-started-basic-ops)

| topic | command                                                        | Task                        |
| --- | -------------------------------------------------------------- | --------------------------- |
| maria | sudo service mysql restart | restart maria db |
| maria | sudo mysql -u root -p                                          | login                       |
| maria | SHOW DATABASES;                                                | show existing databases     |
| maria | CREATE DATABASE _name_;                                        | create new database         |
| maria | USE _name_;                                                    | set context                 |
| maria | SHOW TABLES;                                                   | show tables                 |
| maria | create table _name_ (id int unsigned not null auto_increment,  | define table                |
| maria | name varchar(50) not null,                                     | "define table               |
| maria | primary key (id));                                             | "define table               |
| maria | DESCRIBE _name_;                                               | info for table              |
| maria | insert into greifvogel (name, ruf,schwanz) values              | add records to table        |
| maria | ('Adler','kein','breit'),                                      | "add records to table       |
| maria | ('Milan','kein','gabel'),                                      | "add records to table     |
| maria | ('Bussard','piae','breit');                                    | "add records to table      |
| maria | SELECT name FROM greifvogel WHERE schwanz = 'breit';           | get records from table      |
| maria | DELETE FROM greifvogel WHERE name='Adler';                     | delete record               |
| maria | CREATE USER 'python-user'@'%' IDENTIFIED BY 'Password1$';      | create user                 |
| maria | GRANT ALL PRIVILEGES ON greifvoegel . \* TO 'python-user'@'%'; | grant access                |
| maria | FLUSH PRIVILEGES;                                              | Flush privileges to mariadb |
