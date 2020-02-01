ARG DOCKER_SOURCE_IMAGE=kfoss/source-docker

FROM ${DOCKER_SOURCE_IMAGE} as dockerbuild
RUN echo 'user:x:1000:1000:Linux User,,,:/home/user:/bin/zsh' > /tmp/passwd \
  && mkdir -p /home/user \
  && chown 1000:1000 /home/user

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
  --enable-ldflags=-static \
  --without-tcsetpgrp \
  && make

FROM scratch
COPY --from=zshbuild /tmp/zsh/Src/zsh /bin/zsh
COPY --from=dockerbuild /tmp/passwd /etc/passwd
COPY --from=dockerbuild /tmp/docker/docker /bin/docker

USER user
COPY --from=dockerbuild --chown=1000:1000 /home/user /home/user
COPY --from=zshbuild /usr/share/terminfo/v/vt100* /usr/share/terminfo/v/
ENV TERM=vt100
ENTRYPOINT [ "zsh" ]