PRINT Install GoLang

dnf install golang -y
STAT $?
PRINT  Add application User

useradd roboshop
STAT $?
PRINT Lets setup an app directory.

mkdir /app
STAT $?
PRINT Download the application code to created app directory.

curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip
cd /app
unzip /tmp/dispatch.zip
STAT $?

PRINT Download the dependencies & build the software.

cd /app
go mod init dispatch
go get
go build
STAT $?

PRINT Load the service.

systemctl daemon-reload
STAT $?


PRINT Start and enable Dispatch service.

systemctl enable dispatch
systemctl start dispatch
STAT $?


execute_as_root