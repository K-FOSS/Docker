ARG DOCKER_SOURCE_IMAGE=kfoss/source-docker

FROM ${DOCKER_SOURCE_IMAGE} as dockerbuild

FROM alpine:3.11 as builder
RUN echo 'user:x:1000:1000:Linux User,,,:/home/user:/bin/sh' > /tmp/passwd \
  && mkdir -p /home/user \
  && chown 1000:1000 /home/user

FROM scratch
COPY --from=builder /tmp/passwd /etc/passwd
COPY --from=dockerbuild /tmp/docker/docker /usr/local/bin/
COPY --from=builder --chown==1000:1000 /home/user /home/user

USER user
ENTRYPOINT [ "/usr/local/bin/docker" ]