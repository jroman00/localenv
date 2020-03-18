#!/usr/bin/env bash

set -e

readonly PARENT_DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd -P)
readonly LOCALENV_DIR=$(cd $(dirname "$PARENT_DIR") && pwd -P)

readonly BIN_DIR=$LOCALENV_DIR/bin

source $BIN_DIR/utils/shell-helpers.sh

# Main function
main() {
  echo_yellow "Stopping localenv..."

  # Stop repos
  bash $BIN_DIR/repos/stop-repos.sh

  # Stop databases
  bash $BIN_DIR/globals/stop-global-databases.sh

  # Stop cache
  bash $BIN_DIR/globals/stop-global-cache.sh

  echo_green "localenv successfully stopped!\n"
}

main
