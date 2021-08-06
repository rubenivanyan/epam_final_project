# Epam Final Project

## Introduction
This is a Microservice sample project. In deployment we use consul, rabbitmq, mongodb, mysql, zuul proxy & web-application written on angular js.
## Prerequisites 
1. Operating System: Ubuntu 20.04, aws account
2. Install `terraform`, `ansible`, `python3`, `botocore`, `boto3`, `openssh-server` on your Ubuntu machine

## Steps to deploy the project
1. Clone the repository into your Ubuntu machine, into directory your user (exmample: /home/user/)
2. Change parameters in variable.tf & ansible.cfg files, & use your own credentials for connect to your aws account & ec2 instances
3. Run `build.sh` 
4. Enjoy !! Your infrastucture will be ready approximately about 30-40 minutes

## Extras

web-application


![alt tag](project_samples/doc/firstpage.png?raw=true)

web-application service-one


![alt tag](project_samples/doc/service-one.jpg?raw=true)

web-application service-two


![alt tag](project_samples/doc/service-two.jpg?raw=true)


