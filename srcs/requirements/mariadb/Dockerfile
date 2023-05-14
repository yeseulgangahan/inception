FROM alpine:3.16

ARG DB_NAME \
    DB_USER \
    DB_PASS \
    DB_ROOT

# mariadb-client: mariadb 데이터베이스에 연결하여 데이터베이스를 관리할 수 있는 CLI도구
# /var/run/mysqld: mariadb 서버 프로세스의 소켓 파일이 생성되는 기본 디렉토리. mariadb 서버와 클라이언트가 통신할 때 사용한다.
RUN apk update && apk upgrade && apk add --no-cache mariadb mariadb-client && \
    mkdir /var/run/mysqld; \
    chmod 777 /var/run/mysqld; \
# skip-name-resolve: 일반적으로 클라이언트의 호스트 이름을 IP 주소로 변환하기 위해 DNS 조회가 수행된다.
#                    그러나 'skip-name-resolve'를 사용하면 DNS 조회를 피하고 성능을 향상시킬 수 있다.
# bind-address: 기본적으로 MariaDB는 로컬호스트(127.0.0.1)만을 허용하여 클라이언트 연결을 수신한다.
#               0.0.0.0 설정은 MariaDB 서버가 모든 네트워크 인터페이스(다른 컨테이너)에서 클라이언트 연결을 수신할 수 있도록 지정한다.
# tee: 입력을 출력하면서 동시에 파일에 쓴다
    { echo '[mysqld]'; \
      echo 'skip-host-cache'; \
      echo 'skip-name-resolve'; \
      echo 'bind-address=0.0.0.0'; \
    } | tee  /etc/my.cnf.d/docker.cnf; \
# skip-networking: 0일 경우 네트워크 연결을 허용한다.
    sed -i "s|skip-networking|skip-networking=0|g" \
      /etc/my.cnf.d/mariadb-server.cnf && \
# mysql_install_db: mariadb 데이터베이스를 설치하고 초기화
  # --user: 데이터베이스 서비스를 실행할 때 사용할 사용자
  # --datadir: 데이터파일, 로그파일이 저장될 디렉토리
      mysql_install_db --user=mysql --datadir=/var/lib/mysql

EXPOSE 3306

COPY requirements/mariadb/conf/create_db.sh .
RUN sh create_db.sh && rm create_db.sh

# USER mysql: 이후 컨테이너 내부에서 실행되는 모든 명령어는 mysql 사용자로 실행된다. 보안 상의 이유로 최소한의 권한으로 실행하기 위해서다.
USER mysql

CMD ["/usr/bin/mysqld", "--skip-log-error"]