source common.sh

PRINT Disable NodeJS

dnf module disable nodejs -y &>>$LOG_FILE

PRINT Enable NodeJS
dnf module enable nodejs:20 -y &>>$LOG_FILE
STAT $?

PRINT Install NodeJS

dnf install nodejs -y &>>$LOG_FILE
STAT $?

PRINT Add application User

useradd roboshop &>>$LOG_FILE
STAT $?

PRINT Setup an app directory

mkdir /app &>>$LOG_FILE
STAT $?

PRINT Download the application code to created app directory

curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip &>>$LOG_FILE
cd /app &>>$LOG_FILE
unzip /tmp/catalogue.zip &>>$LOG_FILE
STAT $?

PRINT Download the dependencies

cd /app &>>$LOG_FILE
npm install &>>$LOG_FILE
STAT $?

cp catalogue.service /etc/systemd/system/catalogue.service &>>$LOG_FILE

PRINT Start Service
systemctl daemon-reload &>>$LOG_FILE

systemctl enable catalogue &>>$LOG_FILE
systemctl start catalogue &>>$LOG_FILE
STAT $?

