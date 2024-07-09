dnf install maven -y

Add application User

useradd roboshop

Lets setup an app directory.

mkdir /app

Download the application code to created app directory.

curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping-v3.zip
cd /app
unzip /tmp/shipping.zip

Lets download the dependencies & build the application

cd /app
mvn clean package
mv target/shipping-1.0.jar shipping.jar

Load the service.

systemctl daemon-reload

Start the service.

systemctl enable shipping
systemctl start shipping


To have it installed we can use

dnf install mysql -y

Load Schema, Schema in database is the structure to it like what tables to be created and their necessary application layouts.

mysql -h <MYSQL-SERVER-IPADDRESS> -uroot -pRoboShop@1 < /app/db/schema.sql

Load Master Data, This includes the data of all the countries and their cities with distance to those cities.

mysql -h <MYSQL-SERVER-IPADDRESS> -uroot -pRoboShop@1 < /app/db/master-data.sql

Create app user, MySQL expects a password authentication, Hence we need to create the user in mysql database for shipping app to connect.

mysql -h <MYSQL-SERVER-IPADDRESS> -uroot -pRoboShop@1 < /app/db/app-user.sql

This service needs a restart because it is dependent on schema, After loading schema only it will work as expected, Hence we are restarting this service. This

systemctl restart shipping