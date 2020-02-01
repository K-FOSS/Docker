FROM alpine:3.11 as Fetcher
RUN apk add --no-cache git

FROM scratch
COPY --from=Fetcher /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=Fetcher /usr/libexec/git-core /usr/libexec/git-core
COPY --from=Fetcher /usr/share/git-core/templates /usr/share/git-core/templates
COPY --from=Fetcher /usr/libexec/git-core/git /git
COPY --from=Fetcher /lib/ld-musl-x86_64.so.1 /lib/libz.so.1 /lib/libssl.so.1.1 /lib/libcrypto.so.1.1  /lib/
COPY --from=Fetcher /usr/lib/libcurl.so.4 /usr/lib/libnghttp2.so.14 /usr/lib/libpcre2-8.so.0 /usr/lib/
ENTRYPOINT [ "/git" ]