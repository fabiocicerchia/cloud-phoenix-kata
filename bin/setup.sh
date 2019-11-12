#!/bin/sh

K8S_NS="cloud-phoenix-kata"

helm init --wait
helm install --name metrics-server stable/metrics-server --version 2.8.8 --set args={"--kubelet-insecure-tls,--kubelet-preferred-address-types=InternalIP"}

kubectl create namespace $K8S_NS

helm repo add bitnami https://charts.bitnami.com/bitnami
helm install --namespace $K8S_NS --name endpoint-node -f conf/k8s/values.yaml bitnami/node

kubectl apply --namespace $K8S_NS -f conf/k8s/autoscale.yaml
kubectl apply --namespace $K8S_NS -f conf/k8s/ingress.yaml

INGRESS_IP=`kubectl describe ingress endpoint-ingress | grep "Address:" | awk '{ print $2 }'`
if [ -z $NO_PORT_FORWARD ]; then
    sudo kubectl port-forward --namespace $K8S_NS ing/endpoint-ingress 80:80
    INGRESS_IP="127.0.0.1"
fi

echo "APP available at: http://$INGRESS_IP/"
