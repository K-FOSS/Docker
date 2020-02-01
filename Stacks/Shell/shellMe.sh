echo "Building Shell Stack"

DOCKER_REPO="kristianfjones/docker"
ZSH_REPO="kristianfjones/zsh"

DOCKER_CLI_TAG="cli"
DOCKER_DAEMON_TAG="daemon"

ZSH_SHELL_TAG="shell"

DOCKER_CREATE_VOLUME_CMD="docker volume create"

function createDockerVolume() {
  local newVolume="$DOCKER_CREATE_VOLUME_CMD $1"
  echo $newVolume
}

if [ ! "docker ps -q -f name=kristianjones/docker" ]; then
  echo "Docker images from Docker Stack have not been built. Do that first"
fi;

echo "Creating Volume for Docker Socket"
SOCKET_VOLUME="$(docker volume create)"

echo "Chowning the Docker Socket volume for rootless usage"
docker run -it --rm -v $SOCKET_VOLUME:/workdir alpine:3.11 chown 1000:1000 /workdir

docker run -it --rm -v shit:/workdir alpine:3.11 chown 1000:1000 /workdir

echo "Creating Docker Rootless Daemon"
DOCKER_DAEMON_CONTAINER="$(docker run -d --privileged -v ${SOCKET_VOLUME}:/run/user/1000/ -v shit:/home/ ${DOCKER_REPO}:${DOCKER_DAEMON_TAG} --experimental --rootless)"

sleep 3

echo "Creating ZSH"
docker run -it --rm -v ${SOCKET_VOLUME}:/var/run/ -v shit:/home/ ${ZSH_REPO}:${ZSH_SHELL_TAG}

function finish {
  echo "Cleaning up"

  docker rm -f ${DOCKER_DAEMON_CONTAINER}

  docker volume rm -f ${SOCKET_VOLUME}
}
trap finish EXIT