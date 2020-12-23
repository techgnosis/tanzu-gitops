#! /usr/bin/env bash

set -euo pipefail

CLUSTER_NAME=$1

tmc cluster attach --cluster-group $TMC_CLUSTER_GROUP_NAME --name $TMC_CLUSTER_GROUP_NAME-$CLUSTER_NAME
kapp deploy -a tmc -f k8s-attach-manifest.yaml
rm k8s-attach-manifest.yaml
