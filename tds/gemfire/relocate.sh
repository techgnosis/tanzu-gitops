#! /usr/bin/env bash

set -euo pipefail

docker pull registry.pivotal.io/tanzu-gemfire-for-kubernetes/gemfire-controller:1.0.0
docker tag registry.pivotal.io/tanzu-gemfire-for-kubernetes/gemfire-controller:1.0.0 $HARBOR_DOMAIN/library/gemfire-controller:1.0.0
docker push $HARBOR_DOMAIN/library/gemfire-controller:1.0.0


docker pull registry.pivotal.io/tanzu-gemfire-for-kubernetes/gemfire-k8s:1.0.0
docker tag registry.pivotal.io/tanzu-gemfire-for-kubernetes/gemfire-k8s:1.0.0 $HARBOR_DOMAIN/library/gemfire-k8s:1.0.0
docker push $HARBOR_DOMAIN/library/gemfire-k8s:1.0.0