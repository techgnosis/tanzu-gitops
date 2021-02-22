#! /usr/bin/env bash

set -euo pipefail

CONFIG=$1

kapp deploy -a metallb \
-f "${CONFIG}" \
-f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml \
-f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml \
-f <(kubectl -n metallb-system create secret generic memberlist \
--from-literal=secretkey="$(openssl rand -base64 128)" \
--dry-run=client \
-o yaml)





# helm upgrade --install metallb metallb \
# --repo https://charts.bitnami.com/bitnami \
# --version 0.9.5 \
# --namespace metallb-system \
# --set existingConfigMap=config \
# --wait

