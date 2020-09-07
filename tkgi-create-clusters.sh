#! /usr/bin/env bash

set -euo pipefail

tkgi create-cluster harbor --external-hostname=k8s-harbor.lab.home --plan=small

tkgi create-cluster tbs --external-hostname=k8s-tbs.lab.home --plan=small

tkgi create-cluster concourse --external-hostname=k8s-concourse.lab.home --plan=small

tkgi create-cluster spring-petclinic-non-prod --external-hostname=k8s-spring-petclinic-non-prod.lab.home --plan=small

tkgi create-cluster spring-petclinic-prod --external-hostname=k8s-spring-petclinic-prod.lab.home --plan=small

tkgi create-cluster kubeapps --external-hostname=k8s-kubeapps.lab.home --plan=small