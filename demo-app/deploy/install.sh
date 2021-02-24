#! /usr/bin/env bash

set -euo pipefail 




kapp deploy -a demo-app \
-f <(ytt --data-values-env=YTT_HOMELAB \
-f deployment.yml \
-f services.yml \
-f virtualservice.yml \
-f values.yaml)