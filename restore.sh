#!/bin/bash

if [ "${DEBUG:-false}" == "true" ]; then
  set -x
fi

: "${BACKUPS_DIR:=/backups}"
: "${DATA_DIR:=/data}"
: "${SERVER_NAME:=minecraft}"
BACKUP_FILE=$BACKUPS_DIR/$1

# server running check
NAME=$(docker ps -f "name=${SERVER_NAME}" --format "{{.Names}}")
if [ "$NAME" != "" ]; then
  if [ $(docker inspect $SERVER_NAME -f="{{.State.Running}}") == true ]; then
    echo Minecraft server running.
    exit 1
  fi
fi

# backup file check
if [ ! -f $BACKUP_FILE ]; then
  echo Not found backup file.
  exit 1
fi

echo Restore minecraft world...
cd $DATA_DIR
rm -rf world*
tar -zxvf $BACKUP_FILE > /dev/null
echo Done.

