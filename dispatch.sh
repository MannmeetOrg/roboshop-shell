source common.sh
component=dispatch
sname=dispatch
app_path=/app

  PRINT Install GoLang
        dnf install golang -y &>>LOG_FILE
  STAT $?

Prereq_App

  PRINT Download the dependencies and build the software.

        cd ${app_path} &>>LOG_FILE
        go mod init ${component} &>>LOG_FILE
        go get &>>LOG_FILE
        go build &>>LOG_FILE
  STAT $?

Systemd_setup

execute_as_root