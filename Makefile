#레포 경로
BACK_REPO = git@github.com:42Seoul-Tea42/backend.git
FRONT_REPO = git@github.com:42Seoul-Tea42/frontend.git
SERVICE_REPO = git@github.com:42Seoul-Tea42/service.git
ENV_REPO = git@github.com:42Seoul-Tea42/env.git
#add some...

#서브모듈
SUBMODULES = $(BACK_REPO) $(FRONT_REPO) $(SERVICE_REPO) $(ENV_REPO)

#기본룰
DB := ./service/postgresql/database
ENV_FILE := .env
DOCKER_COMPOSE_FILE := docker-compose.yml

all: .gitmodules .compose_dependency
	docker compose up --build

# 도커컴포즈 의존성 관계
.compose_dependency:
	@mkdir -p $(DB)
	@ln -f ./env/$(ENV_FILE) $(ENV_FILE)
	@ln -f ./service/$(DOCKER_COMPOSE_FILE) $(DOCKER_COMPOSE_FILE)

# 서브모듈 가져오기
link : .gitmodules @echo "Module ready"

.gitmodules:
	$(foreach submodule, $(SUBMODULES), git submodule add -b main $(submodule);)

# 도커 명령어
down	: 
	docker-compose down
	@rm -rf $(NAME)

clean	:
	make down
	@docker system prune -af

fclean	:
	make clean
	@docker volume rm $$(docker volume ls -q -f dangling=true) || docker volume ls

re		:
	make fclean
	make all

#저장소 업데이트
pull :
	git submodule update --remote

.phony: up down clean fclean re pull
