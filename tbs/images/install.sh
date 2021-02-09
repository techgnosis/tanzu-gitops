#! /usr/bin/env bash

set -euo pipefail

kapp deploy -a images -f <(ytt --data-values-env=YTT_HOMELAB -f .)