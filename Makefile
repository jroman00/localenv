.DEFAULT_GOAL := help

.PHONY: help
help: ## Show the help docs (DEFAULT)
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage: make COMMAND\n\nCommands: \033[36m\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-25s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.PHONY: clone-repos
clone-repos: ## Clone all repos from configs/repos.json to the applications directory
	bash ./bin/repos/clone-repos.sh

.PHONY: init
init: ## Initialize the localenv ecosystem
	bash ./bin/init.sh

.PHONY: setup-docker-network
setup-docker-network: ## Set up the localenv Docker bridge network (i.e. localenv_network)
	bash ./bin/globals/setup-docker-network.sh
