source common.sh
component=payment
sname=payment
app_path=/app

PRINT Install Python 3

dnf install python3 gcc python3-devel -y &>>$LOG_FILE

Prereq_App

PRINT Download Dependencies
cd /app &>>$LOG_FILE
pip3 install -r requirements.txt &>>$LOG_FILE

Systemd_setup
execute_as_root