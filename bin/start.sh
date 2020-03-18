#!/usr/bin/env bash

set -e

readonly PARENT_DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd -P)
readonly LOCALENV_DIR=$(cd $(dirname "$PARENT_DIR") && pwd -P)

readonly BIN_DIR=$LOCALENV_DIR/bin

source $BIN_DIR/utils/shell-helpers.sh

# Main function
main() {
  echo_yellow "Starting localenv..."

  # Start databases
  bash $BIN_DIR/globals/start-global-databases.sh

  # Start cache
  bash $BIN_DIR/globals/start-global-cache.sh

  # Start repos
  bash $BIN_DIR/repos/start-repos.sh

  echo_green "localenv successfully started!\n"
}

main
