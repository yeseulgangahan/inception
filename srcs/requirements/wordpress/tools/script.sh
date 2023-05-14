# wp core download: 워드프레스 core files의 최종버전(.php파일들)을 다운로드
   # --allow-root: 루트 사용자로 명령 실행을 명시적으로 허용
   # --path=/var/www/html: 컨테이너 내부에서 워드프레스가 설치될 경로
wp core download --allow-root --path=/var/www/html

# wp core install: 워드프레스를 설치 (즉, 새 워드프레스 데이터베이스 생성, 사용자 계정 생성, 워드프레스 소프트웨어 설치)
   # --path: 워드프레스가 설치될 경로
   # --url: 워드프레스 사이트의 url
   # --title: 워드프레스 사이트의 제목
   # --admin_*: 워드프레스 관리자 계정의 이름, 비밀번호, 이메일 지정
   # --skip-email: 확인이메일을 워드프레스 관리자 이메일로 보내지 않는다
wp core install \
   --allow-root \
   --path=${WORDPRESS_PATH} \
   --url=${WORDPRESS_URL} \
   --title=Inception \
   --admin_user=${WORDPRESS_ADMIN} \
   --admin_password=${WORDPRESS_ADMIN_PASSWORD} \
   --admin_email=${WORDPRESS_ADMIN_EMAIL} \
   --skip-email

# wp user create: 워드프레스 유저 계정을 생성 
# author: 자신의 포스트(만)를 출간 및 관리할 수 있는 역할
wp user create ${WORDPRESS_USER} \
               ${WORDPRESS_USER_EMAIL} \
               --user_pass=${WORDPRESS_USER_PASSWORD} \
               --role=author

# 웹서버 사용자(www-data)에게 wp-content에 대한 쓰기권한을 줌으로써, 테마를 변경할 수 있도록 한다.
chmod -R 0777 /var/www/html/wp-content/

# PHP-FPM을 포그라운드모드로 실행하여, php코드를 처리할 수 있게 한다.
/usr/sbin/php-fpm8 -F
