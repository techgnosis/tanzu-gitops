#! /usr/bin/env bash

set -euo pipefail

helm repo add fluxcd https://charts.fluxcd.io

export VERSION="1.1.0"

kapp deploy \
-a helm-operator \
--into-ns=helm-operator \
-f manifests/helm-operator/namespace.yml \
-f https://raw.githubusercontent.com/fluxcd/helm-operator/$VERSION/deploy/crds.yaml \
-f <(helm template helm-operator fluxcd/helm-operator \
--namespace helm-operator \
--set helm.versions=v3 \
--version $VERSION)