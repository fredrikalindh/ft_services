FROM alpine

ENV DB_DATA_PATH="/var/lib/mysql"
ENV DB_ROOT_PASS="mariadb_root_password"
ENV DB_USER="mariadb_user"
ENV DB_PASS="mariadb_user_password"
ENV MAX_ALLOWED_PACKET="200M"

COPY start.sh .
COPY mysql.sql .
COPY wordpress-tmp.sql ./wordpress.sql
RUN apk update \
	&& apk add openrc \
	&& apk add mariadb mariadb-client
RUN mv /etc/my.cnf.d/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf.def
COPY my.cnf etc/my.cnf.d/mariadb-server.cnf

RUN	openrc boot
RUN chmod 755 start.sh
EXPOSE 3306
CMD sh start.sh
