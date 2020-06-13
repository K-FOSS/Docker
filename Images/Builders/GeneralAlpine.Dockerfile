ARG ALPINE='alpine:3.11'

## Build
ARG BUILD_SETUP=''
ARG BUILD_CMD=''
ARG BUILD_PKGS=''
ARG BUILD_PKG_ARGS=''


FROM ${ALPINE} as builder
ARG SRC_URL=''
ARG SRC_CMD="wget -O - ${SRC_URL}"
ARG SRC_EXTRACT="tar xz -C /tmp/src --strip-components=1"

ARG BUILD_SETUP
ARG BUILD_PKGS
ARG BUILD_PKG_ARGS

RUN apk add --no-cache ${BUILD_PKG_ARGS} build-base autoconf automake ${BUILD_PKGS}

RUN mkdir -p /tmp/src \
  && ${SRC_CMD} | ${SRC_EXTRACT}

ENV GO111MODULE=on
RUN cd /tmp/src \
  && ${BUILD_SETUP} \
  && ${BUILD_CMD}