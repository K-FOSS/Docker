#!/bin/sh
BUILDER_IMAGE="$(sudo docker build --build-arg CLI_NAME=docker -q ./Docker/)"

exec sudo docker run -it --workdir /workspace -v $PWD:/workspace -v /etc/passwd:/etc/passwd --privileged  -v /var/run/docker.sock:/var/run/docker.sock --rm "${BUILDER_IMAGE}" ${@}