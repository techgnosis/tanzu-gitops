#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a wavefront-proxy -f <(ytt --data-values-env=YTT_WAVEFRONT \
-f wavefront-proxy.yaml \
-f namespace.yml \
-f values.yml \
-f telegraf.yml \
-f config.yml)