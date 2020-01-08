FROM alpine:3.11 as AlpineBase

FROM AlpineBase as Builder
RUN apk add --no-cache gcc g++ make zlib-dev openssl-dev openssl-libs-static zlib-static
RUN mkdir -p /tmp/openssh \
  && wget -O - https://openbsd.cs.toronto.edu/pub/OpenBSD/OpenSSH/portable/openssh-8.1p1.tar.gz | tar xz -C /tmp/openssh --strip-components=1


RUN  cd /tmp/openssh \
  && ./configure \
    --with-zlib=/lib/zlib.a \
    --with-ldflags=-static \
    --disable-lastlog \
    --disable-utmp \
    --disable-utmpx \
    --disable-wtmp \
    --disable-wtmpx \
    --without-shadow \
    --without-stackprotect \
    --without-hardening \
    --without-rpath \
    --without-ldap \
    --without-pam \
    --without-selinux \
    --without-audit \
    --without-kerberos5 \
    --without-libedit \ 
    --prefix="/" \
    --with-privsep-user=nobody \
    --with-privsep-path="/opt/openssh" \
  && make \
  && strip /tmp/openssh/ssh
RUN echo 'sshuser:x:1000:1000:Linux User,,,:/home/sshuser:/bin/sh' > /tmp/passwd \
  && mkdir -p /home/sshuser \
  && chown 1000:1000 /home/sshuser

FROM scratch as SSH
COPY --from=Builder /tmp/passwd /etc/passwd 
COPY --from=Builder /tmp/openssh/ssh /ssh

USER sshuser
COPY --from=Builder --chown=1000:1000 /home/sshuser /home/sshuser
ENTRYPOINT [ "/ssh" ]