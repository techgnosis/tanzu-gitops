#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a demo-app-image \
-n demo-app \
-f <(REGISTRY_PASSWORD=Harbor12345 kp secret create harbor-creds \
--registry harbor.lab.home \
--registry-user admin \
--dry-run \
--output yaml \
-n demo-app) \
-f <(ytt --data-values-env YTT_HOMELAB \
-f image.yml \
-f values.yaml)