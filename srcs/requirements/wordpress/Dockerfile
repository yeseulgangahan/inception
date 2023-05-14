FROM alpine:3.16

ARG PHP_VERSION=8 \
    DB_NAME \
    DB_USER \
    DB_PASS

RUN apk update && apk upgrade && apk add --no-cache \
    php${PHP_VERSION} \
# php8-fpm: PHP를 웹 서버와 연결하기 위한 FastCGI 인터페이스를 제공한다.
    php${PHP_VERSION}-fpm \
    php${PHP_VERSION}-phar \
    php${PHP_VERSION}-mysqli \
    php${PHP_VERSION}-mysqlnd \
    php${PHP_VERSION}-json \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-dom \
    php${PHP_VERSION}-exif \
    php${PHP_VERSION}-fileinfo \
    php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-openssl \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-zip \
    php${PHP_VERSION}-redis \
    php${PHP_VERSION}-ctype \
    wget \
    unzip \
    curl \
    iputils && \
# /etc/php8/php-fpm.d/www.conf: php-fpm 서버 설정 파일
  # listen: php-fpm서버가 소켓 연결을 수신하는 주소와 포트. 0.0.0.0으로 변경하여 외부에서도 연결이 가능하도록 한다.
    sed -i "s|listen = 127.0.0.1:9000|listen = 0.0.0.0:9000|g" \
      /etc/php${PHP_VERSION}/php-fpm.d/www.conf && \
  # listen.owner: php-fpm 소켓 파일의 소유자. nobody로 변경할 경우 보안에 좋다.
    sed -i "s|;listen.owner = nobody|listen.owner = nobody|g" \
      /etc/php${PHP_VERSION}/php-fpm.d/www.conf && \
  # listen.group: php-fpm 소켓 파일의 소유 그룹. nobody로 변경할 경우 보안에 좋다.
    sed -i "s|;listen.group = nobody|listen.group = nobody|g" \
      /etc/php${PHP_VERSION}/php-fpm.d/www.conf && \
  # clear_env: 디폴트 설정이 보안상 true인데 no로 바꿔서 환경변수를 삭제하지 못하게 한다.
    sed -i "s|;clear_env = no|clear_env = no|g" \
      /etc/php${PHP_VERSION}/php-fpm.d/www.conf && \
  # 패키지 매니저가 사용한 캐시 파일을 삭제
    rm -f /var/cache/apk/*

EXPOSE 9000

WORKDIR /var/www/html

# wp-cli.phar 파일 github에서 다운받고, 커맨드라인에서 'wp'로 사용할 수 있도록 설정하기
# (wp-cli: 커맨드로 워드프레스를 관리할 수 있는 유틸리티)
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/bin/wp

COPY ./requirements/wordpress/conf/wp-config-create.sh .
COPY ./requirements/wordpress/tools/script.sh .

RUN sh wp-config-create.sh && rm wp-config-create.sh

CMD ["/bin/sh", "/var/www/html/script.sh"]
