ARG SCRIPT_NAME="scriper"
ARG SCRIPT_RAW_URL=""
ARG alpine='alpine:3.11'

FROM ${alpine}
ARG PKGS='bash'
ARG SCRIPT_NAME
ARG SCRIPT_RAW_URL

RUN apk add --no-cache ${PKGS} \
  && wget -O /${SCRIPT_NAME} ${SCRIPT_RAW_URL}

CMD /${SCRIPT_NAME}