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
helm repo add bitnami https://charts.bitnami.com/bitnami

kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'

sleep 10 # wait for tiller to be patched

helm install --name metrics-server stable/metrics-server --version 2.8.8 --set args={"--kubelet-insecure-tls,--kubelet-preferred-address-types=InternalIP"}
helm install --name prometheus-operator bitnami/prometheus-operator --version 0.3.0
helm install --name prometheus-adapter -f conf/k8s/values/prometheus.yaml stable/prometheus-adapter

kubectl create namespace $K8S_NS
kubectl apply --namespace $K8S_NS -f conf/k8s/configmaps/generic.yaml
kubectl apply --namespace $K8S_NS -f conf/k8s/secrets.yaml

helm install --namespace $K8S_NS --name endpoint-node -f conf/k8s/values/node.yaml bitnami/node
helm install --namespace $K8S_NS --name ingress-controller -f conf/k8s/values/ingress.yaml stable/nginx-ingress --version 1.24.7

kubectl apply --namespace $K8S_NS -f conf/k8s/ingress.yaml
kubectl apply --namespace $K8S_NS -f conf/k8s/autoscale.yaml

echo "Waiting for the Ingress IP Address (max 120s)..."
COUNT=1
while [ -z $INGRESS_IP ] && [ $COUNT -lt 12 ]; do
    sleep 1
    COUNT=$((COUNT+1))
    INGRESS_IP=`kubectl describe --namespace $K8S_NS ingress endpoint-ingress | grep "Address:" | awk '{ print $2 }'`
done

echo "APP available at:"
echo "http://$INGRESS_IP/"
