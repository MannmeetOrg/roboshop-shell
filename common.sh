# This is the common file for all the duplicate codes in this project.
LOG_FILE=/tmp/roboshop.log
rm -f $LOG_FILE
code_dir=$(pwd)

PRINT () {
    echo &>>$LOG_FILE
    echo &>>$LOG_FILE
    echo " ####################################### $* ########################################" &>>$LOG_FILE
    echo $*
}

STAT() {

  if [ $1 -eq 0 ]; then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILURE\e[0m"
    echo
    echo "Refer the log file for more information : File Path : ${LOG_FILE}"
    exit $1
  fi
}

Prereq_App () {

  PRINT Add application User.

    id roboshop &>>$LOG_FILE
    if [ $? -ne 0 ]; then
      useradd roboshop &>>$LOG_FILE
    fi

  STAT $?

  PRINT Remove old content.

    rm -rf ${app_path} &>>$LOG_FILE

  STAT $?

  PRINT Setup an app directory.

    mkdir ${app_path}  &>>$LOG_FILE

  STAT $?

  PRINT Download the application code to created app directory

    curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip &>>$LOG_FILE
    cd ${app_path} &>>$LOG_FILE
    unzip /tmp/catalogue.zip &>>$LOG_FILE

  STAT $?

}

NodeJS () {

  PRINT Disable NodeJS

    dnf module disable nodejs -y &>>$LOG_FILE

  PRINT Enable NodeJS

    dnf module enable nodejs:20 -y &>>$LOG_FILE

  STAT $?

  PRINT Install NodeJS

    dnf install nodejs -y &>>$LOG_FILE

  STAT $?

Prereq_App

  PRINT Download the NodeJS dependencies

    cd ${app_path} &>>$LOG_FILE
    npm install &>>$LOG_FILE

  STAT $?

Systemd_setup
Schema_setup
}

Systemd_setup () {
  PRINT copy the configuration file to the path
    cp ${code_dir}/catalogue.service /etc/systemd/system/catalogue.service &>>$LOG_FILE
  STAT $?

  PRINT Start Service
    systemctl daemon-reload &>>$LOG_FILE

    systemctl enable catalogue &>>$LOG_FILE
    systemctl start catalogue &>>$LOG_FILE
  STAT $?
}

Schema_setup () {

  PRINT Copy the configuration file.
    cp ${code_dir}/mongo.repo /etc/yum.repos.d/mongo.repo &>>$LOG_FILE
  STAT $?

  PRINT Install MongoDB Client

  dnf install mongodb-mongosh -y &>>$LOG_FILE

  STAT $?

  PRINT Load Master Data
  mongosh --host 35.175.198.42 </app/db/master-data.js &>>$LOG_FILE

  STAT $?
}