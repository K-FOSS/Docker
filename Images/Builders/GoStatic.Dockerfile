ARG FINAL_BASE='scratch'
ARG GO_VERSION='1.13.6-alpine'
ARG BINARY_NAME='binary-out'
ARG BUILD_PKGS=''
ARG GIT_REPO
ARG GIT_BRANCH='master'

FROM golang:${GO_VERSION} as builder

ARG PKG_ARGS=""
ARG BUILD_PKGS
RUN apk add --no-cache ${PKG_ARGS} git ca-certificates build-base ${BUILD_PKGS}


ARG BINARY_NAME
RUN mkdir -p /go/src/${BINARY_NAME} \
  && mkdir -p /tmp/${BINARY_NAME}/usr/bin


ARG GIT_REPO
ARG GIT_BRANCH
RUN git clone -b ${GIT_BRANCH} ${GIT_REPO} /go/src/${BINARY_NAME} --single-branch


WORKDIR /go/src/${BINARY_NAME}

ARG BUILD_SETUP
ARG GO_BUILD_ARGS
RUN ${BUILD_SETUP} \
  && CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build ${GO_BUILD_ARGS} -ldflags '-extldflags "-static" -s -w' -o /tmp/${BINARY_NAME}/usr/bin/${BINARY_NAME}


ARG POST_BUILD_CMD='echo "No post build command has been set"'
RUN ${POST_BUILD_CMD}


WORKDIR /tmp/${BINARY_NAME}/usr/bin
RUN ln -s ./${BINARY_NAME} ./cliLink \
  && chmod +X ./cliLink


FROM alpine
RUN apk add --no-cache libcap

COPY --from=builder /tmp/mtr /tmp/mtr

RUN getcap /tmp/mtr/usr/bin/mtr



FROM ${FINAL_BASE}
ARG BINARY_NAME

COPY --from=builder /tmp/${BINARY_NAME} /


ENTRYPOINT ["/usr/bin/cliLink"]