FROM alpine:3.11 as builder

RUN echo "$(wget -O - -q http://www.dest-unreach.org/socat/download/ | grep -o -E 'socat-(1\.\d\.\d\.\d)' | tail -1)" > /.socat-version

RUN apk add --no-cache \
  automake \
  build-base \
  linux-headers \
  pkgconfig

RUN export SOCAT_VERSION=$(cat /.socat-version) \
  && mkdir /tmp/socat \
  && wget -O - http://www.dest-unreach.org/socat/download/${SOCAT_VERSION}.tar.gz \
  | tar xz -C /tmp/socat --strip-components=1

RUN cd /tmp/socat \
  && LIBS="-static" ./configure \
  && make

FROM scratch
COPY --from=builder /tmp/socat/socat /usr/bin/socat
ENTRYPOINT [ "/usr/bin/socat" ]
CMD [ "-h" ]