#repository uri
BACK_REPO = git@github.com:42Seoul-Tea42/backend.git
FRONT_REPO = git@github.com:42Seoul-Tea42/frontend.git
SERVICE_REPO = git@github.com:42Seoul-Tea42/service.git
ENV_REPO = git@github.com:42Seoul-Tea42/env.git
#add some...

#repo array
SUBMODULES = $(BACK_REPO) $(FRONT_REPO) $(SERVICE_REPO) $(ENV_REPO)

#기본 룰
all : .gitmodules
	mkdir -p ./service/postgresql/database
	ln ./env/.env ./service/

.gitmodules:
	$(foreach submodule, $(SUBMODULES), git submodule add -b main $(submodule);)

#저장소 업데이트
pull :
	git submodule update --remote
