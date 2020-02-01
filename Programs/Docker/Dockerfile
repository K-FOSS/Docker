FROM alpine:3.11 as AlpineBase

FROM AlpineBase as Fetcher
RUN apk add --no-cache ack \
  && echo "$(wget -O - -q https://download.docker.com/linux/static/stable/x86_64/ \
  | ack -o '(?<=>docker-)\d{2}\.\d{2}\.\d{1}' \
  | tail -1)" >> /.DOCKER_VERSION

# wget -O - -q https://download.docker.com/linux/static/stable/x86_64/ \
# | ack -o '(?<=>docker-)\d{2}\.\d{2}\.\d{1}' \
#  | tail -1

RUN export DOCKER_VERSION=$(cat .DOCKER_VERSION) \
  && mkdir -p /tmp/docker \
  && echo "Getting Docker $DOCKER_VERSION" \
  && wget -O - https://download.docker.com/linux/static/stable/x86_64/docker-$DOCKER_VERSION.tgz \
  | tar xz -C /tmp/docker --strip-components=1

RUN echo 'user:x:1000:1000:Linux User,,,:/home/user:/bin/sh' > /tmp/passwd \
  && mkdir -p /home/user \
  && chown 1000:1000 /home/user

FROM alpine:3.11
COPY --from=Fetcher /tmp/passwd /etc/passwd
COPY --from=Fetcher /tmp/docker/docker /usr/local/bin/

USER user
ENTRYPOINT [ "/usr/local/bin/docker" ]