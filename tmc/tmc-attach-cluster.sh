#! /usr/bin/env bash

set -euo pipefail

CONTEXT=$1

tmc cluster attach --cluster-group $TMC_CLUSTER_GROUP_NAME --name $TMC_CLUSTER_GROUP_NAME-$CONTEXT
kubectl config use-context $CONTEXT && kapp deploy -a tmc -f k8s-attach-manifest.yaml
rm k8s-attach-manifest.yaml
