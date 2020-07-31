#! /usr/bin/env bash

set -euo pipefail

TAG=$1

IMAGE=harbor.lab.home/library/concourse-helper

IMAGE_TAG=$IMAGE:$TAG

docker build -t $IMAGE_TAG .

docker tag $IMAGE_TAG $IMAGE:latest

docker push $IMAGE_TAG
docker push $IMAGE:latest