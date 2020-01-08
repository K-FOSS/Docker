FROM alpine:3.11 as AlpineBase

FROM AlpineBase as SonarrFetch
RUN mkdir /sonarr && \
  cd /sonarr && \
  wget "https://services.sonarr.tv/v1/download/phantom-develop/latest?version=3&os=linux" -O sonarr.tar.gz && \
  tar xzvf sonarr.tar.gz -C /sonarr --strip-components=1 && \
  rm sonarr.tar.gz

FROM AlpineBase as DependencyFetcher
RUN apk add --no-cache libmediainfo sqlite-dev

FROM kristianfoss/programs-mono
COPY --from=SonarrFetch /sonarr /sonarr
COPY --from=DependencyFetcher /usr/lib/libgcc_s.so.1 \
  /usr/lib/libsqlite3.so.0 \
  /usr/lib/libmediainfo.so.0 \
  /usr/lib/libcurl.so.4 \
  /usr/lib/libtinyxml2.so.7 \
  /usr/lib/libnghttp2.so.14  \
  /usr/lib/libzen.so.0 \
  /usr/lib/libstdc++.so.6  \
  /usr/lib/libssl.so.1.1 \
  /usr/lib/libcrypto.so.1.1 \
  /usr/lib/

VOLUME /config
CMD [ "/sonarr/Sonarr.exe", "--no-browser", "-data=/config" ]