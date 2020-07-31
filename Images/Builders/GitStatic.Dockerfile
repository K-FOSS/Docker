ARG FINAL_BASE='scratch'
ARG BUILD_IMAGE='alpine'
ARG BINARY_NAME='binary-out'
ARG BUILD_PKGS=''
ARG GIT_REPO
ARG GIT_BRANCH='master'


FROM ${BUILD_IMAGE} as builder

ARG PKG_ARGS=""
ARG BUILD_PKGS
RUN apk add --no-cache ${PKG_ARGS} git ca-certificates build-base ${BUILD_PKGS}


ARG BINARY_NAME
ARG BUILD_PATH="/tmp/src/${BINARY_NAME}"
RUN mkdir -p /tmp/${BINARY_NAME}/usr/bin


ARG GIT_REPO
ARG GIT_BRANCH
RUN git clone -b ${GIT_BRANCH} ${GIT_REPO} ${BUILD_PATH} --single-branch


WORKDIR ${BUILD_PATH}

ARG BUILD_SETUP='echo "No build setup command has been set"'
RUN ${BUILD_SETUP}

ARG BUILD_CONFIGURE='echo test'
RUN ${BUILD_CONFIGURE}

ENV LD_FLAGS='-static -s -w'
ENV CFLAGS='-static-libgcc -static'

ARG BUILD_CMD
RUN ${BUILD_CMD}


ARG POST_BUILD_CMD='echo "No post build command has been set"'
RUN ${POST_BUILD_CMD}


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

COPY --from=builder /tmp/${BINARY_NAME} /


ARG USER
USER ${USER}:${USER}

ENTRYPOINT ["/usr/bin/cliLink"]