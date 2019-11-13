# INSTALL

## Requirements

 - [minikube v1.5.2+](https://minikube.sigs.k8s.io/)
 - [AWS CLI](https://aws.amazon.com/cli/)
 - [AWS IAM Authenticator](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html)

## Configuration

 1. Rename the `.env-dist` file to `.env` and change the `OWNER_ID` variable (use your own AWS Owner ID).
 2. Fill the AWS credentials in the file `conf/k8s/secrets.yaml`.

## Install on PROD

 1. Setup AWS
   - Get an account on AWS
   - Create a user
   - Get the API keys
   - Install the [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)
   - Run locally `aws configure`
 1. Launch `./bin/setup.sh` to bootstrap the k8s cluster
 2. Open your browser to the URL provided in the previous step.

## Install on DEV

1. Install minikube, follow the [guide](https://kubernetes.io/docs/tasks/tools/install-minikube/)
2. Launch `./bin/minikube.sh` to setup your local cluster
```
✅  "metrics-server" was successfully disabled
🔥  Deleting "minikube" in hyperkit ...
💔  The "minikube" cluster has been deleted.
🔥  Successfully deleted profile "minikube"
😄  minikube v1.5.2 on Darwin 10.14.6
    ▪ KUBECONFIG=
✨  Automatically selected the 'hyperkit' driver (alternates: [virtualbox])
🔥  Creating hyperkit VM (CPUs=2, Memory=2048MB, Disk=20000MB) ...
🐳  Preparing Kubernetes v1.15.4 on Docker '18.09.9' ...
    ▪ kubelet.authentication-token-webhook=true
🚜  Pulling images ...
🚀  Launching Kubernetes ...
⌛  Waiting for: apiserver
🏄  Done! kubectl is now configured to use "minikube"
```
3. Launch `SKIP_IAAC=true ./bin/setup.sh` to bootstrap the k8s cluster
```
Sending build context to Docker daemon  252.5MB
Step 1/7 : FROM node:8.11.1-alpine
 ---> e707e7ad7186
Step 2/7 : RUN mkdir -p /home/node/app &&     chown -R node:node /home/node/app &&     npm i npm@latest -g
 ---> Using cache
 ---> 849ee307cadf
Step 3/7 : WORKDIR /home/node/app
 ---> Using cache
 ---> 7c31c70cc967
Step 4/7 : COPY --chown=node:node ./app /home/node/app
 ---> Using cache
 ---> b04b8c714216
Step 5/7 : RUN npm install
 ---> Using cache
 ---> c021d5dd32e7
Step 6/7 : EXPOSE 3000
 ---> Using cache
 ---> 4ce043eb5178
Step 7/7 : CMD ["npm", "start"]
 ---> Using cache
 ---> 9efe9380aebf
Successfully built 9efe9380aebf
Successfully tagged XXX.dkr.ecr.eu-west-1.amazonaws.com/fabiocicerchia-base-cloud-phoenix-kata:latest
$HELM_HOME has been configured at /Users/fabiocicerchia/.helm.

Tiller (the Helm server-side component) has been installed into your Kubernetes Cluster.

Please note: by default, Tiller is deployed with an insecure 'allow unauthenticated users' policy.
To prevent this, run `helm init` with the --tiller-tls-verify flag.
For more information on securing your installation see: https://docs.helm.sh/using_helm/#securing-your-helm-installation
Happy Helming!
Hang tight while we grab the latest from your chart repositories...
...Skip local chart repository
...Successfully got an update from the "kubernetic" chart repository
...Successfully got an update from the "bitnami" chart repository
...Successfully got an update from the "stable" chart repository
Update Complete. ⎈ Happy Helming!⎈
"bitnami" has been added to your repositories
serviceaccount/tiller created
clusterrolebinding.rbac.authorization.k8s.io/tiller-cluster-rule created
deployment.extensions/tiller-deploy patched
NAME:   metrics-server
LAST DEPLOYED: Sun Feb  9 03:00:00 1986
NAMESPACE: default
STATUS: DEPLOYED

RESOURCES:
==> v1/Pod(related)
NAME                            READY  STATUS             RESTARTS  AGE
metrics-server-c8d94bb99-f8ltn  0/1    ContainerCreating  0         33y

==> v1/ServiceAccount
NAME            SECRETS  AGE
metrics-server  1        33y

==> v1/ClusterRole
NAME                                     AGE
system:metrics-server-aggregated-reader  33y
system:metrics-server                    33y

==> v1/ClusterRoleBinding
NAME                                  AGE
metrics-server:system:auth-delegator  33y
system:metrics-server                 33y

==> v1beta1/RoleBinding
NAME                        AGE
metrics-server-auth-reader  33y

==> v1/Service
NAME            TYPE       CLUSTER-IP      EXTERNAL-IP  PORT(S)  AGE
metrics-server  ClusterIP  10.100.135.190  <none>       443/TCP  33y

==> v1/Deployment
NAME            DESIRED  CURRENT  UP-TO-DATE  AVAILABLE  AGE
metrics-server  1        1        1           0          33y

==> v1beta1/APIService
NAME                    AGE
v1beta1.metrics.k8s.io  33y


NOTES:
The metric server has been deployed.

In a few minutes you should be able to list metrics using the following
command:

  kubectl get --raw "/apis/metrics.k8s.io/v1beta1/nodes"

namespace/cloud-phoenix-kata created
configmap/configs created
secret/credentials created
NAME:   endpoint-node
LAST DEPLOYED: Sun Feb  9 03:00:00 1986
NAMESPACE: cloud-phoenix-kata
STATUS: DEPLOYED

RESOURCES:
==> v1/Pod(related)
NAME                                    READY  STATUS    RESTARTS  AGE
endpoint-node-mongodb-58f458457c-clpnv  0/1    Pending   0         33y
endpoint-node-54669846dd-55b65          0/1    Init:0/2  0         33y
endpoint-node-54669846dd-9ss59          0/1    Init:0/2  0         33y
endpoint-node-54669846dd-j77qz          0/1    Init:0/2  0         33y

==> v1/Secret
NAME                   TYPE    DATA  AGE
endpoint-node-mongodb  Opaque  2     33y

==> v1/PersistentVolumeClaim
NAME                   STATUS  VOLUME                                    CAPACITY  ACCESS MODES  STORAGECLASS  AGE
endpoint-node-mongodb  Bound   pvc-c2dec4d8-8eca-46b8-b12c-35b92c1edfad  8Gi       RWO           standard      33y

==> v1/Service
NAME                   TYPE       CLUSTER-IP      EXTERNAL-IP  PORT(S)    AGE
endpoint-node-mongodb  ClusterIP  10.107.234.170  <none>       27017/TCP  33y
endpoint-node          ClusterIP  10.105.254.77   <none>       80/TCP     33y

==> v1/Deployment
NAME                   DESIRED  CURRENT  UP-TO-DATE  AVAILABLE  AGE
endpoint-node-mongodb  1        1        1           0          33y
endpoint-node          3        3        3           0          33y


NOTES:

1. Get the URL of your Node app  by running:

  kubectl port-forward --namespace cloud-phoenix-kata svc/endpoint-node 80:80
  echo "Node app URL: http://127.0.0.1:80/"



NAME:   ingress-controller
LAST DEPLOYED: Sun Feb  9 03:00:00 1986
NAMESPACE: cloud-phoenix-kata
STATUS: DEPLOYED

RESOURCES:
==> v1/Pod(related)
NAME                                                             READY  STATUS             RESTARTS  AGE
ingress-controller-nginx-ingress-controller-79955f76b-j6jnl      0/1    ContainerCreating  0         33y
ingress-controller-nginx-ingress-default-backend-8548cd4c79w4dl  0/1    ContainerCreating  0         33y

==> v1/ServiceAccount
NAME                                      SECRETS  AGE
ingress-controller-nginx-ingress          1        33y
ingress-controller-nginx-ingress-backend  1        33y

==> v1beta1/ClusterRole
NAME                              AGE
ingress-controller-nginx-ingress  33y

==> v1beta1/ClusterRoleBinding
NAME                              AGE
ingress-controller-nginx-ingress  33y

==> v1beta1/Role
NAME                              AGE
ingress-controller-nginx-ingress  33y

==> v1beta1/RoleBinding
NAME                              AGE
ingress-controller-nginx-ingress  33y

==> v1/Service
NAME                                              TYPE          CLUSTER-IP      EXTERNAL-IP  PORT(S)                     AGE
ingress-controller-nginx-ingress-controller       LoadBalancer  10.100.202.130  <pending>    80:31101/TCP,443:31313/TCP  33y
ingress-controller-nginx-ingress-default-backend  ClusterIP     10.101.4.191    <none>       80/TCP                      33y

==> v1/Deployment
NAME                                              DESIRED  CURRENT  UP-TO-DATE  AVAILABLE  AGE
ingress-controller-nginx-ingress-controller       1        1        1           0          33y
ingress-controller-nginx-ingress-default-backend  1        1        1           0          33y


NOTES:
The nginx-ingress controller has been installed.
It may take a few minutes for the LoadBalancer IP to be available.
You can watch the status by running 'kubectl --namespace cloud-phoenix-kata get services -o wide -w ingress-controller-nginx-ingress-controller'

An example Ingress that makes use of the controller:

  apiVersion: extensions/v1beta1
  kind: Ingress
  metadata:
    annotations:
      kubernetes.io/ingress.class: nginx
    name: example
    namespace: foo
  spec:
    rules:
      - host: www.example.com
        http:
          paths:
            - backend:
                serviceName: exampleService
                servicePort: 80
              path: /
    # This section is only required if TLS is to be enabled for the Ingress
    tls:
        - hosts:
            - www.example.com
          secretName: example-tls

If TLS is enabled for the Ingress, a Secret containing the certificate and key must also be provided:

  apiVersion: v1
  kind: Secret
  metadata:
    name: example-tls
    namespace: foo
  data:
    tls.crt: <base64 encoded cert>
    tls.key: <base64 encoded key>
  type: kubernetes.io/tls

ingress.extensions/endpoint-ingress created
horizontalpodautoscaler.autoscaling/endpoint-node created
Waiting for the Ingress IP Address...
APP available at:
http://192.168.64.8/
```
4. Open your browser to the URL provided in the previous step.
