source common.sh
sname=mysql

PRINT Install MySQL Server

dnf install mysql-server -y &>>$LOG_FILE
STAT $?

PRINT Start and Enable MySQL Service

systemctl enable mysqld &>>$LOG_FILE
systemctl start mysqld &>>$LOG_FILE
STAT $?

PRINT Change root password to RoboShop@1
mysql_secure_installation --set-root-pass RoboShop@1 &>>$LOG_FILE
STAT $?


execute_as_root