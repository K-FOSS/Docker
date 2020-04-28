#!/bin/sh
BUILDER_IMAGE="$(docker build --build-arg CLI_NAME=docker -q ./Docker/)"

echo ${BUILDER_IMAGE}