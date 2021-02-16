#! /usr/bin/env bash

set -euo pipefail


helm upgrade --install harbor harbor \
--repo https://charts.trials.tac.bitnami.com/demo \
--version 9.4.4 \
--values helm.yml \
--set externalURL="https://$HARBOR_DOMAIN" \
--set harborAdminPassword="$HARBOR_PASSWORD" \
--namespace harbor \
--create-namespace


kapp deploy -a harbor -f <(ytt --data-values-env=YTT_HOMELAB \
-f virtualservice.yml \
-f virtualservice-notary.yml \
-f values.yml)