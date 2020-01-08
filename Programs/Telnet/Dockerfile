FROM alpine:3.11 as AlpineBase

FROM AlpineBase as Builder
RUN apk add --no-cache gcc \
    make \
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
RUN mkdir -p /tmp/telnet \
  && wget -O - https://codeload.github.com/mirror/busybox/tar.gz/master | tar xz -C /tmp/telnet --strip-components=1

ADD .config /tmp/telnet/.config

RUN cd /tmp/telnet \
  && make \
  && ./make_single_applets.sh

FROM scratch
COPY --from=Builder /tmp/telnet/busybox_TELNET /telnet
ENTRYPOINT ["/telnet"]