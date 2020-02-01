ARG DOCKER_SOURCE_IMAGE=kristianfjones/docker:cli

FROM alpine:3.11 as usermaker
RUN echo 'user:x:1000:1000:Linux User,,,:/home/user:/bin/zsh' > /tmp/passwd \
  && mkdir -p /home/user \
  && chown 1000:1000 /home/user

RUN mkdir /.docker/ \
  && echo '{ "experimental": "enabled" }' >> /.docker/config.json

FROM golang:1.12.14-alpine as dockerbuild
RUN  apk add -U git bash coreutils gcc musl-dev
RUN mkdir -p /tmp/docker \
  && wget -O - https://codeload.github.com/docker/cli/tar.gz/master | tar xz -C /tmp/docker --strip-components=1 \
  && go get github.com/docker/cli/cmd/docker

RUN cd /tmp/docker \
  && ./scripts/build/binary

FROM alpine:3.11 as zshbuild
RUN apk add --no-cache \
  yodl \
  ncurses-dev \
  ncurses-static \
  diffutils ncurses autoconf musl-dev musl make perl man gcc g++ busybox --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing

RUN mkdir -p /tmp/zsh \
  && wget -O - https://codeload.github.com/zsh-users/zsh/tar.gz/master | tar xz -C /tmp/zsh --strip-components=1

RUN cd /tmp/zsh \
  && ./Util/preconfig \
  && ./configure \
  --disable-dynamic \
  --enable-zshrc=/.zshrc \
  --enable-ldflags=-static \
  --without-tcsetpgrp \
  && make

FROM scratch
COPY --from=dockerbuild /tmp/docker/build/docker-linux-amd64 /bin/docker
COPY --from=zshbuild /lib/ld-musl-x86_64.so.1 /lib/libc.musl-x86_64.so.1 /lib/
COPY --from=zshbuild /tmp/zsh/Src/zsh /bin/ls /bin/touch /bin/
COPY --from=usermaker /tmp/passwd /etc/passwd
COPY --from=usermaker /.docker /.docker


USER user
COPY --from=usermaker --chown=1000:1000 /home/user /home/user
COPY --from=zshbuild /usr/share/terminfo/v/vt100* /usr/share/terminfo/v/
ENV TERM=vt100
ADD aliases /.zshrc
ENTRYPOINT [ "/bin/zsh" ]