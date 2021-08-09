#! /bin/bash
pwd > /tmp/pwd
whoami > /tmp/whoami
cp /home/ubuntu/serviceone.yaml /home/ubuntu/service-one/src/main/resources/application.yml
cd /home/ubuntu/service-one/ && mvn clean package
systemctl enable mongod.service
systemctl enable serviceone.service
systemctl restart mongod.service
systemctl restart serviceone.service
