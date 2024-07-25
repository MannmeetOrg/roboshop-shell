source common.sh

PRINT Disable NodeJS

dnf module disable nodejs -y

PRINT Enable NodeJS
dnf module enable nodejs:20 -y
STAT $?

PRINT Install NodeJS

dnf install nodejs -y
STAT $?

PRINT Add application User

useradd roboshop
STAT $?

PRINT Setup an app directory

mkdir /app
STAT $?

PRINT Download the application code to created app directory

curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip
cd /app
unzip /tmp/catalogue.zip
STAT $?

PRINT Download the dependencies

cd /app
npm install
STAT $?

PRINT Start Service
systemctl daemon-reload

systemctl enable catalogue
systemctl start catalogue
STAT $?

