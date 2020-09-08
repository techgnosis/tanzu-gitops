#! /usr/bin/env bash

set -euo pipefail

kapp deploy \
-a metrics-server \
--wait \
-f https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.3.6/components.yaml

export YTT_TAS_app_registry__hostname="harbor.lab.home"
export YTT_TAS_app_registry__repository="library"
export YTT_TAS_app_registry__username="admin"
export YTT_TAS_app_registry__password="Harbor12345"
export YTT_TAS_app_registry_ca=$(cat "$(mkcert --CAROOT)"/rootCA.pem)


export YTT_TAS_system_registry__hostname="registry.pivotal.io"
export YTT_TAS_system_registry__username=""
export YTT_TAS_system_registry__password=""

export SYSTEM_DOMAIN="sys.tas.lab.home"

./tanzu-application-service/bin/generate-values.sh -d "${SYSTEM_DOMAIN}" > ./tanzu-application-service/configuration-values/deployment-values.yml

./tanzu-application-service/bin/install-tas.sh ./tanzu-application-service/configuration-values