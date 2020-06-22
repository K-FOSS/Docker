#!/bin/sh
PROGRAM="${1}"

if [[ "${PROGRAM}" == "" ]]; then
  echo "You did not provide a service name"
  exit 1
fi

PROGRAM_SOURCE="${PROGRAM}SourceScratch"
PROGRAM_IMAGE="${PROGRAM}Scratch"

docker buildx bake -f ./docker-compose.build.source.yml ${PROGRAM_SOURCE}
docker buildx bake -f ./docker-compose.build.yml ${PROGRAM_IMAGE} --progress plain