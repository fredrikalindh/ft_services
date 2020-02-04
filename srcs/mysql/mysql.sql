USE mysql;
CREATE DATABASE wordpress;
GRANT ALL ON *.* TO 'root'@'%' identified by 'password' WITH GRANT OPTION ;
GRANT ALL ON *.* TO 'root'@'localhost' identified by 'password' WITH GRANT OPTION ;
UPDATE mysql.user SET Password=PASSWORD("password") WHERE User="root";
FLUSH PRIVILEGES ;
