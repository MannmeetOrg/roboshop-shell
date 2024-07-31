source common.sh
component=rabbitmq
sname=rabbitmq

PRINT Install RabbitMQ

dnf install rabbitmq-server -y
STAT $?

System_setup

PRINT Create one user for the RabbitMQ application and set permission

rabbitmqctl add_user roboshop roboshop123
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"

STAT $?


execute_as_root

