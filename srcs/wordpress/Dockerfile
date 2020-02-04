FROM alpine
RUN apk update && apk add lighttpd php7-common php7-iconv php7-json php7-gd php7-curl php7-xml php7-mysqli php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap php7-ctype php7-dom nginx mysql-client openrc php7-fpm curl

RUN mkdir -p /var/www/html/
RUN mkdir -p /etc/nginx
COPY nginx.conf /etc/nginx/nginx.conf
COPY start.sh .
RUN curl -O https://wordpress.org/latest.tar.gz && tar xf latest.tar.gz && rm latest.tar.gz && mv wordpress /var/www/html/
COPY ./wp-config.php /var/www/html/wordpress
EXPOSE 80
CMD sh ./start.sh