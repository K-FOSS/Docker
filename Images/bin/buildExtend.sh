#!/bin/sh
EXTEND_FILE="docker-compose.build.extend.yml"

PROGRAM="${1}"

if [[ "${PROGRAM}" == "" ]]; then
  echo "You did not provide a service name"
  exit 1
fi

docker buildx bake -f ${EXTEND_FILE} ${PROGRAM}