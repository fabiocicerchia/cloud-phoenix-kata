# Requirements

 - [minikube v1.5.2+](https://minikube.sigs.k8s.io/)
 - [CircleCI v2.0+](https://circleci.com/docs/2.0/local-cli/)

# Start the App

```
./bin/minikube.sh
./bin/setup.sh
```

docker-compose up

http://127.0.0.1:3000

# TODO

 - [X] You may use whatever programming language/platform you prefer. Use something that you know well.
 - [X] You must release your work with an OSI-approved open source license of your choice.
 - [X] You must deliver the sources, with a README that explains how to run it.
 - [X] Add the code to your own Github account and send us the link.
 - [ ] You must pay attention to some unwanted features that were introduced during development. In particular:
   - GET /crash kill the application process
   - GET /generatecert is not optimized and creates resource consumption peaks
 - [ ] Automate the creation of the infrastructure and the setup of the application.
 - [X] Recover from crashes. Implement a method autorestart the service on crash
   NOTE: Already implemented with restartPolicy: Always in bitnami/node
 - [ ] Backup the logs and database with rotation of 7 days
 - [ ] Notify any CPU peak
 - [X] Implements a CI/CD pipeline for the code
 - [-] Scale when the number of request are greater than 10 req /sec
 - [X] submodule the external repo
