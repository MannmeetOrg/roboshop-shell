Install RabbitMQ

dnf install rabbitmq-server -y

Start RabbitMQ Service

systemctl enable rabbitmq-server
systemctl start rabbitmq-server

RabbitMQ comes with a default username / password as guest/guest. But this user cannot be used to connect. Hence, we need to create one user for the application.

rabbitmqctl add_user roboshop roboshop123
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"

