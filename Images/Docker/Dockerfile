ARG FINAL_BASE='scratch'
ARG ALPINE='alpine:3.11'
ARG CLI_NAME='docker'

FROM ${ALPINE} as fetcher
RUN apk add --no-cache ack binutils

RUN export DOCKER_VERSION=$(wget -O - -q https://download.docker.com/linux/static/stable/x86_64/ | ack -o '(?<=>docker-)\d{2}\.\d{2}\.\d{1}' | tail -1) \
  && mkdir -p /tmp/docker \
  && echo "Getting Docker $DOCKER_VERSION" \
  && wget -O - https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz | tar xz -C /tmp/docker --strip-components=1 \
  && strip /tmp/docker/*




FROM ${ALPINE} as prepareUser
RUN mkdir -p /tmp/user/etc \
  && echo 'user:x:1000:1000:Linux User,,,:/home/user:/usr/sbin/nologin' > /tmp/user/etc/passwd \
  && mkdir -p /tmp/user/home/user/.ssh \
  && chown -R 1000:1000 /tmp/user/home/user




FROM ${ALPINE} as prepareCLI
ARG CLI_NAME
ENV CLI_NAME=${CLI_NAME}

COPY --from=prepareUser /tmp/user /tmp/cli
COPY --from=fetcher /tmp/docker/${CLI_NAME} /tmp/cli/usr/bin/

RUN cd /tmp/cli/usr/bin \
  && ln -s ./${CLI_NAME} ./cliLink \
  && chmod +X /tmp/cli/usr/bin/cliLink


FROM ${FINAL_BASE} as cli
COPY --from=prepareCLI /tmp/cli /

USER user
ENTRYPOINT ["/usr/bin/cliLink"]
