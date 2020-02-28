#!/bin/sh
VOLUME_NAME="step-ca-data"

CLI_IMAGE_REPO="kristianfoss/programs-step"
CLI_TAG="scratch-cli"
CLI_IMAGE="${CLI_IMAGE_REPO}:${CLI_TAG}"

docker volume create ${VOLUME_NAME}

docker run -it --rm -v ${VOLUME_NAME}:/.step ${CLI_IMAGE} ca init