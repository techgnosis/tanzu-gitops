#! /usr/bin/env bash

set -euo pipefail

tmc cluster attach --group jmusselwhite --name jmusselwhite-harbor
kubectx harbor && kapp deploy -a tmc -f k8s-attach-manifest.yaml -y
rm k8s-attach-manifest.yaml

tmc cluster attach --group jmusselwhite --name jmusselwhite-tbs
kubectx tbs && kapp deploy -a tmc -f k8s-attach-manifest.yaml -y
rm k8s-attach-manifest.yaml

tmc cluster attach --group jmusselwhite --name jmusselwhite-concourse
kubectx concourse && kapp deploy -a tmc -f k8s-attach-manifest.yaml -y
rm k8s-attach-manifest.yaml

tmc cluster attach --group jmusselwhite --name jmusselwhite-spring-petclinic-non-prod
kubectx spring-petclinic-non-prod && kapp deploy -a tmc -f k8s-attach-manifest.yaml -y
rm k8s-attach-manifest.yaml

tmc cluster attach --group jmusselwhite --name jmusselwhite-spring-petclinic-prod
kubectx spring-petclinic-prod && kapp deploy -a tmc -f k8s-attach-manifest.yaml -y
rm k8s-attach-manifest.yaml

tmc cluster attach --group jmusselwhite --name jmusselwhite-kubeapps
kubectx kubeapps && kapp deploy -a tmc -f k8s-attach-manifest.yaml -y
rm k8s-attach-manifest.yaml