FROM alpine:3.11 as AlpineBase

FROM AlpineBase as DependencyFetcher
RUN apk add --no-cache mono --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
  && apk add --no-cache --virtual=.build-dependencies ca-certificates \
  && cert-sync /etc/ssl/certs/ca-certificates.crt \
  && apk del .build-dependencies \
  && echo 'mono:x:1000:1000:Linux User,,,:/home/mono:/bin/sh' > /tmp/passwd

FROM scratch
COPY --from=DependencyFetcher /lib/ld-musl-x86_64.so.1 /lib/libz.so.1 /lib/
COPY --from=DependencyFetcher /usr/lib/libMonoPosixHelper.so \
  /usr/lib/libmono-btls-shared.so \
  /usr/lib/libgcc_s.so.1 \
  /usr/lib/
COPY --from=DependencyFetcher /usr/share/.mono /usr/share/.mono
COPY --from=DependencyFetcher /usr/lib/mono/4.5 /usr/lib/mono/4.5
COPY --from=DependencyFetcher /etc/mono /etc/mono
COPY --from=DependencyFetcher /usr/lib/mono/gac /usr/lib/mono/gac
COPY --from=DependencyFetcher /usr/bin/mono /usr/bin/mono
COPY --from=DependencyFetcher /tmp/passwd /etc/passwd

USER mono
ENTRYPOINT [ "/usr/bin/mono" ]