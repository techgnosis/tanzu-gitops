#! /usr/bin/env bash

set -euo pipefail

tmc cluster delete --forget $TMC_CLUSTER_GROUP_NAME-harbor
kubectx harbor && kapp delete -a tmc

tmc cluster delete --forget $TMC_CLUSTER_GROUP_NAME-tbs
kubectx tbs && kapp delete -a tmc

tmc cluster delete --forget $TMC_CLUSTER_GROUP_NAME-concourse
kubectx concourse && kapp delete -a tmc

tmc cluster delete --forget $TMC_CLUSTER_GROUP_NAME-spring-petclinic
kubectx spring-petclinic && kapp delete -a tmc

tmc cluster delete --forget $TMC_CLUSTER_GROUP_NAME-product-api
kubectx product-api && kapp delete -a tmc

tmc cluster delete --forget $TMC_CLUSTER_GROUP_NAME-kubeapps
kubectx kubeapps && kapp delete -a tmc

tmc cluster delete --forget $TMC_CLUSTER_GROUP_NAME-tas
kubectx tas && kapp delete -a tmc