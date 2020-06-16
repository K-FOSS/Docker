ARG BASE_REPO="alpine"
ARG BASE_TAG='latest'
ARG PKGS=""

ARG IMG_CMD

FROM ${BASE_REPO}:${BASE_TAG}
ARG PKGS
ARG PKG_ARGS=""

ARG IMG_CMD

ENV PKGS ${PKGS:-""}
ENV PKG_ARGS ${PKG_ARGS}

ENV CMD ${IMG_CMD:-[ "/bin/sh", "-s"]}

RUN apk add --no-cache ${PKG_ARGS} ${PKGS} \
  && echo 'user:x:1000:1000:Linux User,,,:/home/user:/bin/sh' > /etc/passwd \
  && mkdir -p /home/user \
  && chown -R 1000:1000 /home/user

ENTRYPOINT []
CMD ["/usr/bin/tail", "-f", "/dev/null"]