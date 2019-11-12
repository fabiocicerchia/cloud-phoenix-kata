#!/bin/sh

export $(grep -v '^#' .env | xargs)

docker build -t $ECR_REPO/fabiocicerchia-base-cloud-phoenix-kata:latest -f conf/docker/Dockerfile .

if [ -z $SKIP_IAAC ]; then
    $(aws ecr get-login --no-include-email --region $AWS_REGION)
    docker push $ECR_REPO/fabiocicerchia-base-cloud-phoenix-kata:latest
fi

if [ -z $SKIP_IAAC ]; then
    terraform init conf/terraform
    terraform apply conf/terraform
    kubectl get nodes
    kubectl taint nodes --all node-role.kubernetes.io/master-
fi

helm init --wait --upgrade
helm repo update

kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'

helm install --name metrics-server stable/metrics-server --version 2.8.8 --set args={"--kubelet-insecure-tls,--kubelet-preferred-address-types=InternalIP"}

kubectl create namespace $K8S_NS

helm repo add bitnami https://charts.bitnami.com/bitnami
helm install --namespace $K8S_NS --name endpoint-node -f conf/k8s/values-node.yaml bitnami/node
helm install --namespace $K8S_NS --name ingress-controller -f conf/k8s/values-ingress.yaml stable/nginx-ingress --version 1.24.7

#kubectl apply --namespace $K8S_NS -f conf/k8s/autoscale.yaml
kubectl apply --namespace $K8S_NS -f conf/k8s/ingress.yaml

INGRESS_IP=`kubectl describe --namespace $K8S_NS ingress endpoint-ingress | grep "Address:" | awk '{ print $2 }'`
if [ -z $NO_PORT_FORWARD ]; then
    kubectl port-forward --namespace $K8S_NS ing/endpoint-ingress 8080:80
    INGRESS_IP="127.0.0.1:8080"
fi

echo "APP available at: http://$INGRESS_IP/"
