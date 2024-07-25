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
