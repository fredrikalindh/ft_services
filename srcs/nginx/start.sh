chmod 600 /etc/ssh/ssh_host_dsa_key
chmod 600 /etc/ssh/ssh_host_rsa_key

/usr/sbin/sshd
nginx -g 'daemon off;'