#! /bin/bash
pwd > /tmp/pwd
whoami > /tmp/whoami
cp /home/ubuntu/servicetwo.yaml /home/ubuntu/service-two/src/main/resources/application.yml
cd /home/ubuntu/service-two/ && mvn clean package
systemctl restart servicetwo.service

