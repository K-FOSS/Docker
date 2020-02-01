#!/bin/sh
DOT_COUNT=$(cat .count 2>&1)
OLD_VERSION=${DOT_COUNT:-0}
echo $OLD_VERSION

NEW_VERSION=$(($OLD_VERSION + 1))
APP_NAME="Web"
CONFIG_NAME="Caddyfile"

export CADDY2_IMAGE=$(docker build -q ./Caddy2)
echo ${CADDY2_IMAGE}


export CONFIG_VERSION=${NEW_VERSION}

echo $NEW_VERSION > .count

docker stack deploy --compose-file=./docker-compose.yml $APP_NAME