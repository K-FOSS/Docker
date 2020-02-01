#!/usr/bin/env sh
exec docker run --rm --init -it --workdir /tmp/test -v "${PWD}/tmp:/tmp/test" kristianfoss/programs-git:git "${@}"