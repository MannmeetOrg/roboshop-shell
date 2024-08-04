source common.sh
component=redis
sname=redis

PRINT  Disable redis
dnf module disable redis -y &>>$LOG_FILE
STAT $?

PRINT  Enable  redis
dnf module enable redis:7 -y &>>$LOG_FILE
STAT $?

PRINT  Install redis

dnf install redis -y &>>$LOG_FILE
STAT $?

PRINT  Update Redis Configuration

#sed -i 's/127.0.0.0/0.0.0.0' /etc/redis/redis.conf
sed -i -e '/^bind/ s/127.0.0.1/0.0.0.0/' -e '/protected-mode/ c protected-mode no' /etc/redis/redis.conf &>>$LOG_FILE

STAT $?

 PRINT Start Service
    systemctl daemon-reload &>>$LOG_FILE

    systemctl enable ${component} &>>$LOG_FILE
    systemctl start ${component} &>>$LOG_FILE
  STAT $?


execute_as_root