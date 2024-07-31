
component=redis
sname=redis

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

Systemd_setup


execute_as_root