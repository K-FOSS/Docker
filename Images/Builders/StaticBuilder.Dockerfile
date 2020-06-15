ARG FINAL_BASE='scratch'
ARG BUILD_IMAGE='alpine:3.12'
ARG BINARY_NAME='binary-out'
ARG BUILD_PKGS=''


FROM ${BUILD_IMAGE} as builder

ARG PKG_ARGS=""
ARG BUILD_PKGS
RUN apk add --no-cache ${PKG_ARGS} git ca-certificates build-base ${BUILD_PKGS}


ARG BINARY_NAME
RUN mkdir -p /tmp/${BINARY_NAME}/usr/bin


ARG FETCH_CMD='echo "no fetch cmd"'
ENV FETCH_CMD=${FETCH_CMD}

RUN /bin/sh -c "${FETCH_CMD}"

ARG BUILD_PATH="/tmp/src/${BINARY_NAME}"
WORKDIR ${BUILD_PATH}

ARG SETUP_CMD='echo "No build setup command has been set"'
ENV SETUP_CMD=${SETUP_CMD}

RUN /bin/sh -c "${SETUP_CMD}"


ARG CONFIGURE_CMD='echo "no configure cmd"'
ARG CONFIGURE_CMD=${CONFIGURE_CMD}

RUN /bin/sh -c "${BUILD_CONFIGURE}"


ENV LD_FLAGS='-static -s -w'
ENV CFLAGS='-static-libgcc'


ARG BUILD_CMD='echo "no build cmd"'
ENV BUILD_CMD=${BUILD_CMD}

RUN /bin/sh -c "${BUILD_CMD}"


ARG POST_BUILD_CMD='echo "No post build command has been set"'
ENV POST_BUILD_CMD=${POST_BUILD_CMD}

RUN /bin/sh -c "${POST_BUILD_CMD}"


WORKDIR /tmp/${BINARY_NAME}/usr/bin
RUN ln -s ./${BINARY_NAME} ./cliLink \
  && chmod +X /tmp/${BINARY_NAME}/usr/bin/${BINARY_NAME} \
  && chmod +X /tmp/${BINARY_NAME}/usr/bin/cliLink \
  && mkdir -p /tmp/${BINARY_NAME}/etc


ARG POST_CMD="echo 'no post cmd'"
ENV POST_CMD=${POST_CMD}
RUN /bin/sh -c "${POST_CMD}"




FROM ${FINAL_BASE}
ARG BINARY_NAME
ARG USER

COPY --from=builder /tmp/${BINARY_NAME} /

USER ${USER}
ENTRYPOINT ["/usr/bin/cliLink"]