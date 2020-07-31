#!/bin/sh
ENV_FILE=".env"
VOLUME_NAME=""
COMPOSE_FILE="docker-compose.yml"
CHOWN_IMAGE="kristianfoss/programs-chown:chown-stable-scratch"
LS_IMAGE="kristianfoss/programs-ls:ls-stable-scratch"

# Author bmmuller
# Source: https://gist.github.com/judy2k/7656bfe3b322d669ef75364a46327836#gistcomment-3239799
function export_envs() {
  local envFile=${1:-.env}
  while IFS='=' read -r key temp || [ -n "$key" ]; do
    local isComment='^[[:space:]]*#'
    local isBlank='^[[:space:]]*$'
    [[ $key =~ $isComment ]] && continue
    [[ $key =~ $isBlank ]] && continue
    value=$(eval echo "$temp")
    eval export "$key='$value'";
  done < $envFile
}

function error_exit() {
	echo "$1" 1>&2
	exit 1
}

# Get env variables from .env
export_envs ${ENV_FILE}

SOCKET_VOLUME_NAME="${DEVELOPMENT_NAME}-socket"

if [ "$(docker volume ls -q -f name=${SOCKET_VOLUME_NAME})" == "" ]; then
  echo "Volume doesn't exist"
  if ! docker volume create "${SOCKET_VOLUME_NAME}" >/dev/null; then
    error_exit "Cannot create docker volume!  Aborting."
  fi;
fi

docker run -it --rm -v ${SOCKET_VOLUME_NAME}:/tmp/data/socket --user 0 ${CHOWN_IMAGE} -R 1000:1000 /tmp
