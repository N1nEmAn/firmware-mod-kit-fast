#!/bin/bash

# Color codes
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
END='\033[0m'

# Check if debug mode is enabled
DEBUG=false
if [ "$1" == "-d" ]; then
  DEBUG=true
  shift
fi

# Define variables
BIN_PATH="/usr/bin/fmk"
SCRIPT_PATH="$(pwd)/fmk.sh"

# Check if the script file exists
if [ ! -f "$SCRIPT_PATH" ]; then
  echo -e "${RED}[-]${END} Script file fmk.sh not found in the current directory."
  exit 1
fi

# Install the script to /usr/bin
if $DEBUG; then
  sudo cp "$SCRIPT_PATH" "$BIN_PATH"
  sudo chmod +x "$BIN_PATH"
else
  sudo cp "$SCRIPT_PATH" "$BIN_PATH" >/dev/null
  sudo chmod +x "$BIN_PATH" >/dev/null
fi

if [ $? -ne 0 ]; then
  echo -e "${RED}[-]${END} Failed to install the script to /usr/bin."
  exit 1
fi

echo -e "${GREEN}[+]${END} The script has been installed to /usr/bin as 'fmk'. You can now use the 'fmk' command from any directory."
