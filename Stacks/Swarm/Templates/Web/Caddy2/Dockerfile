FROM golang:1.13.5-alpine as builder
ARG CADDY_SOURCE_VERSION=v2

WORKDIR /src
RUN apk add --no-cache \
  git \
  ca-certificates

RUN git clone -b $CADDY_SOURCE_VERSION https://github.com/caddyserver/caddy.git --depth 1

WORKDIR /src/caddy/cmd/caddy
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
  go build -trimpath -tags netgo -ldflags '-extldflags "-static" -s -w' -o /usr/bin/caddy




FROM alpine:3.11.5 AS usermaker
RUN addgroup -S caddy \
  && adduser -SD -h /var/lib/caddy/ -g 'Caddy web server' -s /sbin/nologin -G caddy caddy

USER caddy
RUN mkdir -p /var/lib/caddy/.local/share/caddy




FROM scratch AS scratch

COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs
COPY --from=builder /usr/bin/caddy /usr/bin/caddy

COPY --from=usermaker /etc/passwd /etc/passwd
COPY --from=usermaker /etc/group /etc/group
COPY --from=usermaker --chown=caddy:caddy /var/lib/caddy /var/lib/caddy

USER caddy

VOLUME /var/lib/caddy/.local/share/caddy

ENTRYPOINT ["caddy"]
CMD ["run", "--config", "/etc/Caddy/Caddyfile.json"]