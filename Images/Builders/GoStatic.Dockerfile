ARG FINAL_BASE='scratch'
ARG GO_VERSION='1.13.6-alpine'
ARG BINARY_NAME='binary-out'
ARG BUILD_PKGS=''
ARG GIT_REPO
ARG GIT_BRANCH='master'

FROM golang:${GO_VERSION} as builder
ARG PKG_ARGS=""
ARG BUILD_PKGS
ARG GIT_REPO


RUN apk add --no-cache ${PKG_ARGS} git ca-certificates build-base ${BUILD_PKGS}

ARG GIT_REPO
ARG GIT_BRANCH
ARG BINARY_NAME
RUN mkdir -p /go/src/${BINARY_NAME} \
  && git clone -b ${GIT_BRANCH} ${GIT_REPO} /go/src/${BINARY_NAME} --single-branch

RUN mkdir -p /tmp/${BINARY_NAME}/usr/bin

ARG BUILD_SETUP
ARG GO_BUILD_ARGS

RUN cd /go/src/${BINARY_NAME} \
  && ${BUILD_SETUP} \
  && CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build ${GO_BUILD_ARGS} -ldflags '-extldflags "-static" -s -w' -o /tmp/${BINARY_NAME}/usr/bin/${BINARY_NAME}

RUN cd /tmp/${BINARY_NAME}/usr/bin \
  && ln -s ./${BINARY_NAME} ./cliLink \
  && chmod +X /tmp/${BINARY_NAME}/usr/bin/cliLink

FROM ${FINAL_BASE}
ARG BINARY_NAME

COPY --from=builder /tmp/${BINARY_NAME} /

ENTRYPOINT ["/usr/bin/cliLink"]