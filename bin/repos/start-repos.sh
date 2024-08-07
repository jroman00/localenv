#!/usr/bin/env bash

set -e

readonly PARENT_DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd -P)
readonly LOCALENV_DIR=$(cd $(dirname $(dirname "$PARENT_DIR")) && pwd -P)

readonly BIN_DIR=$LOCALENV_DIR/bin
readonly APPS_DIR=$LOCALENV_DIR/applications
readonly CONFIGS_DIR=$LOCALENV_DIR/configs

source $BIN_DIR/utils/shell-helpers.sh

# Main function
main() {
  echo_yellow "Starting repositories..."

  for APPLICATION_DIR in $(ls -d ${APPS_DIR}/*); do
    echo_yellow "Starting $(basename $APPLICATION_DIR) repository..."

    if [ -f "$APPLICATION_DIR/bin/local-start.sh" ] ; then
      echo_yellow "Running local-start script for repo $(basename $APPLICATION_DIR)..."

      bash $APPLICATION_DIR/bin/local-start.sh
    else
      echo_red "Local-start script does not exist for repo $(basename $APPLICATION_DIR). You may want to add that..."
    fi
  done

  echo_green "Repositories started successfully!\n"
}

main
