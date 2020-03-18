#!/usr/bin/env bash

set -e

# Set BIN_ROOT, the location of the `bin` directory
readonly BIN_ROOT=$(cd $( dirname "${BASH_SOURCE[0]}" )/../ && pwd )

# Setup input variables
INPUT_FILE=""
OUTPUT_FILE=""
PASSWORD_FILE="$HOME/.localenv-av-password"

# Include shell helpers
source $BIN_ROOT/utils/shell-helpers.sh

# Main functionality of the script
main() {
  echo_yellow "Decrypting local vaulted file..."

  print_debug_info

  # If the password file exists, use it
  # else do a standard decrypt to prompt for the password
  if [[ -f "$PASSWORD_FILE" ]] ; then
    ansible-vault decrypt --output $OUTPUT_FILE --vault-password-file $PASSWORD_FILE $INPUT_FILE
  else
    ansible-vault decrypt --output $OUTPUT_FILE $INPUT_FILE
  fi

  echo_green "Local vaulted file has been successfully decrypted!\n"
}

# Function that print out debug info
print_debug_info() {
  echo_yellow "Debug info:"
  echo_yellow "  Input file: $INPUT_FILE"
  echo_yellow "  Output file: $OUTPUT_FILE"
  echo_yellow "  Password file: $PASSWORD_FILE"
}

# Function that verifies required input was passed in
verify_input() {
  # Verify required inputs are not empty
  [ ! -z "$INPUT_FILE" ] && [ ! -z "$OUTPUT_FILE" ]
}

# Function that outputs usage information
usage() {
  cat <<EOF

Usage: $BIN_ROOT/$(basename $0) <options>

Script used to decrypt an application's sensitive files for local development

Options:
  -i (required)     The input file
  -o (required)     The output file
  -p                The password file
  -h|--help         Print this message and quit

EOF
  exit 0
}

# Parse input options
while getopts ":i:o:p:h-:" opt; do
  case "$opt" in
    i) INPUT_FILE=$OPTARG;;
    o) OUTPUT_FILE=$OPTARG;;
    p) PASSWORD_FILE=$OPTARG;;
    h) usage;;
    -)
      case "${OPTARG}" in
        help) usage;;
        *) usage;;
      esac
    ;;
    \?) echo_red "Invalid option: -$OPTARG." && usage;;
    :) die "Option -$OPTARG requires an argument.";;
  esac
done

# Verify input
! verify_input && echo_red "Missing script options." && usage

# Execute main functionality
main
