# Install MySQL Server

dnf install mysql-server -y

# Start MySQL Service

systemctl enable mysqld
systemctl start mysqld

# Next, We need to change the default root password in order to start using the database service. Use password RoboShop@1 or any other as per your choice.

mysql_secure_installation --set-root-pass RoboShop@1