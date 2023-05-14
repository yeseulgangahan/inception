#!bin/sh

if [ ! -d "/var/lib/mysql/mysql" ]; then

# /var/lib/mysql의 소유권을 mysql사용자와 mysql그룹으로 변경한다. 
        chown -R mysql:mysql /var/lib/mysql

        # init database
        mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm

fi

# FLUSH PRIVILEGES: 권한 설정을 새로고침한다
# ALTER USER: root 사용자의 패스워드를 ${DB_ROOT} 값으로 변경
# CREATE DATABASE: ${DB_NAME}의 이름으로 데이터베이스를 생성
# CREATE USER: 새로운 사용자를 생성한다. 
#              @'%'는 사용자 계정으로 접속 가능한 호스트 전부가 해당 계정으로 접속이 가능함을 의미한다.
# GRANT ALL PRIVILEGES: ${DB_USER} 사용자에게 wordpress 데이터베이스의 모든 권한을 부여

if [ ! -d "/var/lib/mysql/wordpress" ]; then

        cat << EOF > /tmp/create_db.sql
USE mysql;
FLUSH PRIVILEGES;
DELETE FROM     mysql.user WHERE User='';
DROP DATABASE test;
DELETE FROM mysql.db WHERE Db='test';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT}';
CREATE DATABASE ${DB_NAME} CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '${DB_USER}'@'%' IDENTIFIED by '${DB_PASS}';
GRANT ALL PRIVILEGES ON wordpress.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF
        # run init.sql
        /usr/bin/mysqld --user=mysql --bootstrap < /tmp/create_db.sql
        rm -f /tmp/create_db.sql
fi
