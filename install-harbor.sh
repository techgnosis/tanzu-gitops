#! /usr/bin/env bash

set -euo pipefail

ytt --data-values-env=YTT_HARBOR -f manifests/harbor \
| kapp deploy -a harbor -f- -y