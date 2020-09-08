#! /usr/bin/env bash

set -euo pipefail

tmc cluster attach --group $TMC_CLUSTER_GROUP_NAME --name $TMC_CLUSTER_GROUP_NAME-harbor
kubectx harbor && kapp deploy -a tmc -f k8s-attach-manifest.yaml -y
rm k8s-attach-manifest.yaml

tmc cluster attach --group $TMC_CLUSTER_GROUP_NAME --name $TMC_CLUSTER_GROUP_NAME-tbs
kubectx tbs && kapp deploy -a tmc -f k8s-attach-manifest.yaml -y
rm k8s-attach-manifest.yaml

tmc cluster attach --group $TMC_CLUSTER_GROUP_NAME --name $TMC_CLUSTER_GROUP_NAME-concourse
kubectx concourse && kapp deploy -a tmc -f k8s-attach-manifest.yaml -y
rm k8s-attach-manifest.yaml

tmc cluster attach --group $TMC_CLUSTER_GROUP_NAME --name $TMC_CLUSTER_GROUP_NAME-spring-petclinic-non-prod
kubectx spring-petclinic-non-prod && kapp deploy -a tmc -f k8s-attach-manifest.yaml -y
rm k8s-attach-manifest.yaml

tmc cluster attach --group $TMC_CLUSTER_GROUP_NAME --name $TMC_CLUSTER_GROUP_NAME-spring-petclinic-prod
kubectx spring-petclinic-prod && kapp deploy -a tmc -f k8s-attach-manifest.yaml -y
rm k8s-attach-manifest.yaml

tmc cluster attach --group $TMC_CLUSTER_GROUP_NAME --name $TMC_CLUSTER_GROUP_NAME-kubeapps
kubectx kubeapps && kapp deploy -a tmc -f k8s-attach-manifest.yaml -y
rm k8s-attach-manifest.yaml