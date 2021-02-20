#! /usr/bin/env bash

set -euo pipefail


kapp deploy -a harbor \
-f <(ytt --data-values-env=YTT_HOMELAB \
-f certificate.yml \
-f namespace.yml \
-f values.yml)

helm upgrade --install harbor harbor \
--repo https://charts.trials.tac.bitnami.com/demo \
--version 9.4.4 \
--values helm.yml \
--set externalURL="https://$HARBOR_DOMAIN" \
--set harborAdminPassword="$HARBOR_PASSWORD" \
--namespace harbor