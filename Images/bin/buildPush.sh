#!/bin/bash
BASEDIR=$(dirname "$0")

# BUILDER="${BASEDIR}/buildBuilder.sh"
# DOCKER_IMAGE="$(${BUILDER})"
# RUNNER="${BASEDIR}/runner.sh ${DOCKER_IMAGE}"

PUSH_IMAGES="kristianfoss/programs-vault \
  kristianfoss/programs-step \
  kristianfoss/programs-keybase \
  kristianfjones/bin-installer \
  kristianfoss/builders-node \
  kristianfoss/programs-git \
  kristianfoss/programs-caddy \
  kristianfoss/programs-gomtr \
  kristianfoss/programs-mtr \
  kristianfoss/programs-teleport \
  kristianfoss/programs-openssh \
  kristianfoss/programs-gcloud"


cd "${BASEDIR}/../Extras/Builder/"
./setup.sh
docker-compose up -d --build

echo ${PASSWORD} | docker-compose exec -w /workspace Docker docker login -u ${USERNAME} --password-stdin
docker-compose exec -T -w /workspace Docker docker buildx bake --pull -f ./docker-compose.build.yml
docker-compose exec -T -w /workspace Docker docker image ls

# ${RUNNER} buildx bake -f ./docker-compose.build.yml


# for IMAGE in ${PUSH_IMAGES}; do
#   docker push ${IMAGE}
# done