#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a wavefront-proxy -f <(ytt --data-values-env=YTT_WAVEFRONT \
-f wavefront.yaml \
-f namespace.yml \
-f values.yml)