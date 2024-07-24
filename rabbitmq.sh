PRINT Install RabbitMQ

dnf install rabbitmq-server -y
STAT $?

PRINT Start and Enable RabbitMQ Service

systemctl enable rabbitmq-server
systemctl start rabbitmq-server
STAT $?

PRINT Create one user for the RabbitMQ application and set permission

rabbitmqctl add_user roboshop roboshop123
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"

STAT $?

