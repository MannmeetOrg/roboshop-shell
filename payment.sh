PRINT Install Python 3

dnf install python3 gcc python3-devel -y

STAT $?

PRINT Add application User

useradd roboshop
STAT $?

PRINT  Lets setup an app directory.

mkdir /app
STAT $?

PRINT Download the application code to created app directory.

curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment-v3.zip
cd /app
unzip /tmp/payment.zip
STAT $?

PRINT Download the dependencies.

cd /app
pip3 install -r requirements.txt
STAT $?

PRINT Load the service.

systemctl daemon-reload
STAT $?

PRINT Start and enable Payment service.

systemctl enable payment
systemctl start payment
STAT $?