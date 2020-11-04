#! /usr/bin/env bash

set -euo pipefail

cf api "api.$SYSTEM_DOMAIN"

export CF_ADMIN_PASSWORD="$(bosh interpolate configuration-values/_generated-values.yml --path /cf_admin_password)"

cf auth admin "$CF_ADMIN_PASSWORD"

cf create-org test-org
cf create-space -o test-org test-space
cf target -o test-org -s test-space

