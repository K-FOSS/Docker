#!/bin/bash
BASEDIR=$(dirname "$0")

# BUILDER="${BASEDIR}/buildBuilder.sh"
# DOCKER_IMAGE="$(${BUILDER})"
# RUNNER="${BASEDIR}/runner.sh ${DOCKER_IMAGE}"

PUSH_IMAGES="kristianfoss/programs-step \
  kristianfoss/programs-keybase \
  kristianfjones/bin-installer \
  kristianfoss/programs-pgweb \
  kristianfoss/programs-librespeed \
  kristianfoss/builders-node \
  kristianfoss/programs-git \
  kristianfoss/programs-teleport \
  kristianfoss/programs-openssh \
  kristianfoss/programs-rootlesskit \
  kristianfoss/programs-cloudflared \
  kristianfoss/programs-etcd \
  kristianfoss/source-iptables \
  kristianfoss/source-iproute2"


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