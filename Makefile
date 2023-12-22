#repository uri
BACK_REPO = git@github.com:42Seoul-Tea42/backend.git
FRONT_REPO = git@github.com:42Seoul-Tea42/frontend.git
SERVICE_REPO = git@github.com:42Seoul-Tea42/service.git
ENV_REPO = git@github.com:42Seoul-Tea42/env.git
#add some...

#repo array
SUBMODULES = $(BACK_REPO) $(FRONT_REPO) $(SERVICE_REPO) $(ENV_REPO)

#make
all : default

default : .gitmodules
	# git submodule update --init --recursive
	# git submodule update --remote
	mkdir -p ./service/postgresql/database
	@ln ./env/.env ./service/
	@if docker info | grep -q "not" || docker info | grep -q "ERROR"; then \
		echo "\033[0;96m--- Docker will be running soon ---"; \
		echo "y" | ./service/utils/init_docker.sh; \
		while docker info | grep -q "ERROR"; do \
			sleep 1; \
		done >/dev/null 2>&1; \
	else \
		echo "\033[0;96m--- Docker is already running ---"; \
	fi
	docker-compose -f ./service/docker-compose.yml up --build

.gitmodules:
	$(foreach submodule, $(SUBMODULES), git submodule add -b main $(submodule);)

#make pull
pull:
	git submodule update --remote


down	: 
	docker-compose -f ./service/docker-compose.yml down
	@rm -rf default

clean	:
	make down
	@docker system prune -af

fclean	:
	make clean
	@docker volume rm $$(docker volume ls -q -f dangling=true) || docker volume ls

re		:
	make fclean
	make all
