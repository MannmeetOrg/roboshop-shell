source common.sh

PRINT Disable NGINX
dnf module disable nginx -y &>>$LOG_FILE

PRINT Enable NGINX 1.24 version
dnf module enable nginx:1.24 -y &>>$LOG_FILE
STAT $?

PRINT Install NGINX
dnf install nginx -y &>>$LOG_FILE
STAT $?

PRINT Start and Enable Nginx service

systemctl enable nginx &>>$LOG_FILE
systemctl start nginx &>>$LOG_FILE
STAT $?

PRINT Remove the default content that web server is serving.

rm -rf /usr/share/nginx/html/* &>>$LOG_FILE
STAT $?

PRINT Download the frontend content

curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip &>>$LOG_FILE
STAT $?

PRINT Extract the frontend content.

cd /usr/share/nginx/html &>>$LOG_FILE
unzip /tmp/frontend.zip &>>$LOG_FILE
STAT $?

PRINT Restart Nginx Service to load the changes of the configuration.

systemctl restart nginx &>>$LOG_FILE

STAT $?