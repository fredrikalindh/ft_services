chmod 600 /etc/ssl/private/pure-ftpd.pem

mkdir -p /ftps/$FTP_USER

adduser -h /ftps/$FTP_USER -D $FTP_USER
echo "$FTP_USER:$FTP_PASSWORD" | chpasswd

/usr/sbin/pure-ftpd -Y 2 -p 30001:30001 -P "##MINIKUBE_IP##"