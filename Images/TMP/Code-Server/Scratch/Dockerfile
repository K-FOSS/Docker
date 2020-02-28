ARG FINAL_BASE='scratch'
ARG ALPINE='alpine:3.11'
ARG githubToken

FROM node:12-alpine as builder
ENV VSCODE_VERSION="1.41.1"
ARG githubToken

RUN apk add --no-cache libxkbfile-dev libsecret-dev build-base git bash python
RUN git clone -b anmol-restructure https://github.com/cdr/code-server.git /src

ENV MINIFY=true
ENV LDFLAGS="-static"

WORKDIR /src
RUN yarn \
  && yarn build

FROM ${ALPINE} as prepareUser
RUN mkdir -p /tmp/user/etc \
  && echo 'coder:x:1000:1000:Linux User,,,:/home/coder:/usr/sbin/nologin' > /tmp/user/etc/passwd \
  && mkdir -p /tmp/user/home/coder/project \
  && mkdir -p /tmp/user/home/coder/.local/share/code-server/logs \
  && chown -R 1000:1000 /tmp/user/home/coder


FROM ${ALPINE} as prepareCodeServer
COPY --from=prepareUser /tmp/user /tmp/code-server
COPY --from=builder /usr/lib/libstdc++.so.6 /usr/lib/libgcc_s.so.1 /tmp/code-server/usr/lib/
COPY --from=builder /src/build /tmp/code-server/src/build
COPY --from=builder /src/binaries/code-server* /tmp/code-server/usr/local/bin/code-server

FROM node:12-alpine3.11
RUN apk add --no-cache dumb-init openssl vim sudo git net-tools curl wget ca-certificates

# We cannot use update-locale because docker will not use the env variables
# configured in /etc/default/locale so we need to set it manually.
ENV LC_ALL=en_US.UTF-8 \
  SHELL=/bin/bash

RUN adduser --gecos '' --disabled-password coder && \
  echo "coder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/nopasswd

COPY --from=kristianfoss/programs-git /git /usr/bin/git
COPY --from=builder /src/build /src/build

RUN chown -R coder:coder /src


USER coder
# Create first so these directories will be owned by coder instead of root
# (workdir and mounting appear to both default to root).
RUN mkdir -p /home/coder/project
RUN mkdir -p /home/coder/.local/share/code-server/logs


WORKDIR /home/coder/project

# This ensures we have a volume mounted even if the user forgot to do bind
# mount. So that they do not lose their data if they delete the container.
VOLUME [ "/home/coder/project" ]


# ENTRYPOINT ["dumb-init", "code-server", "--host", "0.0.0.0"]
ENTRYPOINT ["node", "/src/build/out/node/entry.js", "--host", "0.0.0.0", "-vvv"]