#! /usr/bin/env bash

set -euo pipefail

docker pull registry.pivotal.io/tanzu-mysql-for-kubernetes/tanzu-mysql-instance:0.2.0
docker tag registry.pivotal.io/tanzu-mysql-for-kubernetes/tanzu-mysql-instance:0.2.0 $HARBOR_DOMAIN/library/tanzu-mysql-instance:0.2.0
docker push $HARBOR_DOMAIN/library/tanzu-mysql-instance:0.2.0

docker pull registry.pivotal.io/tanzu-mysql-for-kubernetes/tanzu-mysql-operator:0.2.0
docker tag registry.pivotal.io/tanzu-mysql-for-kubernetes/tanzu-mysql-operator:0.2.0 $HARBOR_DOMAIN/library/tanzu-mysql-operator:0.2.0
docker push $HARBOR_DOMAIN/library/tanzu-mysql-operator:0.2.0