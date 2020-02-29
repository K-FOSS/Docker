PUSH_IMAGES="kristianfoss/programs-vault \
  kristianfoss/programs-step \
  kristianfoss/programs-keybase \
  kristianfjones/bin-installer \
  kristianfoss/builders-node \
  kristianfoss/programs-git \
  kristianfoss/programs-caddy \
  kristianfoss/programs-gomtr \
  kristianfoss/programs-mtr \
  kristianfoss/programs-teleport \
  kristianfoss/programs-openssh \
  kristianfoss/programs-gcloud"

docker buildx bake -f ./docker-compose.build.yml


for IMAGE in ${PUSH_IMAGES}; do
  docker push ${IMAGE}
done