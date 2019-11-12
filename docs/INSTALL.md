# INSTALL

## Requirements

 - [minikube v1.5.2+](https://minikube.sigs.k8s.io/)
 - [AWS CLI](https://aws.amazon.com/cli/)
 - [AWS IAM Authenticator](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html)

## Configuration

Rename the `.env-dist` file to `.env` and change the `OWNER_ID` variable (use your own AWS Owner ID)

## Install on DEV

 1. Install minikube
 2. Launch `./bin/minikube.sh` to setup your local cluster
 3. Launch `SKIP_IAAC=true ./bin/setup.sh` to bootstrap the k8s cluster
 4. Open your browser to the URL provided in the previous step.

## Install on PROD

 1. Launch `./bin/setup.sh` to bootstrap the k8s cluster
 2. Open your browser to the URL provided in the previous step.
