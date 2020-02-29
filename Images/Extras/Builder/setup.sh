#!/bin/sh
VOLUME_NAME="docker-socket"
ALPINE="alpine:3.11"

if [ ! "$(docker volume ls -q -f name=${VOLUME_NAME})" ]; then
  echo "Socket volume does not already exists. Creating now"
  # Create SSH Agent socket volume if it doesn't exist
  docker volume create ${VOLUME_NAME} &>/dev/null

  if [ ! "${?}" ]; then
    echo "Could not create socket volume" >&2
    exit 1
  else
    echo "Successfully created socket volume"
    docker run -it --rm --workdir /tmp/workdir -v ${VOLUME_NAME}:/tmp/workdir/run ${ALPINE} chown -R 0:1000 /tmp/workdir
    exit 0
  fi
else
  echo "Docker volume already exists"
  exit 0
fi
