#! /usr/bin/env bash

set -euo pipefail


helm install grafana grafana \
--repo https://charts.trials.tac.bitnami.com/demo \
--version 3.4.3 \
--wait \
--namespace grafana \
--create-namespace

kapp deploy -a grafana -f <(ytt --data-values-env=YTT_GRAFANA \
-f certificate.yml \
-f ingress.yml \
-f values.yml)