#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a demo-app-image \
-n demo-app \
-f <(ytt --data-values-env YTT_HOMELAB \
-f image.yml \
-f tbs-service-account.yml \
-f harbor-docker-creds.yml \
-f values.yaml)