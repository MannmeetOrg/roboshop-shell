dnf module disable nodejs -y
dnf module enable nodejs:20 -y

# Install NodeJS

dnf install nodejs -y

# Add application User

useradd roboshop

# vLets setup an app directory.

mkdir /app

#vDownload the application code to created app directory.

curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart-v3.zip
cd /app
unzip /tmp/cart.zip

# Lets download the dependencies.

cd /app
npm install

# Load the service.

systemctl daemon-reload

# Start the service.

systemctl enable cart
systemctl start cart