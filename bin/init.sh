#!/usr/bin/env bash

set -e

readonly PARENT_DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd -P)
readonly LOCALENV_DIR=$(cd $(dirname "$PARENT_DIR") && pwd -P)

readonly BIN_DIR=$LOCALENV_DIR/bin
readonly CONFIGS_DIR=$LOCALENV_DIR/configs

source $BIN_DIR/utils/shell-helpers.sh

# Validate requirements before initializing
validate_requirements() {
  # Validate jq is installed
  if ! type "jq" > /dev/null 2>&1 ; then
    echo_red "Missing dependency: jq"
    echo_red "See the Prerequisites section of README.md"
    exit 1
  fi

  # Confirm repos.json exists
  if [ ! -s $CONFIGS_DIR/repos.json ] ; then
    echo_red "configs/repos.json is either missing or empty"
    echo_red "See the Configuration section of README.md"
    exit 1
  fi
}

# Main function
main() {
  echo_yellow "Initializing localenv..."

  # Initialize network
  bash $BIN_DIR/globals/setup-docker-network.sh

  # Initialize databases
  bash $BIN_DIR/globals/init-global-databases.sh

  # Initialize cache
  bash $BIN_DIR/globals/init-global-cache.sh

  # Initialize repos
  bash $BIN_DIR/repos/clone-repos.sh
  bash $BIN_DIR/repos/init-repos.sh

  echo_green "localenv successfully initialized!\n"
}

validate_requirements
main
