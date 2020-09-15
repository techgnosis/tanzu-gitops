#! /usr/bin/env bash

set -euo pipefail

tmc cluster attach --group $TMC_CLUSTER_GROUP_NAME --name $TMC_CLUSTER_GROUP_NAME-$1
kubectl config use-context $1 && kapp deploy -a tmc -f k8s-attach-manifest.yaml -y
rm k8s-attach-manifest.yaml
