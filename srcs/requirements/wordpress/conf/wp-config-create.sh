#!bin/sh
#!/bin/bash

# 설정파일 wp-config.php이 없으면, 파일을 만들어 다음의 내용을 넣어준다.

# WP_DEBUG: 디버그모드를 사용하면 보안상 취약하므로 운영환경에서는 비활성화한다
# ABSPATH: WordPress 설치 경로의 절대 경로. __DIR__은 wp-config.php파일이 위치한 디렉토리

# WP_REDIS_HOST: redis캐시를 사용
# WP_REDIS_PORT: redis캐시를 사용하기 위한 포트 번호
# WP_REDIS_TIMEOUT: redis캐시 서버에서 데이터를 연결할 때 타임아웃값 (초)
# WP_REDIS_READ_TIMEOUT: redis캐시 서버에서 데이터를 읽을 때 타임아웃값 (초)
# WP_REDIS_DATABASE: redis캐시를 위해 사용할 데이터베이스 번호를 0(최우선)으로 정의

# require_once: 지정된 파일을 한 번만 로드하는 지시자. wp-settings.php에 있는 변수들과 인클루드파일을 세팅한다

if [ ! -f "/var/www/html/wp-config.php" ]; then
cat << EOF > /var/www/html/wp-config.php
<?php
define( 'DB_NAME', '${DB_NAME}' );
define( 'DB_USER', '${DB_USER}' );
define( 'DB_PASSWORD', '${DB_PASS}' );
define( 'DB_HOST', 'mariadb' );
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );
define('FS_METHOD','direct');
\$table_prefix = 'wp_';
define( 'WP_DEBUG', false );
if ( ! defined( 'ABSPATH' ) ) {
define( 'ABSPATH', __DIR__ . '/' );}
define( 'WP_REDIS_HOST', 'redis' );
define( 'WP_REDIS_PORT', 6379 );
define( 'WP_REDIS_TIMEOUT', 1 );
define( 'WP_REDIS_READ_TIMEOUT', 1 );
define( 'WP_REDIS_DATABASE', 0 );
require_once ABSPATH . 'wp-settings.php';
EOF
fi
