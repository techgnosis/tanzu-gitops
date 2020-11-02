#! /usr/bin/env bash

set -euo pipefail


helm upgrade --install kubeapps kubeapps \
--repo https://charts.trials.tac.bitnami.com/demo \
--version 4.0.2 \
--namespace kubeapps \
--create-namespace \
--wait \
--values=helm.yml

kapp deploy -a kubeapps -f <(ytt --data-values-env=YTT_KUBEAPPS \
-f certificate.yml \
-f ingress.yml \
-f values.yml \
-f service-account.yml \
-f cluster-role-binding.yml)