#! /usr/bin/env bash

set -euo pipefail

tmc cluster delete --forget $TMC_CLUSTER_GROUP_NAME-harbor
kubectx harbor && kapp delete -a tmc

tmc cluster delete --forget $TMC_CLUSTER_GROUP_NAME-tbs
kubectx tbs && kapp delete -a tmc

tmc cluster delete --forget $TMC_CLUSTER_GROUP_NAME-concourse
kubectx concourse && kapp delete -a tmc

tmc cluster delete --forget $TMC_CLUSTER_GROUP_NAME-spring-petclinic-non-prod
kubectx spring-petclinic-non-prod && kapp delete -a tmc

tmc cluster delete --forget $TMC_CLUSTER_GROUP_NAME-spring-petclinic-prod
kubectx spring-petclinic-prod && kapp delete -a tmc

tmc cluster delete --forget $TMC_CLUSTER_GROUP_NAME-kubeapps
kubectx kubeapps && kapp delete -a tmc