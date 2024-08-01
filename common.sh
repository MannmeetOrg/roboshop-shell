# This is the common file for all the duplicate codes in this project.
LOG_FILE=/tmp/roboshop.log
rm -f $LOG_FILE
code_dir=$(pwd)

execute_as_root() {
    PRINT SET Server Name
    sudo -i <<EOF
    echo "Switched to root user"
    sudo set-prompt ${sname}
    # Switch back to ec2-user and change directory
      sudo -u ec2-user bash
      cd /home/ec2-user/roboshop-shell
      echo "Switched back to ec2-user and changed directory to /home/ec2-user/roboshop-shell/"
      exec bash
    exit
EOF
}


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

    curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}-v3.zip &>>$LOG_FILE
    cd ${app_path} &>>$LOG_FILE
    unzip /tmp/${component}.zip &>>$LOG_FILE

  STAT $?

}

NodeJS () {

  PRINT Disable NodeJS

    dnf module disable nodejs -y &>>$LOG_FILE
  STAT $?

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

Java () {
  PRINT Install Maven and JAVA
        dnf install maven -y &>>$LOG_FILE
  STAT $?
  Prereq_App
    PRINT download the dependencies
        cd /app &>>$LOG_FILE
        mvn clean package &>>$LOG_FILE
        mv target/shipping-1.0.jar shipping.jar &>>$LOG_FILE
    STAT $?

  Systemd_setup
  Schema_setup
}
Systemd_setup () {
  PRINT copy the configuration file to the path
    cp ${code_dir}/${component}.service /etc/systemd/system/${component}.service &>>$LOG_FILE
  STAT $?

  PRINT Start Service
    systemctl daemon-reload &>>$LOG_FILE

    systemctl enable ${component} &>>$LOG_FILE
    systemctl start ${component} &>>$LOG_FILE
  STAT $?
}

Schema_setup () {

    if [ ${component} == "mysql"]; then
        PRINT Install MySQL Client
            dnf install mysql -y &>>$LOG_FILE
        STAT $?

      for file in schema app-user master-data; do
        PRINT Load ${file}.sql
          mysql -h mysql.blissfullbytes.online -uroot -pRoboShop@1 < /app/db/${file}.sql &>>$LOG_FILE
        STAT $?
        done
    fi

    if [ ${component} == "mongodb"]; then
        PRINT Copy the configuration file
          cp ${code_dir}/mongodb.repo /etc/yum.repos.d/mongo.repo &>>$LOG_FILE
        STAT $?

        PRINT Install MongoDB Client

        dnf install mongodb-mongosh -y &>>$LOG_FILE

        STAT $?

        PRINT Load Master Data
        mongosh --host mongodb.blissfullbytes.online </app/db/master-data.js &>>$LOG_FILE

        STAT $?
    fi
}

#add_dns_record() {
#  local hosted_zone_id="$1"
#  local record_name="$2"
#  local record_value="$3"
#  local record_ttl="${4:-300}"  # Default TTL to 300 if not provided
#  local record_type="A"
#
#}
#
#AWS_CLI_Install () {
#  pip install awscli
#  AWS_ACCESS_KEY_ID= aa
#  AWS_ACCESS_KEY_SECRET=aaa
#  AWS_REGION=aaa
#  aws configure set aws_access_key_id "$AWS_ACCESS_KEY_ID" --profile ec2-user /
#    && aws configure set aws_secret_access_key "$AWS_ACCESS_KEY_SECRET" --profile ec2-user /
#    && aws configure set region "$AWS_REGION" --profile ec2-user && aws configure set output "json" --profile ec2-user
#}





