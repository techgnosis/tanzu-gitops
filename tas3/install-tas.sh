#! /usr/bin/env bash

set -euo pipefail

kubectl apply \
-f https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.3.6/components.yaml

# This script is powered by `ytt`
# `ytt` is informed by environment variables. See `.envrc.template`
# YTT values files are required even when using YTT_ environment variables

if [ -d "tanzu-application-service" ]; then
    rm -rf tanzu-application-service
fi

tar -xvf tanzu-application-service.3.1.0-build.50.tar

cp tas3-values.yml configuration-values/values.yml

./tanzu-application-service/bin/generate-values.sh configuration-values
./tanzu-application-service/bin/cluster-detect.sh > configuration-values/cluster-values.yml
./tanzu-application-service/bin/install-tas.sh configuration-values

# Install the Certificate resource into istio-system so I can
# use it in configure-tas.sh
kapp deploy -a tas-tls -f <(ytt --data-values-env=YTT_TLSTAS \
-f certificate.yml \
-f values.yml)