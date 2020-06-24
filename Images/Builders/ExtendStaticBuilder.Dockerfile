ARG EXTEND_IMAGE='alpine'
ARG ALPINE='alpine'
ARG FINAL_BASE='alpine'
ARG PREPARE_IMAGE='alpine'

FROM ${EXTEND_IMAGE} as extend




FROM ${PREPARE_IMAGE} as prepare

ARG EXTEND_SRC_PATH='/'
ARG EXTEND_DEST_PATH='/'

COPY --from=extend ${EXTEND_SRC_PATH} /tmp/out/${EXTEND_DEST_PATH}


ARG POST_CMD="echo 'no post cmd'"
ENV POST_CMD=${POST_CMD}
RUN /bin/sh -c "${POST_CMD}"




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
ARG USER

COPY --from=prepareUser /tmp/out /
COPY --from=prepare /tmp/out /


USER ${USER}:${USER}
ENTRYPOINT ["/usr/bin/entrypoint"]