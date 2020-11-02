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

