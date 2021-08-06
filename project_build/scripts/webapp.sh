#!/bin/bash

cd /home/ubuntu/web-application/
apt install npm -y
apt install ng-common -y
cd /home/ubuntu/web-application
apt update -y
apt upgrade -y
echo n | npm install
npm cache clean -f
echo n | npm install -g n --silent
n stable
echo n | npm install -g --silent @angular/cli@12.1.4
ng build --prod
systemctl start web-app.service
