ARG ALPINE='alpine'
ARG NODE='node:alpine'

FROM ${NODE} as builder
ONBUILD ARG BASE_SRC_PATH='.'
ONBUILD WORKDIR /src/app

ONBUILD COPY ${BASE_SRc_PATH}/package.json ${BASE_SRC_PATH}/package-lock.json ${BASE_SRC_PATH}/tsconfig.json ./
ONBUILD RUN npm ci

ONBUILD ARG BUILD_FILES='./README.md'
ONBUILD COPY ${BASE_SRC_PATH}/src ./src
ONBUILD COPY ${BUILD_FILES} ./

ONBUILD ENV NODE_ENV production

ONBUILD ARG BUILD_CMD='npm run build'
ONBUILD RUN ${BUILD_CMD}

FROM ${NODE} as fetcher
ONBUILD ARG BASE_SRC_PATH='.'
ONBUILD WORKDIR /src/app
ONBUILD COPY ${BASE_SRC_PATH}/package.json ${BASE_SRC_PATH}/package-lock.json ${BASE_SRC_PATH}/tsconfig.json ./
ONBUILD RUN npm ci
