#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a prometheus \
-f <(ytt --data-values-env=YTT_HOMELAB \
-f namespace.yml \
-f clusterrole.yml \
-f clusterrolebinding.yml \
-f config.yml \
-f deployment.yml \
-f sa.yml \
-f values.yml \
-f virtualservice.yml)