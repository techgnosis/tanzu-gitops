#! /usr/bin/env bash

set -euo pipefail

tkgi create-cluster harbor --external-hostname=k8s-harbor.$PRIMARY_DOMAIN --plan=small

tkgi create-cluster tbs --external-hostname=k8s-tbs.$PRIMARY_DOMAIN --plan=small

tkgi create-cluster concourse --external-hostname=k8s-concourse.$PRIMARY_DOMAIN --plan=small

tkgi create-cluster spring-petclinic --external-hostname=k8s-spring-petclinic.$PRIMARY_DOMAIN --plan=small

tkgi create-cluster product-api --external-hostname=k8s-product-api.$PRIMARY_DOMAIN --plan=small

tkgi create-cluster kubeapps --external-hostname=k8s-kubeapps.$PRIMARY_DOMAIN --plan=small

tkgi create-cluster tas --external-hostname=k8s-tas.$PRIMARY_DOMAIN --plan=small --num-nodes=5