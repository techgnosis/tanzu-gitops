#! /usr/bin/env bash

set -euo pipefail


kapp deploy -a kubeapps -f <(ytt --data-values-env=YTT_KUBEAPPS -f manifests/kubeapps)