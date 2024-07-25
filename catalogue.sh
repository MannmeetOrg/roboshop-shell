source common.sh
app_path=/app

PRINT Disable NodeJS

dnf module disable nodejs -y &>>$LOG_FILE

PRINT Enable NodeJS
dnf module enable nodejs:20 -y &>>$LOG_FILE
STAT $?

PRINT Install NodeJS

dnf install nodejs -y &>>$LOG_FILE
STAT $?

Prereq_App

PRINT Download the dependencies

cd $(app_path) &>>$LOG_FILE
npm install &>>$LOG_FILE

STAT $?

cp catalogue.service /etc/systemd/system/catalogue.service &>>$LOG_FILE

PRINT Start Service
systemctl daemon-reload &>>$LOG_FILE

systemctl enable catalogue &>>$LOG_FILE
systemctl start catalogue &>>$LOG_FILE
STAT $?

