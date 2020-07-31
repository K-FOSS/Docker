# syntax=docker/dockerfile:experimental
ARG BUILD_IMAGE='alpine'
ARG ALPINE='alpine'
ARG BINARY_NAME='binary'
ARG FINAL_BASE='scratch'

ARG DEP1='alpine'
ARG DEP1SRC='/tmp'
ARG DEP1DEST='/tmp'

ARG DEP2='alpine'
ARG DEP2SRC='/tmp'
ARG DEP2DEST='/tmp'


ARG DEP3='alpine'
ARG DEP3SRC='/tmp'
ARG DEP3DEST='/tmp'




ARG SOURCE_IMAGE=''
FROM ${SOURCE_IMAGE} as source




FROM ${DEP1} as DEP1


FROM ${DEP2} as DEP2


FROM ${DEP3} as DEP3




FROM ${BUILD_IMAGE} as builder
ARG PKG_ARGS=""

ARG BUILD_PKGS
RUN --mount=type=cache,target=/var/cache/apk apk add ${PKG_ARGS} ca-certificates build-base binutils git ${BUILD_PKGS}


ARG SOURCE_PATH
COPY --from=source /src ${SOURCE_PATH}


ARG BINARY_NAME
RUN mkdir -p /tmp/${BINARY_NAME}/usr/bin


ARG BUILD_PATH=${SOURCE_PATH}
WORKDIR ${BUILD_PATH}

ARG SETUP_CMD='echo "No build setup command has been set"'
ENV SETUP_CMD=${SETUP_CMD}

RUN /bin/sh -c "${SETUP_CMD}"


ENV LD_FLAGS='-w -s'
ENV CFLAGS='-static-libgcc -static'


ARG BUILD_CMD='echo "no build cmd"'
ENV BUILD_CMD=${BUILD_CMD}

ENV CGO_ENABLED=0 
ENV GOOS=linux 
ENV GOARCH=amd64

RUN /bin/sh -c "${BUILD_CMD}"


ARG POST_BUILD_CMD='echo "No post build command has been set"'
ENV POST_BUILD_CMD=${POST_BUILD_CMD}

RUN /bin/sh -c "${POST_BUILD_CMD}"


ARG POST_CMD="echo 'no post cmd'"
ENV POST_CMD=${POST_CMD}

RUN /bin/sh -c "${POST_CMD}"




FROM ${ALPINE} as prepareUser 

ARG USER=user
ARG UID=1000

ENV USER ${USER}
ENV UID ${UID}

RUN mkdir -p /tmp/out/etc \
  && echo "${USER}:x:${UID}:${UID}::/nonexistent:/sbin/nologin" > /tmp/out/etc/passwd \
  && echo "${USER}:x:${UID}:" > /tmp/out/etc/group




FROM ${ALPINE} as prepareOutput
RUN --mount=type=cache,target=/var/cache/apk apk add binutils

COPY --from=builder /etc/ssl/certs/ca-certificates.crt /tmp/out/etc/ssl/certs/ca-certificates.crt


COPY --from=prepareUser /tmp/out /tmp/out

ARG DEP1SRC='/tmp'
ARG DEP1DEST='/dev/null'
COPY --from=DEP1 ${DEP1SRC} ${DEP1DEST}


ARG DEP2SRC='/tmp'
ARG DEP2DEST='/dev/null'
COPY --from=DEP2 ${DEP2SRC} ${DEP2DEST}

ARG DEP3SRC='/tmp'
ARG DEP3DEST='/dev/null'
COPY --from=DEP3 ${DEP3SRC} ${DEP3DEST}

ARG BINARY_NAME
COPY --from=builder /tmp/${BINARY_NAME} /tmp/out


RUN cd /tmp/out/usr/bin \
  && ln -s ./${BINARY_NAME} ./cliLink \
  && chmod +X /tmp/out/usr/bin/${BINARY_NAME} \
  && chmod +X /tmp/out/usr/bin/cliLink \
  && mkdir -p /tmp/out/etc \
  && strip /tmp/out/usr/bin/* \
  && ls -lah /tmp/out/usr/bin

FROM ${FINAL_BASE}
COPY --from=prepareOutput /tmp/out /

ARG USER=user
USER ${USER}:${USER}

ENTRYPOINT ["/usr/bin/cliLink"]