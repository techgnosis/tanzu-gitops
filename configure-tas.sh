#! /usr/bin/env bash

set -euo pipefail

cf api "api.$SYSTEM_DOMAIN" --skip-ssl-validation

CF_ADMIN_PASSWORD="$(bosh interpolate tanzu-application-service/configuration-values/deployment-values.yml --path /cf_admin_password)"

cf auth admin "$CF_ADMIN_PASSWORD"

cf create-org test-org
cf create-space -o test-org test-space
cf target -o test-org -s test-space

if [ ! -d "test-app" ]; then
    git clone https://github.com/cloudfoundry-samples/test-app.git
fi

cf push test-app -p test-app
curl -k "https://test-app.apps.$SYSTEM_DOMAIN"