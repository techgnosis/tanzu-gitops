#! /usr/bin/env bash

set -euo pipefail

ytt --data-values-env=YTT_KUBEAPPS -f manifests/kubeapps \
| kapp deploy -a kubeapps -f- -y