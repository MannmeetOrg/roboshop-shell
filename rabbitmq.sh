source common.sh
component=rabbitmq
sname=rabbitmq

#PRINT Copy Repo file
#cp ${code_dir}/rabbitmq.repo /etc/yum.repos.d/rabbitmq.repo &>>$LOG_FILE
#STAT $?

PRINT Install RabbitMQ

sudo dnf install rabbitmq-server -y &>>$LOG_FILE

STAT $?

System_setup

PRINT Create one user for the RabbitMQ application and set permission

rabbitmqctl add_user roboshop roboshop123 &>>$LOG_FILE
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"  &>>$LOG_FILE

STAT $?


execute_as_root

