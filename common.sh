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