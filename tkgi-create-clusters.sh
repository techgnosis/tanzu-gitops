#! /usr/bin/env bash

set -euo pipefail

tkgi create-cluster harbor --external-hostname=k8s-harbor.$PRIMARY_DOMAIN --plan=small

tkgi create-cluster tbs --external-hostname=k8s-tbs.$PRIMARY_DOMAIN --plan=small

tkgi create-cluster concourse --external-hostname=k8s-concourse.$PRIMARY_DOMAIN --plan=small

tkgi create-cluster spring-petclinic-non-prod --external-hostname=k8s-spring-petclinic-non-prod.$PRIMARY_DOMAIN --plan=small

tkgi create-cluster spring-petclinic-prod --external-hostname=k8s-spring-petclinic-prod.$PRIMARY_DOMAIN --plan=small

tkgi create-cluster kubeapps --external-hostname=k8s-kubeapps.$PRIMARY_DOMAIN --plan=small

tkgi create-cluster tas --external-hostname=k8s-tas.$PRIMARY_DOMAIN --plan=small --num-nodes=5