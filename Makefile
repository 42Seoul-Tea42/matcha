# 레포 경로
BACK_REPO = git@github.com:42Seoul-Tea42/backend.git
FRONT_REPO = git@github.com:42Seoul-Tea42/frontend.git
SERVICE_REPO = git@github.com:42Seoul-Tea42/service.git
ENV_REPO = git@github.com:42Seoul-Tea42/env.git
DOCS_REPO = git@github.com:42Seoul-Tea42/matcha-docs.git

# 서브모듈 레포
SUBMODULES = $(BACK_REPO) $(FRONT_REPO) $(SERVICE_REPO) $(ENV_REPO) $(DOCS_REPO)


# 도커컴포즈 의존성
DB := ./service/postgresql/database
ENV_FILE := .env
DOCKER_COMPOSE_FILE := docker-compose.yml

all: .compose_dependency
	docker compose up --build

.compose_dependency: .gitmodules
	@mkdir -p $(DB)
	@ln -f ./env/$(ENV_FILE) $(ENV_FILE)
	@ln -f ./service/$(DOCKER_COMPOSE_FILE) $(DOCKER_COMPOSE_FILE)

.gitmodules:
	$(foreach submodule, $(SUBMODULES), git submodule add -b main $(submodule);)

# 도커 명령어
down: 
	docker-compose down
	@rm -rf $(NAME)

clean:
	make down
	@docker system prune -af

fclean:
	make clean
	@docker volume rm $$(docker volume ls -q -f dangling=true) || docker volume ls

re:
	make fclean
	make all

#저장소 업데이트
pull:
	git submodule update --remote

.phony: up down clean fclean re pull