
PRINT Install Maven and JAVA
dnf install maven -y
STAT $?

PRINT Add application User

useradd roboshop
STAT $?

PRINT Lets setup an app directory.
mkdir /app
STAT $?

PRINT Download the application code to created app directory.

curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping-v3.zip
cd /app
unzip /tmp/shipping.zip
STAT $?

PRINT Download the dependencies & build the application

cd /app
mvn clean package
mv target/shipping-1.0.jar shipping.jar
STAT $?

PRINT Load the service.

systemctl daemon-reload
STAT $?

PRINT Start and Enable Shipping service.

systemctl enable shipping
systemctl start shipping
STAT $?

PRINT To have Schema installed we can use

dnf install mysql -y
STAT $?

PRINT Load Schema

mysql -h <MYSQL-SERVER-IPADDRESS> -uroot -pRoboShop@1 < /app/db/schema.sql
STAT $?

PRINT Load Master Data

mysql -h <MYSQL-SERVER-IPADDRESS> -uroot -pRoboShop@1 < /app/db/master-data.sql
STAT $?

PRINT Create app user
mysql -h <MYSQL-SERVER-IPADDRESS> -uroot -pRoboShop@1 < /app/db/app-user.sql
STAT $?

PRINT Restarting Shipping Service
systemctl restart shipping
STAT $?