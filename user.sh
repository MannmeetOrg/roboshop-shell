dnf module disable nodejs -y
dnf module enable nodejs:20 -y

Install NodeJS

dnf install nodejs -y

Add application User

useradd roboshop


Lets setup an app directory.

mkdir /app

Download the application code to created app directory.

curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user-v3.zip
cd /app
unzip /tmp/user.zip


cd /app
npm install

systemctl daemon-reload

systemctl enable user
systemctl start user

