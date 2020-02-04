FROM alpine
RUN apk update && apk add openrc && apk add openssl &&\
apk add nginx && mkdir /run/nginx && apk --update add --no-cache openssh && rc-update add sshd && echo "root:root" | chpasswd

COPY ./ssh_host_dsa_key /etc/ssh/
COPY ./ssh_host_rsa_key /etc/ssh/
COPY nginx.conf /etc/nginx/
COPY sshd_config /etc/ssh/
COPY index.html /var/www/html/
COPY start.sh .

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/certs/selfsigned.key -out /etc/ssl/certs/selfsigned.crt -subj "/C=FR/ST=75/L=Paris/O=42/CN=frlindh"
EXPOSE 80 443 422
CMD sh start.sh