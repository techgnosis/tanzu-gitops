#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a grafana -f <(ytt --data-values-env=YTT_GRAFANA -f manifests/grafana)