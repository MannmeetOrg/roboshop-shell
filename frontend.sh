source common

PRINT Disable NGINX
dnf module disable nginx -y

PRINT Disable NGINX
dnf module enable nginx:1.24 -y
STAT $?

PRINT Install NGINX
dnf install nginx -y

PRINT Start & Enable Nginx service

systemctl enable nginx
systemctl start nginx

PRINT Remove the default content that web server is serving.

rm -rf /usr/share/nginx/html/*

PRINT Download the frontend content

curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip

PRINT Extract the frontend content.

cd /usr/share/nginx/html
unzip /tmp/frontend.zip

PRINT Restart Nginx Service to load the changes of the configuration.

systemctl restart nginx