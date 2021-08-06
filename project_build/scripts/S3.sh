#! /bin/bash
pwd > /tmp/pwd
whoami > /tmp/whoami
cp /home/ubuntu/api.yaml /home/ubuntu/api-gateway/src/main/resources/application.yml
cd /home/ubuntu/api-gateway/ && mvn clean package
systemctl restart api-gateway.service

