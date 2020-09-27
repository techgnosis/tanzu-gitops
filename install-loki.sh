#! /usr/bin/env bash

set -euo pipefail


kapp deploy -a loki -f <(ytt --data-values-env=YTT_LOKI -f manifests/loki)