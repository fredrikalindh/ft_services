export MINIKUBE_HOME="/goinfre/frlindh"
minikube start --vm-driver=virtualbox --extra-config=apiserver.service-node-port-range=1-30001

minikube addons enable ingress
minikube addons enable metrics-server
minikube addons enable dashboard

cp srcs/ftps/start2.sh srcs/ftps/start.sh
cp srcs/mysql/wordpress.sql srcs/mysql/wordpress-tmp.sql
cp srcs/grafana/telegraf2.yaml srcs/telegraf.yaml
MINIKUBE_IP=$(minikube ip)
sed -i '' "s/##MINIKUBE_IP##/$MINIKUBE_IP/g" srcs/ftps/start.sh
sed -i '' "s/##MINIKUBE_IP##/$MINIKUBE_IP/g" srcs/mysql/wordpress-tmp.sql

eval $(minikube docker-env)
docker build -t nginx srcs/nginx/
docker build -t ftps srcs/ftps/
docker build -t wordpress srcs/wordpress/
docker build -t mysql srcs/mysql/
docker build -t grafana srcs/grafana/

BEAR=$(kubectl describe secret kubernetes-dashboard -n kubernetes-dashboard | fgrep "token:")
BEAR=$(sed -e 's#.*token:      \(\)#\1#' <<< "$BEAR")
sed -i '' "s/##BEAR##/$BEAR/g" srcs/telegraf.yaml
MINIKUBE_IP=$(minikube ip)
sed -i '' "s/##MINIKUBE_IP##/$MINIKUBE_IP/g" srcs/telegraf.yaml

rm -f srcs/mysql/wordpress-tmp.sql srcs/ftps/start.sh

kubectl apply -f srcs
kubectl apply -f srcs/mysql.yaml

echo "the cluster is now available on"
minikube ip