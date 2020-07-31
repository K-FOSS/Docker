#!/bin/bash
BASEDIR=$(dirname "$0")

# BUILDER="${BASEDIR}/buildBuilder.sh"
# DOCKER_IMAGE="$(${BUILDER})"
# RUNNER="${BASEDIR}/runner.sh ${DOCKER_IMAGE}"

PUSH_IMAGES="kristianfoss/source-pgweb \\
  kristianfoss/programs-pgweb \
  kristianfoss/source-coredns \
  kristianfoss/programs-coredns \
  kristianfoss/source-teleport \
  kristianfoss/programs-teleport \
  kristianfoss/source-cloudflared \
  kristianfoss/programs-cloudflared \
  kristianfoss/source-gomtr \
  kristianfoss/programs-gomtr \
  kristianfoss/source-git \
  kristianfoss/programs-git \
  kristianfoss/source-hugo \
  kristianfoss/programs-hugo \
  kristianfoss/source-theia \
  kristianfoss/source-yq \
  kristianfoss/programs-yq \
  kristianfoss/source-docker \
  kristianfoss/programs-docker \

  kristianfoss/source-rootlesskit \
  kristianfoss/programs-rootlesskit \
  kristianfoss/source-vpnkit \
  kristianfoss/programs-vpnkit \
  kristianfoss/source-keybase \
  kristianfoss/programs-keybase \
  kristianfoss/source-step-cli \
  kristianfoss/programs-step \
  kristianfoss/source-step-certificates \
  kristianfoss/programs-step-certificates \
  kristianfoss/source-photoprism \
  kristianfoss/source-prometheus \
  kristianfoss/programs-prometheus \
  kristianfoss/source-prometheus-alertmanager \
  kristianfoss/programs-prometheus-alertmanager \
  kristianfoss/source-prometheus-node-exporter \
  kristianfoss/programs-prometheus-node-exporter \
  kristianfoss/source-plex-prometheus-exporter \
  kristianfoss/programs-plex-prometheus-exporter \
  kristianfoss/source-blackbox-prometheus-exporter \
  kristianfoss/programs-blackbox-prometheus-exporter \
  kristianfoss/source-statsd-prometheus-exporter \
  kristianfoss/programs-statsd-prometheus-exporter \
  kristianfoss/source-graphite-prometheus-exporter \
  kristianfoss/programs-graphite-prometheus-exporter \
  kristianfoss/source-netdata \
  kristianfoss/programs-netdata \
  kristianfoss/source-cadvisor \
  kristianfoss/programs-cadvisor \
  kristianfoss/source-caddy \
  kristianfoss/programs-caddy \
  kristianfoss/source-zsh \
  kristianfoss/programs-zsh \
  kristianfoss/source-grafana \
  kristianfoss/programs-grafana \
  kristianfoss/source-busybox \
  kristianfoss/programs-busybox \
  kristianfoss/source-librespeed \
  kristianfoss/programs-librespeed \
  kristianfoss/source-openssh \
  kristianfoss/programs-openssh \
  kristianfoss/source-goping \
  kristianfoss/source-duplicati \
  kristianfoss/source-postfix \
  kristianfoss/source-bagisto \
  kristianfoss/source-rclone \
  kristianfoss/programs-rclone"


cd "${BASEDIR}/../Extras/Builder/"
./setup.sh
docker-compose up -d --build

docker-compose exec -T -w /workspace Docker docker login -u ${USERNAME} -p ${PASSWORD} 
docker-compose exec -T -w /workspace Docker docker buildx bake --pull -f ./docker-compose.build.source.yml
docker-compose exec -T -w /workspace Docker docker buildx bake --pull -f ./docker-compose.build.yml
docker-compose exec -T -w /workspace Docker docker buildx bake --pull -f ./docker-compose.build.extend.yml
docker-compose exec -T -w /workspace Docker docker image ls

# ${RUNNER} buildx bake -f ./docker-compose.build.yml


for IMAGE in ${PUSH_IMAGES}; do
  docker-compose exec -T -w /workspace Docker docker push ${IMAGE}
done