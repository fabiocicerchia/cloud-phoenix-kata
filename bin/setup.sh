#!/bin/sh

helm init --wait

helm install --name metrics-server stable/metrics-server --version 2.8.8 --set args={"--kubelet-insecure-tls,--kubelet-preferred-address-types=InternalIP"}
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install --name cloud-phoenix-kata -f k8s/values.yaml bitnami/node

kubectl apply -f k8s/autoscale.yaml

if [ -z $NO_PORT_FORWARD ]; then
    sudo kubectl port-forward --namespace default svc/cloud-phoenix-kata-node 80:80
fi
