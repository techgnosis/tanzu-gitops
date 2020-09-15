#! /usr/bin/env bash

set -euo pipefail

kubectl patch gateway istio-ingressgateway \
--namespace cf-system \
--type='json' \
--patch='[{"op": "replace", "path": "/spec/servers/1/tls/credentialName", "value":"sys-domain-cert"}]'

kubectl patch gateway istio-ingressgateway \
--namespace cf-system \
--type='json' \
--patch='[{"op": "replace", "path": "/spec/servers/2/tls/credentialName", "value":"apps-domain-cert"}]'

cf api "api.$SYSTEM_DOMAIN"

export CF_ADMIN_PASSWORD="$(bosh interpolate tanzu-application-service/configuration-values/deployment-values.yml --path /cf_admin_password)"

cf auth admin "$CF_ADMIN_PASSWORD"

cf create-org test-org
cf create-space -o test-org test-space
cf target -o test-org -s test-space

if [ ! -d "test-app" ]; then
    git clone https://github.com/cloudfoundry-samples/test-app.git
fi

cf push test-app -p test-app
curl -k "https://test-app.apps.$SYSTEM_DOMAIN"


cf create-service-broker minibroker user pass http://minibroker-minibroker.minibroker.svc.cluster.local
# Postgres and RabbitMQ don't work despite the docs saying they do
cf enable-service-access redis
cf enable-service-access mysql
cf enable-service-access mongodb

