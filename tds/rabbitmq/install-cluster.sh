#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a rabbitmq-cluster \
-f <(ytt --data-values-env=YTT_HOMELAB \
-f cluster.yml \
-f values.yml)