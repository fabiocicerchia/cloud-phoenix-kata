#/bin/sh

# https://github.com/kubernetes-sigs/metrics-server/blob/master/README.md
minikube addons disable metrics-server
minikube delete

# Using K8S v1.15.4 fixes: https://github.com/helm/helm/issues/6374
minikube start --extra-config=kubelet.authentication-token-webhook=true --kubernetes-version=1.15.4 --vm-driver=none --cpus 2 --memory 2048
