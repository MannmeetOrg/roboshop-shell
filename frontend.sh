source common

PRINT Disable NGINX
dnf module disable nginx -y

PRINT Disable NGINX
dnf module enable nginx:1.24 -y &>>$LOG_FILE
STAT $?

PRINT Install NGINX
dnf install nginx -y &>>$LOG_FILE

PRINT Start & Enable Nginx service

systemctl enable nginx &>>$LOG_FILE
systemctl start nginx &>>$LOG_FILE

PRINT Remove the default content that web server is serving.

rm -rf /usr/share/nginx/html/* &>>$LOG_FILE

PRINT Download the frontend content

curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip &>>$LOG_FILE

PRINT Extract the frontend content.

cd /usr/share/nginx/html &>>$LOG_FILE
unzip /tmp/frontend.zip &>>$LOG_FILE

PRINT Restart Nginx Service to load the changes of the configuration.

systemctl restart nginx &>>$LOG_FILE