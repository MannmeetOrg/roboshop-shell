source common.sh
app_path=/app



Prereq_App



cp catalogue.service /etc/systemd/system/catalogue.service &>>$LOG_FILE

PRINT Start Service
systemctl daemon-reload &>>$LOG_FILE

systemctl enable catalogue &>>$LOG_FILE
systemctl start catalogue &>>$LOG_FILE
STAT $?

