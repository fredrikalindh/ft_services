chmod 600 /etc/ssl/private/pure-ftpd.pem
[ -z "$FTP_USER" ] && FTP_USER=admin
[ -z "$FTP_PASSWORD" ] && FTP_PASSWORD=admin

adduser -D "$FTP_USER"
adduser -D "frlindh"
echo "$FTP_USER:$FTP_PASSWORD" | chpasswd
echo "frlindh:password" | chpasswd
echo "user:password = $FTP_USER:$FTP_PASSWORD"

/usr/sbin/pure-ftpd -Y 2 -p 30001:30001 -P "##MINIKUBE_IP##"