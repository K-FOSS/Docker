echo "Building Shell Stack"

DOCKER_REPO="kristianfjones/docker"
ZSH_REPO="kristianfjones/zsh"
DOCKER_CLI_TAG="cli"
DOCKER_DAEMON_TAG="daemon"

if [ ! "docker ps -q -f name=kristianjones/docker" ]; then
  echo "Docker images from Docker Stack have not been built. Do that first"
fi;

# Tags Docker image
function tagDockerImage() {
    docker tag $1 ${ZSH_REPO}:$2
}


echo "Creating ZSH Shell Image"
ZSH_IMAGE="$(docker build -q --compress --force-rm ./ZSH/)"

tagDockerImage $ZSH_IMAGE "shell"