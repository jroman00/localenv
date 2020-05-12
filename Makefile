.DEFAULT_GOAL := help

clone-repos:
	bash ./bin/repos/clone-repos.sh

init:
	bash ./bin/init.sh

setup-docker-network:
	bash ./bin/globals/setup-docker-network.sh

#############################################################
# "Help Documentation"
#############################################################

help:
	@echo "  localenv Commands"
	@echo "  |"
	@echo "  |_ help (default)              - Show this message"
	@echo "  |_ clone-repos                 - Clone all repos from configs/repos.json to the applications directory"
	@echo "  |_ init                        - Initialize the localenv ecosystem"
	@echo "  |_ setup-docker-network        - Set up the localenv Docker bridge network (i.e. localenv_network)"
	@echo "  |__________________________________________________________________________________________"
	@echo " "

.PHONY:
	clone-repos
	init
	setup-docker-network
