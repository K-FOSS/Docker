FROM alpine:3.11 as AlpineBase

FROM AlpineBase as Builder
RUN apk add --no-cache gcc g++ make zlib-dev openssl-dev
RUN mkdir -p /tmp/openssh \
  && wget -O - https://openbsd.cs.toronto.edu/pub/OpenBSD/OpenSSH/portable/openssh-8.1p1.tar.gz | tar xz -C /tmp/openssh --strip-components=1

RUN  cd /tmp/openssh \
  && ./configure \
  && make

RUN echo 'user:x:1000:1000:Linux User,,,:/home/user:/bin/sh' > /tmp/passwd

FROM scratch as SSH
COPY --from=Builder /tmp/passwd /etc/passwd
COPY --from=Builder /lib/ld-musl-x86_64.so.1 /lib/libz.so.1 /lib/libcrypto.so.1.1  /lib/
COPY --from=Builder /tmp/openssh/ssh /ssh

USER user
ENTRYPOINT [ "/ssh" ]