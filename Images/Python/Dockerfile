ARG FINAL_BASE='scratch'
ARG ALPINE='alpine'

FROM ${ALPINE} as buildPython
RUN apk add --no-cache ack binutils

RUN export PYTHON_VERSION=$(wget -O - -q https://www.python.org/ftp/python/ | ack -o '\d{1}\.\d{1}\.\d{1,2}' | tail -1) \
  && mkdir -p /tmp/python \
  && echo "Getting Python $PYTHON_VERSION" \
  && wget -O - https://www.python.org/ftp/python/${PYHTON_VERSION}/Python-${PYHTON_VERSION}.tar.xz | tar xzJ -C /tmp/python --strip-components=1 \
  && wget -O /tmp/python/musl-find_library.patch https://git.alpinelinux.org/aports/plain/main/python3/musl-find_library.patch


ENV LDFLAGS='-static'
RUN cd /tmp/python \
  && patch -p1 -i ./musl-find_library.patch \
  && ./configure \
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
  && make LDFLAGS="${LDFLAGS}" LINKFORSHARED=" "