
ARG ALPINE='alpine'
ARG FINAL_BASE='alpine'
ARG PREPARE_IMAGE='alpine'

ARG EXTEND1_IMAGE='alpine'
ARG EXTEND2_IMAGE='alpine'
ARG EXTEND3_IMAGE='alpine'
ARG EXTEND4_IMAGE='alpine'
ARG EXTEND5_IMAGE='alpine'

FROM ${EXTEND1_IMAGE} as IMAGE1

FROM ${EXTEND2_IMAGE} as IMAGE2

FROM ${EXTEND3_IMAGE} as IMAGE3

FROM ${EXTEND4_IMAGE} as IMAGE4

FROM ${EXTEND5_IMAGE} as IMAGE5


FROM ${ALPINE} as extend1
COPY --from=IMAGE1 / /

WORKDIR /tmp/out

ARG EXTEND1_CMD='echo "No command set for Preparing EXTEND1"'
ENV CMD ${EXTEND1_CMD}
RUN /bin/sh -c "${CMD}"




FROM ${ALPINE} as extend2
COPY --from=IMAGE2 / /

WORKDIR /tmp/out

ARG EXTEND2_CMD='echo "No command set for Preparing EXTEND2"'
ENV CMD ${EXTEND2_CMD}
RUN /bin/sh -c "${CMD}"




FROM ${ALPINE} as extend3
COPY --from=IMAGE3 / /

WORKDIR /tmp/out

ARG EXTEND3_CMD='echo "No command set for Preparing EXTEND3"'
ENV CMD ${EXTEND3_CMD}
RUN /bin/sh -c "${CMD}"



FROM ${ALPINE} as extend4
COPY --from=IMAGE4 / /

WORKDIR /tmp/out

ARG EXTEND4_CMD='echo "No command set for Preparing EXTEND4"'
ENV CMD ${EXTEND4_CMD}
RUN /bin/sh -c "${CMD}"



FROM ${EXTEND5_IMAGE} as extend5
COPY --from=IMAGE5 / /

WORKDIR /tmp/out

ARG EXTEND5_CMD='echo "No command set for Preparing EXTEND5"'
ENV CMD ${EXTEND5_CMD}
RUN /bin/sh -c "${CMD}"





FROM ${PREPARE_IMAGE} as prepare

# Copy all output from EXTEND1
COPY --from=extend1 /tmp/out /tmp/out

# Copy all output from EXTEND2
COPY --from=extend2 /tmp/out /tmp/out

# Copy all output from EXTEND2
COPY --from=extend3 /tmp/out /tmp/out

# Copy all output from EXTEND2
COPY --from=extend4 /tmp/out /tmp/out

# Copy all output from EXTEND2
COPY --from=extend5 /tmp/out /tmp/out


ARG POST_CMD="echo 'no post cmd'"
ENV POST_CMD=${POST_CMD}
RUN /bin/sh -c "${POST_CMD}"




FROM ${ALPINE} as certificates

RUN apk add --no-cache ca-certificates




FROM ${ALPINE} as prepareUser 

ARG USER=user
ARG UID=1000

ENV USER ${USER}
ENV UID ${UID}

RUN mkdir -p /tmp/out/etc \
  && echo "${USER}:x:${UID}:${UID}::/nonexistent:/sbin/nologin" > /tmp/out/etc/passwd \
  && echo "${USER}:x:${UID}:" > /tmp/out/etc/group




FROM ${FINAL_BASE} 
ARG BINARY_NAME
ARG USER=user

COPY --from=prepareUser /tmp/out /
COPY --from=prepare /tmp/out /
COPY --from=certificates /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/


USER ${USER}:${USER}
ENTRYPOINT ["/usr/bin/entrypoint"]