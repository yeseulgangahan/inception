# FROM: 기본 이미지를 설정한다. 유효한 Dockerfile은 FROM으로 시작해야 한다.

# RUN: 쉘형식으로 쓸 경우 명령은 쉘에서 실행된다.

# EXPOSE: 컨테이너가 지정된 네트워크 포트에서 수신대기함을 도커에게 알려준다.
#         80으로 쓸 경우 default는 80/tcp
#         이미지를 빌드하는 사람과 컨테이너를 실행하는 사람 사이의 일종의 문서 역할일 뿐이다.

# COPY: src를 컨테이너 파일시스템의 dest 경로에 추가한다.

# (여기까지가 빌드 시 사용됨)

# ENTRYPOINT: 해당 컨테이너가 수행될 때 '반드시' ENTRYPOINT 에서 지정한 명령을 수행되도록 지정된다.

# CMD: default를 제공하는 것에 목적이 있다. JSON 배열로 표현할 경우 실행파일의 전체경로를 제공
#      (여러 개 있을 경우 마지막 CMD만 영향이 있다.)


################################################################################

# openssl req
# : '인증서 요청' 및 '인증서' 생성을 위한 유틸리티
#
# -x509: '인증서 요청' 대신 '자체 서명 인증서'를 출력한다
# -nodes: 개인 키가 생성되었을 경우 암호화되지 않는다
# -days n: -x509 옵션이 사용되었을 때, 인증서의 유효기간 (default: 30)
# -newkey rsa:nbits: RSA key를 nbits 사이즈로 생성한다
# -keyout filename: 새로 생성된 개인 키를 적을 파일이름 (default: 설정파일에 명시되어 있음)
# -out filename: 출력결과(인증서)를 적을 파일이름 (default: STDOUT)
# -subj arg: 입력요청의 제목 필드를 지정된 데이터로 대체 및 수정된 요청을 출력
#   C: Country
#   ST: State
#   O: Organization
#   CN: common name. ssl 인증서로 보호되는 server name

FROM alpine:3.16

RUN  apk update && apk upgrade && apk add --no-cache nginx && \
     apk add openssl && \
     mkdir -p /etc/nginx/ssl && \
     openssl req -x509 -nodes \
     -days 365 \
     -newkey rsa:2048 \
     -keyout /etc/nginx/ssl/yehan.42.fr.key \
     -out /etc/nginx/ssl/yehan.42.fr.crt \
     -subj "/C=KR/ST=Seoul/O=42Seoul/OU=yehan/CN=inception/" &&\
     chown nginx /etc/nginx/ssl/yehan.42.fr.crt && \
     chown nginx /etc/nginx/ssl/yehan.42.fr.key

EXPOSE 443

COPY ./requirements/nginx/conf/* /etc/nginx/http.d/

CMD ["nginx", "-g", "daemon off;"]
