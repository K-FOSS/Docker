FROM golang:1.13.5-alpine as builder
RUN apk add --no-cache git python2 build-base py-pip python2-dev libffi-dev linux-headers openssl-dev

RUN go get -u github.com/pritunl/pritunl-dns \
  && go get -u github.com/pritunl/pritunl-web

RUN mkdir -p /tmp/pritunl \
  && wget -O - https://codeload.github.com/pritunl/pritunl/tar.gz/master | tar xz -C /tmp/pritunl --strip-components=1

RUN mkdir /tmp/install \
  && cd /tmp/pritunl \
  && python2 setup.py build --no-systemd \
  && pip install -r requirements.txt \
  && python2 setup.py install --root /tmp/install --no-systemd


RUN ls -lah /tmp/install/usr/lib/python2.7/site-packages/pritunl/server

FROM alpine:3.11 as pritunl-web
COPY --from=builder /usr/lib/python2.7/site-packages /usr/lib/python2.7/site-packages

RUN apk add --no-cache python2
COPY --from=builder /tmp/install /

RUN /usr/bin/pritunl set app.reverse_proxy true

RUN ls -lah /usr/lib
ENV REVERSE_PROXY=true


ENTRYPOINT [ "/usr/bin/pritunl", "start" ]
