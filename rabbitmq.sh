source common.sh
component=rabbitmq
sname=rabbitmq

PRINT Install RabbitMQ

dnf install rabbitmq-server -y &>>$LOG_FILE

STAT $?

PRINT Starting and enable RABITTMQ Server
  systemctl enable rabbitmq-server
  systemctl start rabbitmq-server
STAT $?

PRINT Create one user for the RabbitMQ application and set permission

rabbitmqctl add_user roboshop roboshop123 &>>$LOG_FILE
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"  &>>$LOG_FILE

STAT $?

execute_as_root

