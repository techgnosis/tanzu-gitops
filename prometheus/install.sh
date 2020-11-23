#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a prometheus -f <(ytt --data-values-env=YTT_PROMETHEUS \
-f certificate.yml \
-f clusterrole.yml \
-f clusterrolebinding.yml \
-f config.yml \
-f ingress.yml \
-f namespace.yml \
-f sa.yml \
-f values.yml \
-f prometheus.yml)