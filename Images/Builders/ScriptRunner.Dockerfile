ARG SCRIPT_NAME="scriper"
ARG SCRIPT_RAW_URL=""
ARG alpine='alpine'

FROM ${alpine}
ARG PKGS='bash'
ARG SCRIPT_NAME
ARG SCRIPT_RAW_URL

RUN apk add --no-cache ${PKGS} \
  && wget -O /script ${SCRIPT_RAW_URL} \
  && chmod +x /script

CMD /script