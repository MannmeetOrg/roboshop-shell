source common.sh
component=payment
sname=payment

PRINT Install Python 3

dnf install python3 gcc python3-devel -y &>>$LOG_FILE

Prereq_App

PRINT Download Dependencies
cd /app
pip3 install -r requirements.txt
Systemd_setup
execute_as_root