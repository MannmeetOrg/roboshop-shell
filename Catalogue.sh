# Install NodeJS, By default NodeJS 16 is available, We would like to enable 20 version and install list.

# You can list modules by using dnf module list

dnf module disable nodejs -y
dnf module enable nodejs:20 -y

# Install NodeJS

dnf install nodejs -y

# Configure the application.

# INFO
# Our application developed by the developer of our org and it is not having any RPM software just like other softwares. So we need to configure every step manually

# RECAP
# We already discussed in Linux basics section that applications should run as nonroot user.

# Add application User

useradd roboshop

# INFO
# User roboshop is a function / daemon user to run the application. Apart from that we dont use this user to login to server.

#Also, username roboshop has been picked because it more suits to our project name.

#INFO
#We keep application in one standard location. This is a usual practice that runs in the organization.

# Lets setup an app directory.

mkdir /app

# Download the application code to created app directory.

curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip
cd /app
unzip /tmp/catalogue.zip

# Every application is developed by development team will have some common softwares that they use as libraries. This application also have the same way of defined dependencies in the application configuration.

# Lets download the dependencies.

cd /app
npm install

systemctl daemon-reload

systemctl enable catalogue
systemctl start catalogue

