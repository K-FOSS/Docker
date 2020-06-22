ARG EXTEND_IMAGE='alpine'
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




FROM ${FINAL_BASE} 
ARG BINARY_NAME
ARG USER

COPY --from=prepare /tmp/out /


USER ${USER}
ENTRYPOINT ["/usr/bin/entrypoint"]