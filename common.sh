# This is the common file for all the duplicate codes in this project.
LOG_FILE=/tmp/roboshop.log
rm -f $LOG_FILE
dir="/app"

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

PRINT Add application User

    id roboshop &>>$LOG_FILE
    if [ $? -ne 0 ]; then
      useradd roboshop &>>$LOG_FILE
    fi
STAT $?

PRINT Remove old contect

  rm -rf $(app_path) &>>$LOG_FILE

PRINT Setup an app directory

   mkdir $(app_path) &>>$LOG_FILE

STAT $?

PRINT Download the application code to created app directory

  curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip &>>$LOG_FILE
  cd $(app_path) &>>$LOG_FILE
  unzip /tmp/catalogue.zip &>>$LOG_FILE

STAT $?

}
