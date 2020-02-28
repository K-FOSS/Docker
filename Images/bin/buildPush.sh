PUSH_IMAGES="kristianfoss/programs-vault kristianfoss/programs-step kristianfoss/programs-keybase kristianfjones/bin-installer kristianfoss/builders-node"

docker buildx bake -f ./docker-compose.build.yml


for IMAGE in ${PUSH_IMAGES}; do
  docker push ${IMAGE}
done