#! /usr/bin/env bash

set -euo pipefail

# Metrics server already exists in TKGI
#echo "Installing Metrics Server"
#kubectl apply \
#-f https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.3.6/components.yaml

if [ -d "tanzu-application-service" ]; then
    rm -rf tanzu-application-service
fi

tar -xvf tanzu-application-service.0.6.0-build.1.tar

cp tas3-values.yml configuration-values/values.yml
cp apps-manager-values.yml configuration-values/

./tanzu-application-service/bin/generate-values.sh configuration-values
./tanzu-application-service/bin/cluster-detect.sh > configuration-values/cluster-values.yml
./tanzu-application-service/bin/install-tas.sh configuration-values