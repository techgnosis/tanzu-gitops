#! /usr/bin/env bash

set -euo pipefail


kapp deploy -a loki -f <(ytt --data-values-env=YTT_LOKI \
-f certificate-grafana.yml \
-f certificate-loki.yml \
-f ingress-grafana.yml \
-f ingress-loki.yml \
-f loki.yml \
-f namespace.yml \
-f values.yml)