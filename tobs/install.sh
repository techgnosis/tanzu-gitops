#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a tanzu-observability \
-f namespace.yml \
-f <(ytt --data-values-env=YTT_WAVEFRONT \
-f proxy) \
-f <(ytt --data-values-env=YTT_HOMELAB \
-f prometheus)