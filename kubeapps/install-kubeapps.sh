#! /usr/bin/env bash

set -euo pipefail


helm install kubeapps kubeapps \
--repo https://charts.bitnami.com/bitnami \
--version 4.0.1 \
--namespace kubeapps \
--create-namespace \
--wait \
--set useHelm3="true"

kapp deploy -a kubeapps -f <(ytt --data-values-env=YTT_KUBEAPPS \
-f certificate.yml \
-f cluster-role-binding.yml \
-f ingress.yml \
-f service-account.yml \
-f values.yml)