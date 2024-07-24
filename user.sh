PRINT Disable NodeJS

dnf module disable nodejs -y
STAT $?

PRINT Enable NodeJS
dnf module enable nodejs:20 -y
STAT $?

PRINT Install NodeJS

dnf install nodejs -y
STAT $?

PRINT Add application User

useradd roboshop


PRINT Setup an app directory.

mkdir /app
STAT $?

PRINT Download the application code to created app directory.

curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user-v3.zip
cd /app
unzip /tmp/user.zip
STAT $?

PRINT Install dependencies
cd /app
npm install
STAT $?

PRINT Start & Enable USER Service
systemctl daemon-reload

systemctl enable user
systemctl start user
STAT $?
