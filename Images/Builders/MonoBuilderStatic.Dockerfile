ARG FINAL_BASE='scratch'
ARG ALPINE='alpine'
ARG CLI_NAME='sonarr'
ARG MONO_IMAGE='kristianfoss/programs-mono:scratch'

FROM ${ALPINE} as fetch-src
ARG MEDIA_SRC

RUN export SONARR_VERSION=$(wget -O - -q https://download.docker.com/linux/static/stable/x86_64/ | ack -o '(?<=>docker-)\d{2}\.\d{2}\.\d{1}' | tail -1) \

RUN mkdir -p /tmp/media \
  && wget -O - ${MEDIA_SRC} | tar xz -C /tmp/media --strip-components=1




FROM ${ALPINE} as prepareUser
RUN mkdir -p /tmp/user/etc \
  && echo 'user:x:1000:1000:Linux User,,,:/home/user:/usr/sbin/nologin' > /tmp/user/etc/passwd \
  && chown -R 1000:1000 /tmp/user/home/user



FROM ${ALPINE} as prepareCLI
ARG CLI_NAME
ENV CLI_NAME=${CLI_NAME}

COPY --from=fetch-src /tmp/media /tmp/media
COPY --from=prepareUser /tmp/user /tmp/media





FROM ${FINAL_BASE} as media
COPY ./config.json /root/.docker/config.json

COPY --from=prepareCLI /tmp/cli /

USER user
ENTRYPOINT ["/usr/bin/cliLink"]