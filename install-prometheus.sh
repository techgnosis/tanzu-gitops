#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a prometheus -f <(ytt --data-values-env=YTT_PROMETHEUS -f manifests/prometheus)