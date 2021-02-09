#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a prometheus -f <(ytt --data-values-env=YTT_HOMELAB \
-f clusterrole.yml \
-f clusterrolebinding.yml \
-f config.yml \
-f virtualservice.yml \
-f namespace.yml \
-f sa.yml \
-f values.yml \
-f prometheus.yml)