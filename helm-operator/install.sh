#! /usr/bin/env bash

set -euo pipefail

helm repo add fluxcd https://charts.fluxcd.io

export VERSION="1.1.0"

kubectl apply -f https://raw.githubusercontent.com/fluxcd/helm-operator/$VERSION/deploy/crds.yaml

helm upgrade -i helm-operator fluxcd/helm-operator \
--namespace helm-operator \
--create-namespace \
--set helm.versions=v3 \
--version $VERSION