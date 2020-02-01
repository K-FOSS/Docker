FROM alpine:3.11 as busyboxBuild

RUN apk add --no-cache gcc \
    build-base \
    musl-dev \
    zlib-dev \
    openssl-dev \
    openssl-libs-static \
    zlib-static \
    perl \
    ncurses \
    ncurses-dev \
    binutils-gold \
    g++ \
    gcc \
    gnupg \
    libgcc \
    linux-headers \
    make \
    python \
    libstdc++

RUN mkdir -p /tmp/busybox \
  && wget -O - https://codeload.github.com/mirror/busybox/tar.gz/master | tar xz -C /tmp/busybox --strip-components=1

COPY ./.config /tmp/busybox/.config

RUN cd /tmp/busybox \
  && make || true \
  && ./make_single_applets.sh || true




FROM alpine:3.11 as builder
RUN apk add --no-cache \
  build-base \
  automake \
  autoconf \
  expat-static \
  zlib-dev \
  zlib-static \
  openssl-dev \
  openssl-libs-static \
  curl-dev \
  curl-static \
  nghttp2-static \
  expat-dev \
  perl-dev \
  python3-dev \
  pcre2-dev \
  asciidoc \
  xmlto \
  perl-error \
  tk \
  tcl

RUN mkdir -p /tmp/git \
  && wget -O - https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.25.0.tar.gz | tar xz -C /tmp/git --strip-components=1

COPY config.mak /tmp/git/config.mak

RUN cd /tmp/git \
  && make prefix=/usr DESTDIR="/tmp/git" -j$(getconf _NPROCESSORS_ONLN)  \
  && make install prefix=/usr DESTDIR="/tmp/git" -j$(getconf _NPROCESSORS_ONLN)

RUN ls -lah /tmp/git/usr/share/git-core/templates/hooks

FROM alpine:3.11 as prepareGit
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /tmp/git/etc/ssl/certs/ca-certificates.crt
COPY --from=builder /tmp/git/usr/bin/git /tmp/git/git-remote-https /tmp/git/usr/bin/
COPY --from=builder /tmp/git/usr/share/git-core/ /tmp/git/usr/share/git-core
COPY --from=busyboxBuild /tmp/busybox/busybox_TAIL /tmp/git/usr/bin/tail

FROM scratch as git
COPY --from=prepareGit /tmp/git /

ENTRYPOINT ["/usr/bin/git"]