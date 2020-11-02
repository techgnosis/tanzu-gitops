#! /usr/bin/env bash

set -euo pipefail


helm install loki loki \
--repo https://grafana.github.io/loki/charts \
--version 2.0.0 \
--namespace loki \
--create-namespace \
--values helm.yml \
--wait

kapp deploy -a loki -f <(ytt --data-values-env=YTT_LOKI \
-f certificate-loki.yml \
-f ingress-loki.yml \
-f values.yml)


