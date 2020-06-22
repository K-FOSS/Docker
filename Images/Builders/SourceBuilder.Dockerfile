ARG BUILD_IMAGE='alpine'
ARG FINAL_BASE='scratch'




FROM ${BUILD_IMAGE} as builder

ARG PKG_ARGS=""
ARG BUILD_PKGS
RUN apk add --no-cache ${PKG_ARGS} git ca-certificates ${BUILD_PKGS}

ARG FETCH_CWD="/"
WORKDIR ${FETCH_CWD}

ARG FETCH_CMD='echo "no fetch cmd"'
ENV FETCH_CMD=${FETCH_CMD}

RUN /bin/sh -c "${FETCH_CMD}"




FROM ${FINAL_BASE}

ARG SOURCE_PATH="/src"
COPY --from=builder ${SOURCE_PATH} /src