#!/bin/sh
BUILDER_IMAGE=${1}
shift

exec docker run --user root -it --workdir /workspace -v $PWD:/workspace --privileged  -v /var/run/docker.sock:/var/run/docker.sock --rm "${BUILDER_IMAGE}" --config /root/.docker ${@}