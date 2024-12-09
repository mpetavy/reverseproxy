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
