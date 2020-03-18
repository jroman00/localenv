#!/usr/bin/env bash

set -e

readonly PARENT_DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd -P)
readonly LOCALENV_DIR=$(cd $(dirname $(dirname "$PARENT_DIR")) && pwd -P)

readonly BIN_DIR=$LOCALENV_DIR/bin

source $BIN_DIR/utils/shell-helpers.sh

# Main function
main() {
  echo_yellow "Starting docker network..."

  readonly NETWORK_NAME=localenv_network

  if [ "$(docker network ls --format {{.Name}} | grep -w $NETWORK_NAME)" ] ; then
    echo_yellow "$NETWORK_NAME already exists"
  else
    docker network create $NETWORK_NAME --driver bridge 1> /dev/null

    echo_green "$NETWORK_NAME created"
  fi

  echo_green "Docker network started successfully!\n"
}

main
