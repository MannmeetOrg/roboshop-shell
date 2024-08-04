source common.sh
component=rabbitmq
sname=rabbitmq

PRINT Update the system
    sudo dnf update -y &>>$LOG_FILE
STAT $?

PRINT  Install necessary dependencies
    sudo dnf install -y epel-release &>>$LOG_FILE
    sudo dnf install -y curl &>>$LOG_FILE
STAT $?

PRINT Add Erlang repository
sudo rpm --import https://packages.erlang-solutions.com/rpm/erlang_solutions.asc
sudo tee /etc/yum.repos.d/rabbitmq_erlang.repo <<EOF
[erlang-solutions]
name=CentOS-$releasever - Erlang Solutions
baseurl=https://packages.erlang-solutions.com/rpm/centos/\$releasever/\$basearch
gpgcheck=1
gpgkey=https://packages.erlang-solutions.com/rpm/erlang_solutions.asc
enabled=1
EOF
STAT $?

PRINT Add RabbitMQ repository
sudo rpm --import https://packagecloud.io/rabbitmq/rabbitmq-server/gpgkey
sudo tee /etc/yum.repos.d/rabbitmq_rabbitmq-server.repo <<EOF
[rabbitmq_rabbitmq-server]
name=rabbitmq_rabbitmq-server
baseurl=https://packagecloud.io/rabbitmq/rabbitmq-server/el/7/\$basearch
gpgcheck=1
gpgkey=https://packagecloud.io/rabbitmq/rabbitmq-server/gpgkey
enabled=1
EOF
STAT $?

PRINT  Install Erlang
sudo dnf install -y erlang &>>$LOG_FILE
STAT $?

PRINT Install RabbitMQ

dnf install rabbitmq-server -y &>>$LOG_FILE

STAT $?

System_setup

PRINT Create one user for the RabbitMQ application and set permission

rabbitmqctl add_user roboshop roboshop123 &>>$LOG_FILE
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"  &>>$LOG_FILE

STAT $?


execute_as_root

