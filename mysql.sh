source common.sh
sname=mysql

PRINT Install MySQL Server

dnf install mysql-server -y
STAT $?

PRINT Start and Enable MySQL Service

systemctl enable mysqld
systemctl start mysqld
STAT $?

PRINT Change root password to RoboShop@1
mysql_secure_installation --set-root-pass RoboShop@1
STAT $?


execute_as_root