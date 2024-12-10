#!/bin/sh

set -e
set -x

APP=reverseproxy
SRC_PATH=$(realpath .)

docker build \
--no-cache \
-t $APP \
-f Dockerfile \
--progress=plain \
$SRC_PATH

docker login --username $DOCKER_ZEISS_USERNAME --password $DOCKER_ZEISS_PAT
docker image tag $APP:latest docker.io/$DOCKER_ZEISS_USERNAME/$APP:latest
docker image push docker.io/$DOCKER_ZEISS_USERNAME/$APP:latest
