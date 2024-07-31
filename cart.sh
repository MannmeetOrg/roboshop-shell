
sname=cart

PRINT Disable NODEJS
dnf module disable nodejs -y
STAT $?

PRINT Enable NODEJS
dnf module enable nodejs:20 -y
STAT $?

PRINT Install NodeJS

dnf install nodejs -y
STAT $?

PRINT Add application User

useradd roboshop
STAT $?

PRINT Setup an app directory.

mkdir /app
STAT $?

PRINT Download the application code to created app directory.

curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart-v3.zip
cd /app
unzip /tmp/cart.zip
STAT $?

PRINT Lets download the dependencies.

cd /app
npm install
STAT $?

PRINT Load the service.

systemctl daemon-reload
STAT $?

PRINT Start the service.

systemctl enable cart
systemctl start cart
STAT $?


execute_as_root