ARG BASE_REPO="alpine"
ARG BASE_TAG="3.11"
ARG PKGS=""

ARG IMG_CMD

FROM ${BASE_REPO}:${BASE_TAG} as builder
ARG PKGS
ARG PKG_ARGS=""

ARG SOURCE_FILES
ARG DEST_FILES

RUN apk add --no-cache ${PKG_ARGS} ${PKGS}

ENV SOURCE_FILES=${SOURCE_FILES}
ENV DEST_FILES=${DEST_FILES}

COPY ./build.sh /build.sh

RUN /build.sh

FROM ${BASE_REPO}:${BASE_TAG}
ARG CMD
ENV CMD ${CMD:-[ "/usr/bin/tail", "-f", "/dev/null"]}

COPY --from=builder /tmp/paths /

ENTRYPOINT [  ]
CMD ${CMD}