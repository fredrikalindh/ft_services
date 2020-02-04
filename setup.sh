export MINIKUBE_HOME="/goinfre/frlindh"
minikube start --vm-driver=virtualbox --extra-config=apiserver.service-node-port-range=1-30001

minikube addons enable ingress
minikube addons enable metrics-server

#minikube dashboard
#minikube tunnel

cp srcs/ftps/start2.sh srcs/ftps/start.sh
cp srcs/mysql/wordpress.sql srcs/mysql/wordpress-tmp.sql
cp srcs/grafana/telegraf2.yaml srcs/telegraf.yaml
MINIKUBE_IP=$(minikube ip)
sed -i '' "s/##MINIKUBE_IP##/$MINIKUBE_IP/g" srcs/ftps/start.sh
sed -i '' "s/##MINIKUBE_IP##/$MINIKUBE_IP/g" srcs/mysql/wordpress-tmp.sql
sed -i '' "s/##MINIKUBE_IP##/$MINIKUBE_IP/g" srcs/telegraf.yaml

$BEAR = kubectl describe secret kubernetes-dashboard -n kubernetes-dashboard
sed -i '' "s/##BEAR##/$BEAR/g" srcs/telegraf.yaml



# openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ${KEY_FILE} -out ${CERT_FILE} -subj "/CN=${HOST}/O=${HOST}"
# kubectl create secret tls ${CERT_NAME} --key ${KEY_FILE} --cert ${CERT_FILE}

eval $(minikube docker-env)
docker build -t nginx srcs/nginx/
docker build -t ftps srcs/ftps/
docker build -t wordpress srcs/wordpress/
docker build -t mysql srcs/mysql/
docker build -t grafana srcs/grafana/

rm -f srcs/mysql/wordpress-tmp.sql srcs/ftps/start.sh

kubectl apply -f srcs
kubectl apply -f srcs/mysql.yaml
# kubectl apply -f srcs/phpmyadmin.yaml
# kubectl apply -f srcs/nginx.yaml
# kubectl apply -f srcs/ftps.yaml
# kubectl apply -f srcs/wordpress.yaml
# kubectl apply -f srcs/ingress.yaml
# kubectl apply -f srcs/mysql.yaml


# kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta8/aio/deploy/recommended.yaml
# kubectl -n kubernetes-dashboard describe secret $(kubectl -n kubernetes-dashboard get secret | grep admin-user | awk '{print $1}')
# open http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/
# kubectl proxy
echo "the cluster is now available on"
minikube ip