#! /usr/bin/env bash

set -euo pipefail

CLUSTER_NAME=$1

tmc cluster attach \
--cluster-group $TMC_CLUSTER_GROUP_NAME \
--name $TMC_CLUSTER_GROUP_NAME-$CLUSTER_NAME \
--http-proxy-url "http://192.168.1.52:8888"

kapp deploy -a tmc -f k8s-attach-manifest.yaml
