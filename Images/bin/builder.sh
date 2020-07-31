#!/bin/sh
BUILDER_NAME="BuildXBuilder"



# Check if the builder already exists
if [ ! "$(docker buildx ls | grep ${BUILDER_NAME})" ]; then
  echo "Creating the builder"
  

  docker buildx create --use --name ${BUILDER_NAME}

  docker buildx inspect --bootstrap ${BUILDER_NAME}
fi
