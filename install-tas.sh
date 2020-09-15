#! /usr/bin/env bash

set -euo pipefail

kubectl apply \
-f https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.3.6/components.yaml

# This script is powered by `ytt`
# `ytt` is informed by YTT_* environment variables. See `.envrc`
# Note: the files app-registry-values.yml and system-registry-values.yml are still required
# YTT values files are required even when using YTT_ environment variables

./tanzu-application-service/bin/generate-values.sh -d "${SYSTEM_DOMAIN}" > ./tanzu-application-service/configuration-values/deployment-values.yml

./tanzu-application-service/bin/install-tas.sh ./tanzu-application-service/configuration-values

kapp deploy -a tas-tls -f manifests/tas