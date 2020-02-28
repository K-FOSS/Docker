ARG FINAL_BASE='scratch'
ARG ALPINE='alpine:3.11'
ARG githubToken

FROM node:12.14.0 as builder
ENV VSCODE_VERSION="1.41.1"
ARG githubToken

RUN apt-get update && apt-get install -y \
  libxkbfile-dev \
  libsecret-1-dev

RUN git clone -b master https://github.com/cdr/code-server.git /src

ENV LDFLAGS="-static"

WORKDIR /src
RUN yarn \
  && yarn build ${VSCODE_VERSION} 2 \
  && yarn binary ${VSCODE_VERSION} 2

FROM ubuntu:19.10
RUN apt-get update && apt-get install -y \
  openssl \
  net-tools \
  git \
  locales \
  sudo \
  dumb-init \
  vim \
  curl \
  wget \
  && rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8
# We cannot use update-locale because docker will not use the env variables
# configured in /etc/default/locale so we need to set it manually.
ENV LC_ALL=en_US.UTF-8 \
  SHELL=/bin/bash

RUN adduser --gecos '' --disabled-password coder && \
  echo "coder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/nopasswd

USER coder
# Create first so these directories will be owned by coder instead of root
# (workdir and mounting appear to both default to root).
RUN mkdir -p /home/coder/project \
  && mkdir -p /home/coder/.local/share/code-server

WORKDIR /home/coder/project

# This ensures we have a volume mounted even if the user forgot to do bind
# mount. So that they do not lose their data if they delete the container.
VOLUME [ "/home/coder/project" ]

COPY --from=0 /src/binaries/code-server /usr/local/bin/code-server
EXPOSE 8080

ENTRYPOINT ["dumb-init", "code-server", "--host", "0.0.0.0"]