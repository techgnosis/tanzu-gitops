#! /usr/bin/env bash

set -euo pipefail 

DBTYPE=$1



kapp deploy -a demo-app \
-f <(ytt --data-values-env=YTT_HOMELAB \
-f deployment-$DBTYPE.yml \
-f services.yml \
-f virtualservice.yml \
-f values.yaml)