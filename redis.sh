

PRINT  Disable redis
dnf module disable redis -y
STAT $?

PRINT  Enable  redis
dnf module enable redis:7 -y
STAT $?

PRINT  Install redis

dnf install redis -y
STAT $?


PRINT  Update Redis Configuration

#sed -i 's/127.0.0.0/0.0.0.0' /etc/redis/redis.conf
sed -i -e '/^bind/ s/127.0.0.1/0.0.0.0/' -e '/protected-mode/ c protected-mode no' /etc/redis/redis.conf

STAT $?

PRINT Start & Enable Redis Service

systemctl enable redis
systemctl start redis
STAT $?