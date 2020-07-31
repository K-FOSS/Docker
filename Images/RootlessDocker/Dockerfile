ARG FINAL_BASE='kristianfoss/programs-rootlesskit:rootless-scratch'
ARG ALPINE='alpine'
ARG CLI_NAME='docker'




FROM ${ALPINE} as fetcher
RUN apk add --no-cache ack binutils

RUN export DOCKER_VERSION=$(wget -O - -q https://download.docker.com/linux/static/stable/x86_64/ | ack -o '(?<=>docker-)\d{2}\.\d{2}\.\d{1}' | tail -1) \
  && mkdir -p /tmp/docker \
  && echo "Getting Docker $DOCKER_VERSION" \
  && wget -O - https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz | tar xz -C /tmp/docker --strip-components=1 \
  && wget -O - https://download.docker.com/linux/static/stable/x86_64/docker-rootless-extras-${DOCKER_VERSION}.tgz | tar xz -C /tmp/docker --strip-components=1


FROM ${ALPINE} as iptablesBuild
RUN apk add --no-cache ack binutils

ENV LD_FLAGS='-static -s -w'
ENV CFLAGS='-static-libgcc'

RUN export IPTABLES_VERSION=$(wget -O - -q https://www.netfilter.org/projects/iptables/files/ | ack -o '(?<=>iptables-)\d{1}\.\d{1}\.\d{1}' | tail -1) \
  && mkdir -p /tmp/src/iptables \
  && wget -O - https://www.netfilter.org/projects/iptables/files/iptables-${IPTABLES_VERSION}.tar.bz2 | tar xj -C /tmp/src/iptables --strip-components=1

RUN apk add --no-cache build-base linux-headers 

ENV LD_FLAGS='-static -s -w'
ENV CFLAGS='-static-libgcc'

RUN cd /tmp/src/iptables \
  && ./configure \
  --prefix=/usr \
  --enable-static \
  --disable-shared \
  --disable-dependency-tracking \
  --disable-nftables \
  && make \
  && make -j1 install DESTDIR="/tmp/src/out"




FROM ${ALPINE} as prepareUser
RUN mkdir -p /tmp/user/etc \
  && echo 'user:x:1000:1000:Linux User,,,:/home/user:/usr/sbin/nologin' > /tmp/user/etc/passwd \
  && mkdir -p /tmp/user/home/user/.ssh \
  && mkdir -p /tmp/user/home/user/.local/share/docker \
  && mkdir -p /tmp/user/home/user/.docker \
  && echo '{ "experimental": "enabled" }' >> /tmp/user/home/user/.docker/config.json \
  && chown -R 1000:1000 /tmp/user/home/user 




FROM ${ALPINE} as prepareCLI
ARG CLI_NAME
ENV CLI_NAME=${CLI_NAME}

RUN apk --no-cache add ca-certificates binutils

COPY --from=prepareUser /tmp/user /tmp/cli

COPY --from=fetcher /tmp/docker/dockerd /tmp/docker/containerd /tmp/docker/runc /tmp/docker/docker-proxy /tmp/docker/containerd-shim /tmp/docker/vpnkit  /tmp/cli/usr/bin/
COPY --from=iptablesBuild /tmp/src/out/usr/sbin/iptables /tmp/cli/usr/bin/
COPY --from=kristianfoss/source-iproute2:scratch /usr/bin/ip /tmp/cli/usr/bin/ip
COPY --from=kristianfoss/programs-rootlesskit:rootless-scratch /usr/bin/newuidmap /usr/bin/newgidmap /usr/bin/

RUN cd /tmp/cli/usr/bin \
  && ln -s ./${CLI_NAME} ./cliLink \
  && chmod +X /tmp/cli/usr/bin/cliLink \
  && mkdir -p /tmp/cli/run/user \
  && chmod 1777 /tmp/cli/run/user \
  && mkdir -p /tmp/cli/run/docker \
  && chmod 1777 /tmp/cli/run/docker \
  && strip /tmp/cli/usr/bin/*

RUN mkdir -p /tmp/cli/tmp \
  && chmod 777 /tmp/cli/tmp


FROM ${FINAL_BASE} as cli

COPY ./config.json /root/.docker/config.json

COPY --from=prepareCLI /tmp/cli /

ENV XDG_RUNTIME_DIR='/run/user/1000'

USER user
ENTRYPOINT ["/usr/bin/rootlesskit", "--net=vpnkit", "--disable-host-loopback", "--port-driver=builtin", "--copy-up=/etc", "--copy-up=/run", "dockerd", "--experimental", "--rootless"]