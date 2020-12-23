#! /usr/bin/env bash

set -euo pipefail


helm upgrade --install kubeapps kubeapps \
--repo https://charts.trials.tac.bitnami.com/demo \
--version 5.0.0 \
--namespace kubeapps \
--create-namespace \
--wait \
--values=helm.yml

# Note - the service account is for logging in to the dashboard
# It is not something that can be created via the Helm chart

kapp deploy -a kubeapps -f <(ytt --data-values-env=YTT_KUBEAPPS \
-f gateway.yml \
-f virtualservice.yml \
-f values.yml \
-f service-account.yml \
-f cluster-role-binding.yml)