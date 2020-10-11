#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a grafana -f <(ytt --data-values-env=YTT_GRAFANA \
-f certificate.yml \
-f grafana.yml \
-f ingress.yml \
-f namespace.yml \
-f values.yml)