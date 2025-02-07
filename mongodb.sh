source common.sh
sname=mongodb
component=mongodb

cp mongodb.repo /etc/yum.repos.d/mongo.repo

PRINT Install MongoDB

dnf install mongodb-org -y &>>$LOG_FILE
STAT $?

PRINT Start and Enable MongoDB Service

systemctl enable mongod &>>$LOG_FILE
systemctl start mongod &>>$LOG_FILE
STAT $?

PRINT Update MongoDB config file
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>>$LOG_FILE
STAT $?

PRINT Restart the service

systemctl restart mongod &>>$LOG_FILE
STAT $?
execute_as_root

