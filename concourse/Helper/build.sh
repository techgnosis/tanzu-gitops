#! /usr/bin/env bash

set -euo pipefail

IMAGE=$1
TAG=$2

IMAGE_TAG=$IMAGE:$TAG

docker build -t $IMAGE_TAG .

docker tag $IMAGE_TAG $IMAGE:latest

docker push $IMAGE_TAG
docker push $IMAGE:latest