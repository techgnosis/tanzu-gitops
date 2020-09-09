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

tmc cluster attach --group $TMC_CLUSTER_GROUP_NAME --name $TMC_CLUSTER_GROUP_NAME-spring-petclinic
kubectx spring-petclinic && kapp deploy -a tmc -f k8s-attach-manifest.yaml -y
rm k8s-attach-manifest.yaml

tmc cluster attach --group $TMC_CLUSTER_GROUP_NAME --name $TMC_CLUSTER_GROUP_NAME-product-api
kubectx product-api && kapp deploy -a tmc -f k8s-attach-manifest.yaml -y
rm k8s-attach-manifest.yaml

tmc cluster attach --group $TMC_CLUSTER_GROUP_NAME --name $TMC_CLUSTER_GROUP_NAME-kubeapps
kubectx kubeapps && kapp deploy -a tmc -f k8s-attach-manifest.yaml -y
rm k8s-attach-manifest.yaml