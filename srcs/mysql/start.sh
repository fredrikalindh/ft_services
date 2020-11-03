mysql_install_db --user=mysql --datadir=${DB_DATA_PATH}
rc-service mariadb restart
mysql -u root mysql < ./mysql.sql
mysql -u root wordpress < ./wordpress.sql
rc-service mariadb stop
exec /usr/bin/mysqld --user=mysql --console --log-error=/data/log/mysql/mysql.err