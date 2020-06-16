ARG FINAL_BASE='scratch'
ARG ALPINE='alpine:3.12'
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

RUN apk --no-cache add ca-certificates

COPY --from=prepareUser /tmp/user /tmp/cli
COPY --from=fetcher /tmp/docker/${CLI_NAME} /tmp/cli/usr/bin/

RUN cd /tmp/cli/usr/bin \
  && ln -s ./${CLI_NAME} ./cliLink \
  && chmod +X /tmp/cli/usr/bin/cliLink

RUN mkdir -p /tmp/cli/root/.docker/cli-plugins \
  && wget -O /tmp/cli/root/.docker/cli-plugins/docker-buildx https://github.com/docker/buildx/releases/download/v0.3.1/buildx-v0.3.1.linux-amd64  \
  && chmod +x /tmp/cli/root/.docker/cli-plugins/docker-buildx \
  && mkdir -p /tmp/cli/root/.docker/buildx \
  && chown -R 1000:1000 /tmp/cli/root/.docker/buildx




FROM ${FINAL_BASE} as cli
COPY ./config.json /root/.docker/config.json

COPY --from=prepareCLI /tmp/cli /

USER user
ENTRYPOINT ["/usr/bin/cliLink"]
