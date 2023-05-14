# docker-compose : 복수의 컨테이너 어플리케이션을 정의하고, 도커로 실행한다

# up: 컨테이너들을 생성하고 시작한다.
#     기존 컨테이너가 있고 컨테이너 생성 후 서비스나 이미지가 변경된 경우, 컨테이너를 중지하고 재생성한다.
# down: compose file에 정의된 컨테이너를 중지하고, up으로 생성한 컨테이너, 네트워크를 제거한다. (default) 

# -f: compose configuration file의 경로와 이름을 명시한다. (default: docker-compose.yml)
# --env-file: 이미지를 빌드할 때 참고할 환경변수 파일의 경로를 명시한다.
# --build: 기존에 빌드된 이미지가 있는 경우에도 새로 빌드한다.

# docker system prune: 멈춰있는 컨테이너, 사용 중이지 않는 네트워크, 연관된 이미지, 연관된 빌드 캐시 모두 삭제
# docker network prune: 사용 중이지 않은 네트워크 모두 삭제
# docker volume prune: 사용 중이지 않은 볼륨 모두 삭제

name = inception

all:
	@mkdir -p ~/data/wordpress
	@mkdir -p ~/data/mariadb
	@printf "Launch configuration ${name}...\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d

build:
	@mkdir -p ~/data/wordpress
	@mkdir -p ~/data/mariadb
	@printf "Building configuration ${name}...\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d --build

down:
	@printf "Stopping configuration ${name}...\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env down

re: down
	@printf "Rebuild configuration ${name}...\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d --build

clean: down
	@printf "Cleaning configuration ${name}...\n"
	@docker system prune -a

fclean:
	@printf "Total clean of all configurations docker\n"
	@docker stop $$(docker ps -qa)
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force
	@sudo rm -rf ~/data

.PHONY	: all build down re clean fclean
