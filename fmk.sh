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

# Check if firmware file path is provided
if [ -z "$1" ]; then
  echo -e "${RED}[-]${END} Please provide the firmware file path.\n${YELLOW}[*]${END} Usage:  $0 [-d] <firmware_file_path>"
  rm to_ana_bin && exit 1
fi

FIRMWARE_FILE=$1
CONTAINER_NAME="firmware_mod_kit_container"
LOCAL_FOLDER=$(pwd)
TO_ANA_BIN="to_ana_bin"

echo -e "${YELLOW}[*]${END} Start extracting..."

# Start Docker container
if $DEBUG; then
  docker run -itd --name $CONTAINER_NAME --rm n1neman/fmk
else
  docker run -itd --name $CONTAINER_NAME --rm n1neman/fmk >/dev/null
fi

if [ $? -ne 0 ]; then
  echo -e "${RED}[-]${END} Failed to start Docker container."
  rm to_ana_bin && exit 1
fi

# Copy firmware file to temporary file
cp "$FIRMWARE_FILE" "$TO_ANA_BIN"

# Copy firmware file to Docker container
if $DEBUG; then
  docker cp "$TO_ANA_BIN" "$CONTAINER_NAME:/firmware-mod-kit/"
else
  docker cp "$TO_ANA_BIN" "$CONTAINER_NAME:/firmware-mod-kit/" >/dev/null
fi

if [ $? -ne 0 ]; then
  echo -e "${RED}[-]${END} Failed to copy firmware file to Docker container."
  docker stop $CONTAINER_NAME
  rm to_ana_bin && exit 1
fi

# Extract firmware file in Docker container
if $DEBUG; then
  docker exec -it $CONTAINER_NAME bash -c "cd /firmware-mod-kit && ./extract-firmware.sh $TO_ANA_BIN"
else
  docker exec -it $CONTAINER_NAME bash -c "cd /firmware-mod-kit && ./extract-firmware.sh $TO_ANA_BIN" >/dev/null
fi

if [ $? -ne 0 ]; then
  echo -e "${RED}[-]${END} Failed to extract firmware file."
  docker stop $CONTAINER_NAME >/dev/null
  rm to_ana_bin && exit 1
fi

# Copy extracted folder back to host
if $DEBUG; then
  docker cp "$CONTAINER_NAME:/firmware-mod-kit/fmk" "$LOCAL_FOLDER"
else
  docker cp "$CONTAINER_NAME:/firmware-mod-kit/fmk" "$LOCAL_FOLDER" >/dev/null
fi

if [ $? -ne 0 ]; then
  echo -e "${RED}[-]${END} Failed to copy extracted folder."
  docker stop $CONTAINER_NAME >/dev/null
  rm to_ana_bin && exit 1
fi

# Stop and remove Docker container
if $DEBUG; then
  docker rm -f $CONTAINER_NAME
else
  docker rm -f $CONTAINER_NAME >/dev/null
fi

# Delete temporary file
if $DEBUG; then
  rm "$TO_ANA_BIN"
else
  rm "$TO_ANA_BIN" >/dev/null
fi

echo -e "${GREEN}[+]${END} Firmware file extracted and copied to the fmk folder in the current directory."
