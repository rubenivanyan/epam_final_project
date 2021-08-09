#! /bin/bash
systemctl restart rabbitmq-server.service
rabbitmqctl add_user admin password 
rabbitmqctl set_user_tags admin administrator
rabbitmqctl set_permissions -p / admin ".*" ".*" ".*"