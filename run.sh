#!/bin/sh

LOCAL_PORT=$1
REMOTE_HOST=$2
REMOTE_PORT=$3

echo $LOCAL_PORT

docker run --rm -p $LOCAL_PORT:$LOCAL_PORT -e LOCAL_PORT=$1 -e REMOTE_HOST=$2 -e REMOTE_PORT=$3 reverseproxy
