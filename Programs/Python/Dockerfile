FROM alpine:3.11 as builder
ARG PYHTON3_VERSION="3.8.1"
ENV PYHTON3_VERSION=${PYHTON3_VERSION}

RUN apk add --no-cache build-base

RUN mkdir -p /tmp/python3 \
  && wget -O - https://www.python.org/ftp/python/${PYHTON3_VERSION}/Python-${PYHTON3_VERSION}.tar.xz \
  |  tar x -J -C /tmp/python3 --strip-components=1

COPY ./musl-find_library.patch /tmp/python3/musl-find_library.patch

RUN cd /tmp/python3 \
  && patch musl-find_library.patch  ./Lib/ctypes/util.py \
  && ./configure \
    LDFLAGS="-static" \
    --prefix=/usr \
    --disable-rpath \
    --enable-ipv6 \
    --enable-shared \
    --enable-optimizations \
    --with-computed-gotos \
    --with-system-expat \
    --with-system-ffi \
    --with-threads \
    --disable-profiling \
    --with-lto \
    --without-dtrace \
  && make -j$(getconf _NPROCESSORS_ONLN) LDFLAGS="-static" LINKFORSHARED=" "

RUN mkdir /tmp/nuitka \
  && wget -O - http://nuitka.net/releases/Nuitka-0.6.7rc2.tar.gz | tar xz -C /tmp/nuitka --strip-components=1

# RUN echo 'python:x:1000:1000:Linux User,,,:/home/python:/bin/sh' > /tmp/passwd

FROM scratch
COPY --from=builder /tmp/passwd /etc/passwd
COPY --from=builder /tmp/python3/python /usr/bin/python

USER python
ENTRYPOINT [ "/usr/bin/python" ]