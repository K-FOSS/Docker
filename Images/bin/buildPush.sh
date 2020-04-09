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
docker-compose exec -T -w /workspace Docker docker buildx bake -f ./docker-compose.build.yml


# ${RUNNER} buildx bake -f ./docker-compose.build.yml


# for IMAGE in ${PUSH_IMAGES}; do
#   docker push ${IMAGE}
# done