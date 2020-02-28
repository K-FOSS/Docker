ARG FINAL_BASE='scratch'
ARG ALPINE='alpine:3.11'
ARG CLI_NAME='ssh'

FROM ${ALPINE} as build-base
RUN apk add --no-cache \
  build-base \
  linux-headers \
  autoconf \
  automake \
  zlib-static \
  zlib-dev \
  openssl-dev \
  openssl-libs-static


FROM build-base as busyboxBuild
RUN apk add --no-cache \
  musl-dev \
  perl \
  ncurses \
  ncurses-dev \
  binutils-gold \
  gnupg \
  python \
  libstdc++ 

RUN mkdir -p /tmp/busybox \
  && wget -O - https://codeload.github.com/mirror/busybox/tar.gz/master | tar xz -C /tmp/busybox --strip-components=1

COPY ./.config /tmp/busybox/.config

RUN cd /tmp/busybox \
  && make || true \
  && ./make_single_applets.sh || true




FROM build-base as pamBuild
RUN apk add --no-cache bison flex-dev libtool

RUN mkdir -p /tmp/linux-pam \
  && wget -O - https://github.com/linux-pam/linux-pam/releases/download/v1.3.1/Linux-PAM-1.3.1.tar.xz \
  |  tar x -J -C /tmp/linux-pam --strip-components=1

RUN cd /tmp/linux-pam \
  && ./configure --enable-static --disable-pie \
  && make -j$(getconf _NPROCESSORS_ONLN) || true




FROM build-base as builder
COPY --from=pamBuild /tmp/linux-pam/libpam/.libs/libpam.a /tmp/linux-pam/libpam/.libs/libpam.so /usr/lib/

RUN apk add --no-cache linux-pam-dev libselinux-dev pcre-dev

RUN mkdir -p /tmp/openssh \
  && wget -O - https://openbsd.cs.toronto.edu/pub/OpenBSD/OpenSSH/portable/openssh-8.2p1.tar.gz | tar xz -C /tmp/openssh --strip-components=1

RUN cd /tmp/openssh \
  && ./configure \
  --with-zlib=/lib/zlib.a \
  --with-ldflags=-static \
  --without-stackprotect \
  --with-pam \
  --without-hardening \
  --without-selinux \
  --with-privsep-path=/var/lib/sshd/ \
  --sysconfdir=/etc/ssh \
  --with-shadow \
  --disable-lastlog \
  --disable-utmp \
  --disable-utmpx \
  --disable-wtmp \
  --disable-wtmpx \
  --without-ldap \
  --without-audit \
  --without-kerberos5 \
  --without-libedit \
  && make -j$(getconf _NPROCESSORS_ONLN)




FROM ${ALPINE} as prepareUser
RUN mkdir -p /tmp/user/etc \
  && echo 'user:x:1000:1000:Linux User,,,:/home/user:/usr/sbin/nologin' > /tmp/user/etc/passwd \
  && mkdir -p /tmp/user/home/user/.ssh \
  && chown -R 1000:1000 /tmp/user/home/user




FROM ${ALPINE} as prepareCLI
ARG CLI_NAME

RUN apk add --no-cache binutils

COPY --from=prepareUser /tmp/user /tmp/cli
COPY --from=builder /tmp/openssh/${CLI_NAME} /tmp/cli/usr/bin/

RUN strip /tmp/cli/usr/bin/${CLI_NAME} \
  && cd /tmp/cli/usr/bin/ \
  && ln -s ./${CLI_NAME} ./cliLink \
  && chmod +X /tmp/cli/usr/bin/cliLink 


FROM ${FINAL_BASE} as cli
COPY --from=prepareCLI /tmp/cli /

USER user
ENTRYPOINT ["/usr/bin/cliLink"]




FROM ${ALPINE} as bash-builder
RUN apk add --no-cache build-base bash

ENV SHELL=/bin/bash

RUN mkdir -p /tmp/bash \
  && wget -O - http://ftp.gnu.org/gnu/bash/bash-5.0.tar.gz | tar xz -C /tmp

COPY patch.sh /tmp/

ENV LDFLAGS="-static"

RUN cd /tmp/ \
  && ls \
  && ./patch.sh \
  && cd ./bash-5.0 \
  && CFLAGS="$CFLAGS -Os" ./configure --without-bash-malloc \
  && make




FROM ${ALPINE} as prepareSSHD
COPY --from=bash-builder /tmp/ /tmp/
COPY --from=builder /tmp/openssh/sshd /tmp/sshd/usr/bin/
COPY --from=kristianfoss/programs-socat /usr/bin/socat /tmp/sshd/usr/bin/
COPY --from=busyboxBuild /tmp/busybox/busybox_GETTY /tmp/sshd/sbin/getty
COPY --from=busyboxBuild /tmp/busybox/busybox_HUSH /tmp/sshd/bin/sh
COPY --from=bash-builder /tmp/bash-5.0/bash /tmp/sshd/bin/bash
COPY --from=busyboxBuild /tmp/busybox/busybox_PS /tmp/sshd/usr/bin/ps
COPY --from=busyboxBuild /tmp/busybox/busybox_RESIZE /tmp/sshd/usr/bin/resize
COPY --from=busyboxBuild /tmp/busybox/busybox_STTY /tmp/sshd/bin/stty
COPY --from=busyboxBuild /tmp/busybox/busybox_TTY /tmp/sshd/usr/bin/tty
COPY --from=busyboxBuild /tmp/busybox/busybox_TTYSIZE /tmp/sshd/usr/bin/ttysize

RUN mkdir -p /tmp/sshd/var/lib/sshd \
  && mkdir -p /tmp/sshd/var/run/ \
  && mkdir -p /tmp/sshd/etc/ \
  && chmod -R 700 /tmp/sshd/var/lib/sshd/ \
  && chown -R root:sys /tmp/sshd/var/lib/sshd/ 

RUN echo 'sshd:x:1001:1001:sshd privsep,,,:/:/bin/false' >> /etc/passwd \
  && cp /etc/passwd /tmp/sshd/etc/passwd \
  && mkdir -p /tmp/sshd/root


FROM scratch as sshd
COPY --from=prepareSSHD /tmp/sshd /
COPY ./zsh /usr/bin/zsh

EXPOSE 25
ENTRYPOINT [ "/usr/bin/sshd", "-D", "-e", "-f", "/etc/ssh/sshd_config" ]