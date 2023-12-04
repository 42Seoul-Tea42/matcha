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
	git submodule update --init --recursive
	git submodule update --remote

.gitmodules:
	$(foreach submodule, $(SUBMODULES), git submodule add -b main $(submodule);)

#make pull
pull:
	git submodule update --remote
