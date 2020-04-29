#!/bin/bash
BASEDIR=$(dirname "$0")

# BUILDER="${BASEDIR}/buildBuilder.sh"
# DOCKER_IMAGE="$(${BUILDER})"
# RUNNER="${BASEDIR}/runner.sh ${DOCKER_IMAGE}"


cd "${BASEDIR}/../Extras/Builder/"
./setup.sh
docker-compose up -d --build

docker-compose exec -T -w /workspace Docker docker buildx bake --progress plain  --pull -f ./docker-compose.build.yml