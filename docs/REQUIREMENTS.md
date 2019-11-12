# Requirements

 - [X] You may use whatever programming language/platform you prefer. Use something that you know well.
 - [X] You must release your work with an OSI-approved open source license of your choice.
 - [X] You must deliver the sources, with a README that explains how to run it.
 - [X] Add the code to your own Github account and send us the link.
 - [X] You must pay attention to some unwanted features that were introduced during development.
 - [X] Automate the creation of the infrastructure and the setup of the application.
 - [X] Recover from crashes. Implement a method autorestart the service on crash
       NOTE: Already implemented with restartPolicy: Always in bitnami/node
 - [ ] Backup the logs and database with rotation of 7 days
 - [X] Notify any CPU peak
       NOTE: Easy way: Use [AWS CloudWatch](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/ContainerInsights.html) to get an alert about it.
         Complex way: Add an additional [service](https://hub.helm.sh/charts/stable/sysdig) to monitor the whole cluster health status.
 - [X] Implements a CI/CD pipeline for the code
 - [-] Scale when the number of request are greater than 10 req /sec
