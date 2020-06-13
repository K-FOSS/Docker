#!/bin/bash
BASEDIR=$(dirname "$0")

# BUILDER="${BASEDIR}/buildBuilder.sh"
# DOCKER_IMAGE="$(${BUILDER})"
# RUNNER="${BASEDIR}/runner.sh ${DOCKER_IMAGE}"

PUSH_IMAGES="kristianfoss/programs-step \
  kristianfoss/programs-keybase \
  kristianfjones/bin-installer \
  kristianfoss/builders-node \
  kristianfoss/programs-git \
  kristianfoss/programs-caddy \
  kristianfoss/programs-gomtr \
  kristianfoss/programs-mtr \
  kristianfoss/programs-teleport \
  kristianfoss/programs-openssh \
  kristianfoss/programs-cloudflared \
  kristianfoss/programs-etcd"


cd "${BASEDIR}/../Extras/Builder/"
./setup.sh
docker-compose up -d --build

docker-compose exec -T -w /workspace Docker docker login -u ${USERNAME} -p ${PASSWORD} 
docker-compose exec -T -w /workspace Docker docker buildx bake --pull -f ./docker-compose.build.yml
docker-compose exec -T -w /workspace Docker docker image ls

# ${RUNNER} buildx bake -f ./docker-compose.build.yml


for IMAGE in ${PUSH_IMAGES}; do
  docker-compose exec -T -w /workspace Docker docker push ${IMAGE}
done