ARG ALPINE='alpine:3.11'

FROM ${ALPINE} as prepare
RUN apk add --no-cache ack binutils

COPY ./passwd ./shadow /tmp/dockerd/etc/

RUN export DOCKER_VERSION=$(wget -O - -q https://download.docker.com/linux/static/stable/x86_64/ | ack -o '(?<=>docker-)\d{2}\.\d{2}\.\d{1}' | tail -1) \
  && mkdir -p /tmp/docker \
  && echo "Getting Docker $DOCKER_VERSION" \
  && wget -O - https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz | tar xz -C /tmp/docker --strip-components=1


RUN strip /tmp/docker/* \
  && mkdir -p /tmp/dockerd/usr/bin \
  && cp /tmp/docker/dockerd /tmp/docker/docker-init /tmp/docker/containerd /tmp/docker/containerd-shim /tmp/docker/ctr /tmp/docker/runc /tmp/dockerd/usr/bin/




FROM ${ALPINE} as dockerd

RUN apk add --no-cache iptables

COPY --from=prepare /tmp/dockerd /

RUN addgroup docker

ENTRYPOINT [ "/usr/bin/dockerd" ]




FROM ${ALPINE} as docker
RUN mkdir -p /root/.docker/cli-plugins \
  && wget -O /root/.docker/cli-plugins/docker-buildx https://github.com/docker/buildx/releases/download/v0.3.1/buildx-v0.3.1.linux-amd64  \
  && chmod +x /root/.docker/cli-plugins/docker-buildx

COPY ./config.json /root/.docker/config.json

COPY --from=prepare /tmp/docker/docker /usr/bin/

ENTRYPOINT [ "/usr/bin/docker" ]