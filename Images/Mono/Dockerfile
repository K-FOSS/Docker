ARG FINAL_BASE='scratch'
ARG ALPINE='alpine:3.11'
ARG MONO_VERSION='5.20.1.19'

FROM ${ALPINE} as builder
ARG MONO_VERSION='5.20.1.19'
ENV MONO_VERSION=${MONO_VERSION}
RUN apk add --no-cache ack binutils build-base autoconf automake cmake libtool linux-headers paxmark python3 musl-dev

# export MONO_VERSION=$(wget -O - -q https://download.mono-project.com/sources/mono/ | ack -o '(?<=>mono-)\d{1}\.\d{1}\.\d{1}\.\d{3}' | tail -1) \

RUN mkdir -p /tmp/mono \
  && wget -O - https://download.mono-project.com/sources/mono/mono-${MONO_VERSION}.tar.bz2 | tar xj -C /tmp/mono --strip-components=1 \
  && wget -O /tmp/mono/python3.patch https://git.alpinelinux.org/aports/plain/testing/mono/python3.patch

ENV LD_FLAGS="-no-pie -static -static-libgcc"

RUN cd /tmp/mono \
  && ./configure \
  --disable-dependency-tracking \
  --enable-parallel-mark \
  --with-mcs-docs=no \
  --without-sigaltstack \
  --disable-boehm \
  --disable-crash-reporting \
  --with-gnu-ld \
  && patch -p1 -i ./python3.patch \
  && make -j$(getconf _NPROCESSORS_ONLN)

RUN cd /tmp/mono \
  && make -j$(getconf _NPROCESSORS_ONLN) DESTDIR="/tmp/mono/build" install




FROM ${ALPINE} as prepare-mono
COPY --from=builder /tmp/mono/build /tmp/mono


RUN apk add --no-cache libgcc \
  && mkdir -p /tmp/mono/lib \
  && mkdir -p /tmp/mono/usr/lib \
  && cp /usr/lib/libgcc_s.so.1 /tmp/mono/usr/lib/libgcc_s.so.1 \
  && cp /lib/ld-musl-x86_64.so.1 /tmp/mono/lib/ld-musl-x86_64.so.1

FROM scratch
COPY --from=prepare-mono /tmp/mono /

ENTRYPOINT ["/usr/local/bin/mono"]